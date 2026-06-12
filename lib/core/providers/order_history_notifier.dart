import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order.dart';
import '../repositories/order_repository.dart';
import '../services/connectivity_service.dart';
import 'menu_notifier.dart' show DataFreshness;
import 'shift_notifier.dart';

class OrderHistoryState {
  final List<Order>   orders;
  final bool          isLoading;
  final DataFreshness freshness;
  final String?       error;
  final String?       shiftId;

  const OrderHistoryState({
    this.orders    = const [],
    this.isLoading = false,
    this.freshness = DataFreshness.stale,
    this.error,
    this.shiftId,
  });

  // Backwards compat for any code still referencing .fromCache
  bool get fromCache => freshness != DataFreshness.live;

  OrderHistoryState copyWith({
    List<Order>?   orders,
    bool?          isLoading,
    DataFreshness? freshness,
    String?        error,
    String?        shiftId,
    bool           clearError = false,
  }) =>
      OrderHistoryState(
        orders:    orders    ?? this.orders,
        isLoading: isLoading ?? this.isLoading,
        freshness: freshness ?? this.freshness,
        error:     clearError ? null : (error ?? this.error),
        shiftId:   shiftId   ?? this.shiftId,
      );
}

class OrderHistoryNotifier extends Notifier<OrderHistoryState> {
  @override
  OrderHistoryState build() {
    // Drop the previous shift's orders the moment the active shift changes —
    // otherwise the history screen keeps showing Shift A after Shift B opens
    // until something manually calls loadForShift.
    ref.listen(shiftProvider, (prev, next) {
      final prevId = prev?.shift?.id;
      final nextId = next.shift?.id;
      if (prevId == nextId) return;
      if (nextId == null) {
        state = const OrderHistoryState();
      } else if (state.shiftId != null && state.shiftId != nextId) {
        state = const OrderHistoryState();
        loadForShift(nextId);
      }
    });
    return const OrderHistoryState();
  }

  /// Two-phase load:
  /// 1. Paint local cache instantly (zero-latency offline-safe first frame).
  /// 2. Background network refresh; on success emit fresh state.
  Future<void> loadForShift(String shiftId, {bool force = false}) async {
    if (!force &&
        state.shiftId == shiftId &&
        state.orders.isNotEmpty &&
        state.freshness == DataFreshness.live) { return; }

    final repo     = ref.read(orderRepositoryProvider);
    final isOnline = ConnectivityService.instance.isOnline;

    // ── Phase 1: local paint ─────────────────────────────────────────────
    final local = repo.loadOrdersLocal(shiftId);
    if (local != null) {
      state = state.copyWith(
        orders:    local,
        shiftId:   shiftId,
        isLoading: isOnline,
        freshness: isOnline ? DataFreshness.stale : DataFreshness.offline,
        clearError: true,
      );
    } else {
      state = state.copyWith(isLoading: true, shiftId: shiftId, clearError: true);
    }

    if (!isOnline) return;

    // ── Phase 2: background refresh ──────────────────────────────────────
    try {
      final orders = await repo.fetchOrdersFresh(shiftId);
      state = state.copyWith(
        isLoading: false,
        orders:    orders,
        shiftId:   shiftId,
        freshness: DataFreshness.live,
        clearError: true,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        freshness: DataFreshness.offline,
        error: state.orders.isEmpty
            ? 'Could not load orders — check connection'
            : null,
      );
    }
  }

  Future<void> refresh(String shiftId) => loadForShift(shiftId, force: true);

  // ── Mutation helpers ─────────────────────────────────────────────────────
  // Money paths await these: the order must be durably cached before the
  // teller sees a receipt, or a crash makes a placed order invisible locally.

  Future<void> addOrder(Order order) async {
    if (state.orders.any((o) => o.id == order.id)) return;
    final updated = [order, ...state.orders];
    state = state.copyWith(orders: updated, shiftId: state.shiftId ?? order.shiftId);
    final shiftId = state.shiftId ?? order.shiftId;
    await ref.read(orderRepositoryProvider).saveOrdersToCache(shiftId, updated);
  }

  Future<void> replaceOrder(String localId, Order synced) async {
    final idx = state.orders.indexWhere((o) => o.id == localId);
    if (idx >= 0) {
      final updated = List<Order>.of(state.orders)..[idx] = synced;
      state = state.copyWith(orders: updated);
      if (state.shiftId != null) {
        await ref
            .read(orderRepositoryProvider)
            .saveOrdersToCache(state.shiftId!, updated);
      }
    } else {
      await addOrder(synced);
    }
  }

  Future<void> updateOrder(Order updated) async {
    final newOrders =
        state.orders.map((o) => o.id == updated.id ? updated : o).toList();
    state = state.copyWith(orders: newOrders);
    if (state.shiftId != null) {
      await ref
          .read(orderRepositoryProvider)
          .saveOrdersToCache(state.shiftId!, newOrders);
    }
  }

  void clear() => state = const OrderHistoryState();
}

final orderHistoryProvider =
    NotifierProvider<OrderHistoryNotifier, OrderHistoryState>(
        OrderHistoryNotifier.new);
