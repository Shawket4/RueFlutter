import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/delivery_order.dart';
import '../repositories/delivery_order_repository.dart';
import '../services/connectivity_service.dart';
import 'menu_notifier.dart' show DataFreshness;
import 'shift_notifier.dart';

class DeliveryOrdersState {
  final List<DeliveryOrder> orders;
  final bool isLoading;
  final DataFreshness freshness;
  final String? error;
  final String? branchId;

  const DeliveryOrdersState({
    this.orders = const [],
    this.isLoading = false,
    this.freshness = DataFreshness.stale,
    this.error,
    this.branchId,
  });

  /// Active (non-terminal) orders — what the queue + drawer badge count.
  List<DeliveryOrder> get active =>
      orders.where((o) => o.status.isActive).toList();

  int get activeCount => orders.where((o) => o.status.isActive).length;

  /// Brand-new orders awaiting acceptance (status == received). Drives the
  /// attention (pulse + danger badge) on the order screen's Delivery button.
  int get newCount =>
      orders.where((o) => o.status == DeliveryStatus.received).length;

  bool get fromCache => freshness != DataFreshness.live;

  DeliveryOrdersState copyWith({
    List<DeliveryOrder>? orders,
    bool? isLoading,
    DataFreshness? freshness,
    String? error,
    String? branchId,
    bool clearError = false,
  }) =>
      DeliveryOrdersState(
        orders: orders ?? this.orders,
        isLoading: isLoading ?? this.isLoading,
        freshness: freshness ?? this.freshness,
        error: clearError ? null : (error ?? this.error),
        branchId: branchId ?? this.branchId,
      );
}

/// Pure state container + cache writer for the delivery queue. It does NOT own
/// any polling/SSE — [DeliveryRealtimeService] drives realtime updates and calls
/// [loadForBranch] / [applyServerOrder] on this notifier. That keeps a single
/// fetch path and a single place to decide what counts as a "new" order.
class DeliveryOrdersNotifier extends Notifier<DeliveryOrdersState> {
  @override
  DeliveryOrdersState build() {
    // Drop the previous branch's queue the moment the open shift closes — the
    // realtime service tears down independently, this is belt-and-braces so the
    // drawer badge can't keep counting a closed shift's orders.
    ref.listen(shiftProvider, (prev, next) {
      final hadShift = prev?.shift != null;
      final hasShift = next.shift != null;
      if (hadShift && !hasShift) state = const DeliveryOrdersState();
    });
    return const DeliveryOrdersState();
  }

  /// Two-phase load (mirrors [OrderHistoryNotifier.loadForShift]):
  /// 1. Paint local cache instantly (offline-safe first frame).
  /// 2. Background network refresh; on success emit fresh state.
  Future<void> loadForBranch(String branchId, {bool force = false}) async {
    if (!force &&
        state.branchId == branchId &&
        state.orders.isNotEmpty &&
        state.freshness == DataFreshness.live) {
      return;
    }

    final repo = ref.read(deliveryOrderRepositoryProvider);
    final isOnline = ConnectivityService.instance.isOnline;

    // ── Phase 1: local paint ─────────────────────────────────────────────
    final local = repo.loadDeliveryOrdersLocal(branchId);
    if (local != null) {
      state = state.copyWith(
        orders: local,
        branchId: branchId,
        isLoading: isOnline,
        freshness: isOnline ? DataFreshness.stale : DataFreshness.offline,
        clearError: true,
      );
    } else {
      state =
          state.copyWith(isLoading: true, branchId: branchId, clearError: true);
    }

    if (!isOnline) {
      if (local == null) {
        state = state.copyWith(
            isLoading: false, freshness: DataFreshness.offline);
      }
      return;
    }

    // ── Phase 2: background refresh ──────────────────────────────────────
    try {
      final orders = await repo.fetchDeliveryOrdersFresh(branchId);
      state = state.copyWith(
        isLoading: false,
        orders: orders,
        branchId: branchId,
        freshness: DataFreshness.live,
        clearError: true,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        freshness: DataFreshness.offline,
        error: state.orders.isEmpty
            ? 'Could not load delivery orders — check connection'
            : null,
      );
    }
  }

  Future<void> refresh() async {
    final branchId = state.branchId;
    if (branchId == null) return;
    await loadForBranch(branchId, force: true);
  }

  /// Set the per-order extra prep time (non-negative multiple of 5) and mirror
  /// the server-returned order back into the list + cache.
  Future<void> setPrepTime(String id, int extraPrepMinutes) async {
    final updated = await ref
        .read(deliveryOrderRepositoryProvider)
        .setPrepTime(id, extraPrepMinutes);
    await upsertOrder(updated);
  }

  /// Apply a server-returned order (from an action, SSE event, or single GET)
  /// into the list + cache. Semantic alias used by the realtime service.
  Future<void> applyServerOrder(DeliveryOrder order) => upsertOrder(order);

  /// Mirror a server-returned order back into the list + cache. Awaited so the
  /// cache is durable before any UI/alert reacts.
  Future<void> upsertOrder(DeliveryOrder order) async {
    final idx = state.orders.indexWhere((o) => o.id == order.id);
    final List<DeliveryOrder> updated;
    if (idx >= 0) {
      updated = List<DeliveryOrder>.of(state.orders)..[idx] = order;
    } else {
      updated = [order, ...state.orders];
    }
    state = state.copyWith(orders: updated);
    final branchId = state.branchId ?? order.branchId;
    await ref
        .read(deliveryOrderRepositoryProvider)
        .saveDeliveryOrdersToCache(branchId, updated);
  }

  void clear() => state = const DeliveryOrdersState();
}

final deliveryOrdersProvider =
    NotifierProvider<DeliveryOrdersNotifier, DeliveryOrdersState>(
        DeliveryOrdersNotifier.new);
