import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order.dart';
import '../repositories/order_repository.dart';
import '../services/connectivity_service.dart';
import 'menu_notifier.dart' show DataFreshness;

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
  OrderHistoryState build() => const OrderHistoryState();

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

  void addOrder(Order order) {
    if (state.orders.any((o) => o.id == order.id)) return;
    final updated = [order, ...state.orders];
    state = state.copyWith(orders: updated);
    if (state.shiftId != null) {
      ref.read(orderRepositoryProvider).saveOrdersToCache(state.shiftId!, updated);
    }
  }

  void replaceOrder(String localId, Order synced) {
    final idx = state.orders.indexWhere((o) => o.id == localId);
    if (idx >= 0) {
      final updated = List<Order>.of(state.orders)..[idx] = synced;
      state = state.copyWith(orders: updated);
      if (state.shiftId != null) {
        ref.read(orderRepositoryProvider).saveOrdersToCache(state.shiftId!, updated);
      }
    } else {
      addOrder(synced);
    }
  }

  void updateOrder(Order updated) {
    final newOrders =
        state.orders.map((o) => o.id == updated.id ? updated : o).toList();
    state = state.copyWith(orders: newOrders);
    if (state.shiftId != null) {
      ref.read(orderRepositoryProvider).saveOrdersToCache(state.shiftId!, newOrders);
    }
  }

  void clear() => state = const OrderHistoryState();
}

final orderHistoryProvider =
    NotifierProvider<OrderHistoryNotifier, OrderHistoryState>(
        OrderHistoryNotifier.new);
