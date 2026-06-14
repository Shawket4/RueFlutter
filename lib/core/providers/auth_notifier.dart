import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/branch_api.dart';
import '../api/client.dart';
import '../api/shift_api.dart';
import '../models/branch.dart';
import '../models/shift.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart'
    show authRepositoryProvider, DeviceSetupError, WrongCredentialsError, OpenShiftBlockError;
import '../services/offline_queue.dart';
import '../storage/storage_service.dart';
import '../utils/app_log.dart';
import 'cart_notifier.dart';
import 'draft_carts_notifier.dart';

enum SessionExpiry { none, expired, blockedByOtherShift }

class AuthState {
  final bool isLoading;
  final User? user;
  final Branch? branch;
  final String? error;
  final SessionExpiry sessionExpiry;
  final String? blockedByName;

  /// True when the teller got in via the offline PIN unlock: there is no
  /// valid token, every write queues, and the outbox stays parked until a
  /// real online login happens.
  final bool isOfflineSession;

  /// Org tax rate as a decimal (e.g. 0.14 = 14%). Carried from /auth/login &
  /// /auth/me so the cart can compute a tax-inclusive total. 0.0 when the org
  /// has no tax or the server predates the field.
  final double taxRate;

  const AuthState({
    this.isLoading = true,
    this.user,
    this.branch,
    this.error,
    this.sessionExpiry = SessionExpiry.none,
    this.blockedByName,
    this.isOfflineSession = false,
    this.taxRate = 0.0,
  });

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    bool? isLoading,
    User? user,
    Branch? branch,
    String? error,
    SessionExpiry? sessionExpiry,
    String? blockedByName,
    bool? isOfflineSession,
    double? taxRate,
    bool clearUser = false,
    bool clearBranch = false,
    bool clearError = false,
    bool clearBlocked = false,
  }) =>
      AuthState(
        isLoading: isLoading ?? this.isLoading,
        user: clearUser ? null : (user ?? this.user),
        branch: clearBranch ? null : (branch ?? this.branch),
        error: clearError ? null : (error ?? this.error),
        sessionExpiry: sessionExpiry ?? this.sessionExpiry,
        blockedByName:
            clearBlocked ? null : (blockedByName ?? this.blockedByName),
        isOfflineSession: isOfflineSession ?? this.isOfflineSession,
        taxRate: taxRate ?? this.taxRate,
      );
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    onUnauthorizedCallback = () {
      // An offline session has no valid token by definition — stray 401s
      // (e.g. connectivity returning mid-order) must not kick the teller out
      // and interrupt a sale. The persistent banner already asks them to
      // sign in; the queue is parked until they do.
      if (state.user != null && !state.isOfflineSession) {
        _forceLogout(expiry: SessionExpiry.expired);
      }
    };
    Future.microtask(init);
    return const AuthState();
  }

  /// Offline PIN unlock: restores the teller's cached identity without a
  /// token so selling can continue through an outage. All writes queue; the
  /// outbox stays parked until a real online login refreshes the token.
  Future<String?> offlineUnlock(
      {required String name, required String pin}) async {
    final user = ref
        .read(authRepositoryProvider)
        .verifyOfflineUnlock(name: name, pin: pin);
    if (user == null) {
      const msg = 'Offline sign-in failed — name or PIN not recognized on '
          'this device';
      state = state.copyWith(isLoading: false, error: msg);
      return msg;
    }

    Branch? branch;
    if (user.branchId != null) {
      final cached =
          ref.read(storageServiceProvider).loadBranch(user.branchId!);
      if (cached != null) branch = _tryDecodeBranch(cached);
    }

    // No token: park the queue before exposing the session so a drain can't
    // race ahead and burn 401s.
    ref.read(offlineQueueProvider.notifier).pauseForAuth();
    state = AuthState(
      isLoading: false,
      user: user,
      branch: branch,
      isOfflineSession: true,
    );
    return null;
  }

  void clearError() => state = state.copyWith(clearError: true); // Task 1.8

  void setError(String err) => state = state.copyWith(error: err);

  Future<void> init() async {
    state = state.copyWith(isLoading: true);
    final session = await ref.read(authRepositoryProvider).restoreSession();
    if (session == null) {
      state = const AuthState(isLoading: false);
      return;
    }
    await _hydrateAfterAuth(session.user,
        taxRate: session.taxRate, emitLoading: false);
  }

  /// Step 1 of device setup: manager credentials → branch list.
  Future<({String? error, List<Branch> branches})> fetchBranchesForSetup({
    required String email,
    required String password,
  }) async {
    try {
      final branches = await ref
          .read(authRepositoryProvider)
          .setupDevice(email: email, password: password);
      return (error: null, branches: branches);
    } on DeviceSetupError catch (e) {
      return (error: e.message, branches: <Branch>[]);
    } catch (e) {
      return (error: friendlyError(e), branches: <Branch>[]);
    }
  }

  /// Step 2 of device setup: manager picked a branch — persist device config.
  /// The setup screen navigates to /login afterwards (the router redirect
  /// only re-evaluates on auth-state changes or navigation events).
  Future<void> confirmBranch(Branch branch) =>
      ref.read(authRepositoryProvider).confirmDeviceBranch(branch);

  Future<String?> login({required String name, required String pin}) async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
      clearBlocked: true,
      sessionExpiry: SessionExpiry.none,
    );
    try {
      final session =
          await ref.read(authRepositoryProvider).login(name: name, pin: pin);
      final blockError = await _hydrateAfterAuth(session.user,
          taxRate: session.taxRate, emitLoading: true);
      return blockError;
    } on OpenShiftBlockError catch (e) {
      // Backend refused login: this user already has an open shift somewhere.
      // Show it as an error state and log it for diagnostics.
      AppLog.warn('auth.login', 'blocked — user already has an open shift: ${e.message}');
      state = state.copyWith(isLoading: false, error: e.message);
      return e.message;
    } on WrongCredentialsError {
      const msg = 'Wrong name or PIN.';
      state = state.copyWith(isLoading: false, error: msg);
      return msg;
    } catch (e) {
      final msg = friendlyError(e);
      state = state.copyWith(isLoading: false, error: msg);
      return msg;
    }
  }

  Future<String?> _hydrateAfterAuth(User user,
      {required double taxRate, required bool emitLoading}) async {
    if (emitLoading) state = state.copyWith(isLoading: true);

    Branch? branch;
    if (user.branchId != null) {
      try {
        branch = await ref.read(branchApiProvider).get(user.branchId!);
        await ref
            .read(storageServiceProvider)
            .saveBranch(user.branchId!, branch.toJson());
      } catch (_) {
        final cached =
            ref.read(storageServiceProvider).loadBranch(user.branchId!);
        if (cached != null) branch = _tryDecodeBranch(cached);
      }
    }

    if (user.branchId != null) {
      try {
        final preFill =
            await ref.read(shiftApiProvider).current(user.branchId!);
        final openShift = preFill.openShift;

        if (openShift != null &&
            openShift.isOpen &&
            openShift.tellerId != user.id) {
          await ref.read(authRepositoryProvider).logout();
          final msg = 'Branch has an open shift belonging to '
              '"${openShift.tellerName}". '
              'That shift must be closed before anyone else can sign in.';
          state = AuthState(
            isLoading: false,
            sessionExpiry: SessionExpiry.blockedByOtherShift,
            blockedByName: openShift.tellerName,
            error: msg,
          );
          return msg;
        }

        if (openShift != null) {
          await ref
              .read(storageServiceProvider)
              .saveShift(user.branchId!, openShift.toJson());
        }
      } catch (_) {
        // Network error during shift check — allow login
      }
    }

    state = state.copyWith(
      isLoading: false,
      user: user,
      branch: branch,
      taxRate: taxRate,
      clearError: true,
      clearBlocked: true,
      sessionExpiry: SessionExpiry.none,
      isOfflineSession: false,
    );

    // Push the session tax rate into the cart so its getters produce a
    // tax-inclusive total. The cart can't depend on auth (auth invalidates
    // the cart on logout — that would be circular), so auth pushes instead.
    ref.read(cartProvider.notifier).applyTaxRate(taxRate);

    // A fresh token means a 401-parked outbox can sync again.
    ref.read(offlineQueueProvider.notifier).resumeAfterAuth();
    return null;
  }

  Future<bool> canLogout() async {
    final branchId = state.user?.branchId;
    if (branchId == null) return true;
    try {
      final preFill = await ref.read(shiftApiProvider).current(branchId);
      return !(preFill.openShift?.isOpen ?? false);
    } catch (_) {
      final cached = ref.read(storageServiceProvider).loadShift(branchId);
      if (cached != null) {
        final shift = Shift.fromJson(cached);
        return !shift.isOpen;
      }
      return true;
    }
  }

  Future<void> _clearCartSession() async {
    await ref.read(storageServiceProvider).clearAllCartStorage();
    ref.invalidate(cartProvider);
    ref.invalidate(draftCartsProvider);
  }

  Future<void> logout() async {
    await _clearCartSession();
    await ref.read(authRepositoryProvider).logout();
    state = const AuthState(isLoading: false);
  }

  // Task 1.7: Await logout
  Future<void> _forceLogout({required SessionExpiry expiry}) async {
    // Deliberately does NOT clear cart/draft storage: a forced logout (401)
    // can land mid-order, and the cart is keyed by {branchId}_{shiftId} so it
    // restores intact after the teller signs back in.
    await ref.read(authRepositoryProvider).logout();
    state = AuthState(isLoading: false, sessionExpiry: expiry);
  }

  /// Pre-migration branch caches may miss keys the generated fromJson
  /// requires — treat an undecodable cache as a miss, not a crash.
  static Branch? _tryDecodeBranch(Map<String, dynamic> cached) {
    try {
      return Branch.fromJson(cached);
    } catch (_) {
      return null;
    }
  }
}

final authProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
