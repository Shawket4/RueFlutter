import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../api/client.dart';
import '../models/inventory.dart';
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
import 'payment_method_notifier.dart';

class ShiftState {
  final bool               isLoading;
  final Shift?             shift;
  final int                suggestedOpeningCash;
  final List<InventoryItem> inventory;
  final int                systemCash;
  final bool               systemCashLoading;
  final String?            error;
  final DataFreshness      freshness;
  final bool               isLocalShift;

  const ShiftState({
    this.isLoading            = false,
    this.shift,
    this.suggestedOpeningCash = 0,
    this.inventory            = const [],
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
    bool?                isLoading,
    Shift?               shift,
    int?                 suggestedOpeningCash,
    List<InventoryItem>? inventory,
    int?                 systemCash,
    bool?                systemCashLoading,
    String?              error,
    DataFreshness?       freshness,
    bool?                isLocalShift,
    bool                 clearShift = false,
    bool                 clearError = false,
  }) =>
      ShiftState(
        isLoading:            isLoading            ?? this.isLoading,
        shift:                clearShift ? null    : (shift ?? this.shift),
        suggestedOpeningCash: suggestedOpeningCash ?? this.suggestedOpeningCash,
        inventory:            inventory            ?? this.inventory,
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

    if (!isOnline) return;

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

  Future<bool> openShift(String branchId, int openingCash) async {
    state = state.copyWith(isLoading: true, clearError: true);
    final isOnline = ConnectivityService.instance.isOnline;

    if (isOnline) {
      try {
        final shift =
            await ref.read(shiftRepositoryProvider).openShift(branchId, openingCash);
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
    required List<Map<String, dynamic>> inventoryCounts,
  }) async {
    if (state.shift == null) return false;
    state = state.copyWith(isLoading: true, clearError: true);

    final isOnline = ConnectivityService.instance.isOnline;
    if (!isOnline) {
      state = state.copyWith(
          isLoading: false, error: 'Internet required to close shift');
      return false;
    }

    final shiftId   = state.shift!.id;
    final cartScope = cartStorageScope(state.shift);

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
      state = state.copyWith(systemCash: cash, systemCashLoading: false);
    } catch (_) {
      state = state.copyWith(systemCashLoading: false);
    }
  }

  Future<void> loadInventory(String branchId) async {
    final repo     = ref.read(shiftRepositoryProvider);
    final isOnline = ConnectivityService.instance.isOnline;

    // Phase 1: local
    final local = repo.loadInventoryLocal(branchId);
    if (local != null) state = state.copyWith(inventory: local);

    if (!isOnline) return;

    // Phase 2: refresh
    try {
      final items = await repo.fetchInventoryFresh(branchId);
      state = state.copyWith(inventory: items);
    } catch (_) {
      // keep local
    }
  }
}

final shiftProvider =
    NotifierProvider<ShiftNotifier, ShiftState>(ShiftNotifier.new);
