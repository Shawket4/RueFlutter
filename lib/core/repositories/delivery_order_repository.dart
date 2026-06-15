import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import '../api/delivery_api.dart';
import '../db/app_database.dart';
import '../models/delivery_order.dart';
import '../storage/storage_service.dart';

/// Local-first delivery-order reads, mirroring [OrderRepository]: a synchronous
/// cache paint (`loadDeliveryOrdersLocal`) followed by a network refresh
/// (`fetchDeliveryOrdersFresh`) that persists and bumps `sync_meta`. Keyed by
/// branch — the delivery queue is branch-scoped, not shift-scoped.
class DeliveryOrderRepository {
  final DeliveryApi _api;
  final StorageService _storage;
  final AppDatabase _db;

  DeliveryOrderRepository(this._api, this._storage, this._db);

  // ── Freshness / sync_meta ────────────────────────────────────────────────

  Future<bool> isStale(String entity, {int ttlMs = 5 * 60 * 1000}) async {
    final db = await _db.db;
    final rows = await db.query(
      'sync_meta',
      columns: ['last_synced_at'],
      where: 'entity = ?',
      whereArgs: [entity],
      limit: 1,
    );
    if (rows.isEmpty) return true;
    final ts = rows.first['last_synced_at'] as int?;
    if (ts == null) return true;
    return DateTime.now().millisecondsSinceEpoch - ts > ttlMs;
  }

  Future<void> _bumpSyncMeta(String entity) async {
    final db = await _db.db;
    await db.insert(
      'sync_meta',
      {'entity': entity, 'last_synced_at': DateTime.now().millisecondsSinceEpoch},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ── Local-first reads ────────────────────────────────────────────────────

  /// Returns cached delivery orders immediately (null if no cache / corrupt).
  List<DeliveryOrder>? loadDeliveryOrdersLocal(String branchId) {
    final cached = _storage.loadDeliveryOrders(branchId);
    if (cached == null) return null;
    try {
      return cached.map(DeliveryOrder.fromJson).toList();
    } catch (_) {
      return null;
    }
  }

  /// Fetches fresh delivery orders from network, persists them, bumps sync_meta.
  Future<List<DeliveryOrder>> fetchDeliveryOrdersFresh(String branchId) async {
    final orders = await _api.listDeliveryOrders(branchId: branchId);
    await _storage.saveDeliveryOrders(
        branchId, orders.map((o) => o.toJson()).toList());
    await _bumpSyncMeta('delivery_orders:$branchId');
    return orders;
  }

  // ── Cache write helper (called by DeliveryOrdersNotifier) ────────────────

  Future<void> saveDeliveryOrdersToCache(
          String branchId, List<DeliveryOrder> current) =>
      _storage.saveDeliveryOrders(
          branchId, current.map((o) => o.toJson()).toList());

  // ── Realtime stream (opened by DeliveryRealtimeService) ──────────────────

  Future<ResponseBody> openStream({
    required String branchId,
    String? status,
    CancelToken? cancelToken,
  }) =>
      _api.openStream(
          branchId: branchId, status: status, cancelToken: cancelToken);

  // ── Mutations (delegate to the API) ──────────────────────────────────────

  Future<DeliveryOrder> getDeliveryOrder(String id) =>
      _api.getDeliveryOrder(id);

  Future<DeliveryOrder> setStatus(String id, DeliveryStatus status) =>
      _api.setStatus(id, status.wire);

  Future<DeliveryOrder> setPrepTime(String id, int extraPrepMinutes) =>
      _api.setPrepTime(id, extraPrepMinutes);

  Future<DeliveryOrder> cancel(String id,
          {String? reason, bool restoreInventory = true}) =>
      _api.cancel(id, reason: reason, restoreInventory: restoreInventory);

  Future<DeliveryFinalizeResult> finalize(String id,
          {required String shiftId, required String paymentMethod}) =>
      _api.finalize(id, shiftId: shiftId, paymentMethod: paymentMethod);
}

final deliveryOrderRepositoryProvider =
    Provider<DeliveryOrderRepository>((ref) => DeliveryOrderRepository(
          ref.watch(deliveryApiProvider),
          ref.watch(storageServiceProvider),
          AppDatabase.instance,
        ));
