import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import '../api/order_api.dart';
import '../db/app_database.dart';
import '../models/cart.dart';
import '../models/order.dart';
import '../storage/storage_service.dart';

class OrderRepository {
  final OrderApi       _api;
  final StorageService _storage;
  final AppDatabase    _db;

  OrderRepository(this._api, this._storage, this._db);

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

  // ── Order creation ───────────────────────────────────────────────────────

  Future<Order> create({
    required String branchId,
    required String shiftId,
    required CartState cart,
    required String idempotencyKey,
    String? customerName,
    String? discountType,
    int? discountValue,
    String? discountId,
    int? amountTendered,
    int? tipAmount,
    String? tipPaymentMethod,
    List<PaymentSplit>? paymentSplits,
    DateTime? createdAt,
  }) =>
      _api.create(
        branchId:        branchId,
        shiftId:         shiftId,
        paymentMethod:   cart.payment,
        items:           cart.items,
        customerName:    customerName ?? cart.customerName,
        discountType:    discountType ?? cart.discountType?.apiValue,
        discountValue:   discountValue ?? cart.discountValue,
        discountId:      discountId ?? cart.discountId,
        amountTendered:  amountTendered ?? cart.amountTendered,
        tipAmount:       tipAmount ?? cart.tipAmount,
        tipPaymentMethod: tipPaymentMethod,
        paymentSplits:   paymentSplits ?? cart.paymentSplits,
        idempotencyKey:  idempotencyKey,
        createdAt:       createdAt,
      );

  // ── Local-first reads ────────────────────────────────────────────────────

  /// Returns cached orders immediately (may be null if no cache).
  List<Order>? loadOrdersLocal(String shiftId) {
    final cached = _storage.loadOrders(shiftId);
    if (cached == null) return null;
    try {
      return cached.map(Order.fromJson).toList();
    } catch (_) {
      return null;
    }
  }

  /// Fetches fresh orders from network, persists them, bumps sync_meta.
  Future<List<Order>> fetchOrdersFresh(String shiftId) async {
    final orders = await _api.list(shiftId: shiftId);
    await _storage.saveOrders(shiftId, orders.map((o) => o.toJson()).toList());
    await _bumpSyncMeta('orders:$shiftId');
    return orders;
  }

  // ── Void ────────────────────────────────────────────────────────────────

  Future<Order> voidOrder(String id,
          {String? reason, bool restoreInventory = false}) =>
      _api.voidOrder(id,
          reason: reason ?? 'No reason provided',
          restoreInventory: restoreInventory);

  // ── Cache write helpers (called by OrderHistoryNotifier) ─────────────────

  void saveOrdersToCache(String shiftId, List<Order> current) {
    _storage.saveOrders(shiftId, current.map((o) => o.toJson()).toList());
  }

  List<Order>? loadCachedOrders(String shiftId) => loadOrdersLocal(shiftId);

  /// Fetches a single order by ID from the API (includes line items).
  Future<Order> getOrder(String id) => _api.get(id);
}

final orderRepositoryProvider =
    Provider<OrderRepository>((ref) => OrderRepository(
          ref.watch(orderApiProvider),
          ref.watch(storageServiceProvider),
          AppDatabase.instance,
        ));
