import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/order_api.dart';
import '../models/cart.dart';
import '../models/order.dart';
import '../storage/storage_service.dart';

class OrderRepository {
  final OrderApi _api;
  final StorageService _storage;
  OrderRepository(this._api, this._storage);

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
        branchId: branchId,
        shiftId: shiftId,
        paymentMethod: cart.payment,
        items: cart.items,
        customerName: customerName ?? cart.customerName,
        discountType: discountType ?? cart.discountType?.apiValue,
        discountValue: discountValue ?? cart.discountValue,
        discountId: discountId ?? cart.discountId,
        amountTendered: amountTendered ?? cart.amountTendered,
        tipAmount: tipAmount ?? cart.tipAmount,
        tipPaymentMethod: tipPaymentMethod,
        paymentSplits: paymentSplits ?? cart.paymentSplits,
        idempotencyKey: idempotencyKey,
        createdAt: createdAt,
      );

  Future<List<Order>> listForShift(String shiftId) async {
    try {
      final orders = await _api.list(shiftId: shiftId);
      await _storage.saveOrders(
          shiftId, orders.map((o) => o.toJson()).toList());
      return orders;
    } catch (_) {
      final cached = _storage.loadOrders(shiftId);
      if (cached != null) return cached.map(Order.fromJson).toList();
      rethrow;
    }
  }

  Future<Order> get(String id) async {
    try {
      final order = await _api.get(id);
      await _storage.saveOrders('single_$id', [order.toJson()]);
      return order;
    } catch (_) {
      final cachedList = _storage.loadOrders('single_$id');
      if (cachedList != null && cachedList.isNotEmpty) {
        return Order.fromJson(cachedList.first);
      }
      rethrow;
    }
  }

  Future<Order> voidOrder(String id,
          {String? reason, bool restoreInventory = false}) =>
      _api.voidOrder(id,
          reason: reason ?? 'No reason provided',
          restoreInventory: restoreInventory);

  void saveOrdersToCache(String shiftId, List<Order> current) {
    _storage.saveOrders(shiftId, current.map((o) => o.toJson()).toList());
  }

  List<Order>? loadCachedOrders(String shiftId) {
    final cached = _storage.loadOrders(shiftId);
    if (cached == null) return null;
    return cached.map(Order.fromJson).toList();
  }
}

final orderRepositoryProvider =
    Provider<OrderRepository>((ref) => OrderRepository(
          ref.watch(orderApiProvider),
          ref.watch(storageServiceProvider),
        ));
