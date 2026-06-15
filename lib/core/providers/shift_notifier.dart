import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../api/client.dart';
import '../models/pending_action.dart';
import '../models/shift.dart';
import '../repositories/shift_repository.dart';
import '../services/connectivity_service.dart';
import '../services/offline_queue.dart';
import '../storage/storage_service.dart';
import '../utils/time_utils.dart';
import 'auth_notifier.dart';
import 'cart_storage.dart';
import 'menu_notifier.dart' show DataFreshness;

class ShiftState {
  final bool               isLoading;
  final Shift?             shift;
  final int                suggestedOpeningCash;
  final int                systemCash;
  final bool               systemCashLoading;
  final String?            error;
  final DataFreshness      freshness;
  final bool               isLocalShift;

  const ShiftState({
    this.isLoading            = false,
    this.shift,
    this.suggestedOpeningCash = 0,
    this.systemCash           = 0,
    this.systemCashLoading    = false,
    this.error,
    this.freshness            = DataFreshness.stale,
    this.isLocalShift         = false,
  });

  bool get hasOpenShift => shift?.isOpen ?? false;

  // Backwards compat
  bool get fromCache => freshness != DataFreshness.live;

  ShiftState copyWith({
    bool?          isLoading,
    Shift?         shift,
    int?           suggestedOpeningCash,
    int?           systemCash,
    bool?          systemCashLoading,
    String?        error,
    DataFreshness? freshness,
    bool?          isLocalShift,
    bool           clearShift = false,
    bool           clearError = false,
  }) =>
      ShiftState(
        isLoading:            isLoading            ?? this.isLoading,
        shift:                clearShift ? null    : (shift ?? this.shift),
        suggestedOpeningCash: suggestedOpeningCash ?? this.suggestedOpeningCash,
        systemCash:           systemCash           ?? this.systemCash,
        systemCashLoading:    systemCashLoading    ?? this.systemCashLoading,
        error:                clearError ? null    : (error ?? this.error),
        freshness:            freshness            ?? this.freshness,
        isLocalShift:         isLocalShift         ?? this.isLocalShift,
      );
}

class ShiftNotifier extends Notifier<ShiftState> {
  @override
  ShiftState build() => const ShiftState();

  void updateShiftSynced(Shift shift) {
    state = state.copyWith(shift: shift, isLocalShift: false);
  }

  /// Seeds shift state from data already fetched during auth hydration,
  /// before isLoading goes false so the router redirect can read it.
  void seedFromAuth(Shift? shift) {
    state = shift != null
        ? state.copyWith(shift: shift, clearError: true)
        : state.copyWith(clearShift: true, clearError: true);
  }

  /// Phase-1 only load: reads local storage and updates state instantly.
  /// Used when auth hydration failed to reach the network.
  void loadLocal(String branchId) {
    final local = ref.read(shiftRepositoryProvider).loadShiftLocal(branchId);
    if (local == null) return;
    state = state.copyWith(
      shift: local.openShift,
      suggestedOpeningCash: local.suggestedOpeningCash,
      clearShift: local.openShift == null,
      clearError: true,
    );
  }

  /// Two-phase load:
  /// 1. Paint local cache instantly (offline-safe first frame).
  /// 2. Background network refresh; on success emit fresh state.
  Future<void> load(String branchId) async {
    final repo     = ref.read(shiftRepositoryProvider);
    final isOnline = ConnectivityService.instance.isOnline;

    // ── Phase 1: serve local immediately ──────────────────────────────────
    final local = repo.loadShiftLocal(branchId);
    if (local != null) {
      state = state.copyWith(
        shift:                local.openShift,
        suggestedOpeningCash: local.suggestedOpeningCash,
        freshness:            isOnline ? DataFreshness.stale : DataFreshness.offline,
        isLoading:            isOnline,
        isLocalShift:         false,
        clearShift:           local.openShift == null,
        clearError:           true,
      );
    } else {
      state = state.copyWith(isLoading: true, clearError: true);
    }

    if (!isOnline) {
      // No cache + offline used to leave isLoading=true forever.
      if (local == null) {
        state = state.copyWith(
          isLoading: false,
          freshness: DataFreshness.offline,
          error: 'No connection and no cached shift data yet',
        );
      }
      return;
    }

    // ── Phase 2: background refresh ───────────────────────────────────────
    try {
      final preFill = await repo.fetchShiftFresh(branchId);
      state = state.copyWith(
        isLoading:            false,
        shift:                preFill.openShift,
        suggestedOpeningCash: preFill.suggestedOpeningCash,
        freshness:            DataFreshness.live,
        isLocalShift:         false,
        clearShift:           preFill.openShift == null,
        clearError:           true,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        freshness: DataFreshness.offline,
        error:     state.shift == null
            ? 'Could not load shift — check connection'
            : null,
      );
    }
  }

  /// `editReason` is supplied by the open-shift screen when the entered opening
  /// cash differs from the carried-over closing; the backend requires it on a
  /// deviation and derives `opening_cash_was_edited` itself.
  Future<bool> openShift(String branchId, int openingCash, {String? editReason}) async {
    state = state.copyWith(isLoading: true, clearError: true);
    final isOnline = ConnectivityService.instance.isOnline;

    if (isOnline) {
      try {
        final shift = await ref
            .read(shiftRepositoryProvider)
            .openShift(branchId, openingCash, editReason: editReason);
        state = state.copyWith(
            isLoading: false, shift: shift, isLocalShift: false,
            freshness: DataFreshness.live);
        return true;
      } catch (e) {
        state = state.copyWith(isLoading: false, error: friendlyError(e));
        return false;
      }
    }

    // ── Offline: create a local optimistic shift ──────────────────────────
    final user = ref.read(authProvider).user;
    if (user == null) {
      state = state.copyWith(isLoading: false, error: 'User not authenticated');
      return false;
    }

    final shiftId    = const Uuid().v4();
    final now        = TimeUtils.now();
    final localShift = Shift(
      id:          shiftId,
      branchId:    branchId,
      tellerId:    user.id,
      tellerName:  user.name,
      status:      'open',
      openingCash: openingCash,
      openingCashWasEdited: editReason != null,
      openingCashEditReason: editReason,
      openedAt:    now,
    );

    await ref.read(storageServiceProvider).saveShift(branchId, localShift.toJson());
    await ref.read(offlineQueueProvider.notifier).enqueueShiftOpen(
      PendingShiftOpen(
        localId:     const Uuid().v4(),
        createdAt:   now,
        branchId:    branchId,
        shiftId:     shiftId,
        openingCash: openingCash,
        openedAt:    now,
        editReason:  editReason,
      ),
    );

    state = state.copyWith(
        isLoading: false, shift: localShift, isLocalShift: true,
        freshness: DataFreshness.stale);
    return true;
  }

  Future<bool> closeShift({
    required String branchId,
    required int    closingCash,
    String?         note,
    List<Map<String, dynamic>> inventoryCounts = const [],
  }) async {
    if (state.shift == null) return false;
    state = state.copyWith(isLoading: true, clearError: true);

    final shiftId   = state.shift!.id;
    final cartScope = cartStorageScope(state.shift);

    final isOnline = ConnectivityService.instance.isOnline;
    final offlineSession = ref.read(authProvider).isOfflineSession;
    if (!isOnline || offlineSession) {
      // Queue the close. The server close endpoint is idempotent and the
      // drain only processes a shiftClose after every order/void for the
      // shift has synced or died, so ordering is safe.
      final now = TimeUtils.now();
      await ref.read(offlineQueueProvider.notifier).enqueueShiftClose(
        PendingShiftClose(
          localId:         const Uuid().v4(),
          createdAt:       now,
          branchId:        branchId,
          shiftId:         shiftId,
          closingCash:     closingCash,
          cashNote:        note,
          inventoryCounts: inventoryCounts,
          closedAt:        now,
        ),
      );
      if (cartScope != null) {
        await ref.read(storageServiceProvider).clearCartDataForScope(cartScope);
      }
      await ref.read(storageServiceProvider).removeShift(branchId);
      state = state.copyWith(isLoading: false, clearShift: true, systemCash: 0);
      return true;
    }

    try {
      await ref.read(shiftRepositoryProvider).closeShift(
        shiftId,
        branchId:        branchId,
        closingCash:     closingCash,
        note:            note,
        inventoryCounts: inventoryCounts,
      );
      if (cartScope != null) {
        await ref.read(storageServiceProvider).clearCartDataForScope(cartScope);
      }
      await ref.read(storageServiceProvider).removeShift(branchId);
      state = state.copyWith(isLoading: false, clearShift: true, systemCash: 0);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: friendlyError(e));
      return false;
    }
  }

  /// A queued offline shift-open was permanently rejected by the server (another
  /// shift already holds this branch/teller open). Clear the phantom local shift
  /// so the teller is routed back to the open-shift screen instead of continuing
  /// to sell against a shift the server will never accept.
  Future<void> handleOpenRejected(String branchId) async {
    await ref.read(storageServiceProvider).removeShift(branchId);
    state = state.copyWith(
      clearShift: true,
      isLocalShift: false,
      systemCash: 0,
      error: 'Your shift could not be opened — another shift is already open for '
          'this branch. Please reconcile, then open a new shift.',
    );
  }

  void addLocalCash(int amount) {
    state = state.copyWith(systemCash: state.systemCash + amount);
  }

  Future<void> loadSystemCash() async {
    final shift = state.shift;
    if (shift == null) return;
    state = state.copyWith(systemCashLoading: true);
    try {
      final cash = await ref
          .read(shiftRepositoryProvider)
          .getSystemCash(shift.id, shift.openingCash);
      // The server's expected-cash figure can't know about cash orders still
      // sitting in the outbox — add them, or the drawer guidance drops every
      // time a refresh lands while offline orders are queued.
      state = state.copyWith(
        systemCash: cash + _queuedCashForShift(shift.id),
        systemCashLoading: false,
      );
    } catch (_) {
      state = state.copyWith(systemCashLoading: false);
    }
  }

  /// Cash taken for orders that are still in the outbox for [shiftId].
  /// Includes dead entries: the money is physically in the drawer whether or
  /// not the sync succeeded.
  int _queuedCashForShift(String shiftId) {
    var sum = 0;
    for (final e in ref.read(offlineQueueProvider).entries) {
      if (e.type != PendingActionType.order.name) continue;
      final p = e.payloadMap;
      if (p['shift_id'] != shiftId) continue;
      sum += (p['cash_amount'] as num?)?.toInt() ?? 0;
    }
    return sum;
  }

}

final shiftProvider =
    NotifierProvider<ShiftNotifier, ShiftState>(ShiftNotifier.new);
