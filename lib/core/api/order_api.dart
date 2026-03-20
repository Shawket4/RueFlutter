import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'client.dart';
import '../models/order.dart';

class OrderApi {
  Future<Order> create({
    required String branchId,
    required String shiftId,
    required String paymentMethod,
    required List<CartItem> items,
    String? customerName,
    String? discountType,
    int?    discountValue,
  }) async {
    final res = await dio.post('/orders', data: {
      'branch_id':      branchId,
      'shift_id':       shiftId,
      'payment_method': paymentMethod,
      'customer_name':  customerName,
      'discount_type':  discountType,
      'discount_value': discountValue,
      'items':          items.map((i) => i.toJson()).toList(),
    });
    return Order.fromJson(res.data as Map<String, dynamic>);
  }

  Future<List<Order>> list({String? shiftId, String? branchId}) async {
    final params = <String, dynamic>{};
    if (shiftId  != null) params['shift_id']  = shiftId;
    if (branchId != null) params['branch_id'] = branchId;
    final res = await dio.get('/orders', queryParameters: params);
    return (res.data as List).map((o) => Order.fromJson(o)).toList();
  }

  /// Fetch a single order. Caches result; serves cache when offline.
  Future<Order> get(String id) async {
    try {
      final res   = await dio.get('/orders/$id');
      final order = Order.fromJson(res.data as Map<String, dynamic>);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('order_$id', jsonEncode(_orderToJson(order)));
      return order;
    } catch (_) {
      final prefs  = await SharedPreferences.getInstance();
      final cached = prefs.getString('order_$id');
      if (cached != null) {
        return Order.fromJson(jsonDecode(cached) as Map<String, dynamic>);
      }
      rethrow;
    }
  }

  /// Void an order.
  Future<Order> voidOrder(String id, {String? reason, bool restoreInventory = false}) async {
    final res = await dio.post('/orders/$id/void', data: {
      'reason':            reason,
      'restore_inventory': restoreInventory,
    });
    return Order.fromJson(res.data as Map<String, dynamic>);
  }

  Map<String, dynamic> _orderToJson(Order o) => {
    'id':             o.id,
    'branch_id':      o.branchId,
    'shift_id':       o.shiftId,
    'teller_id':      o.tellerId,
    'teller_name':    o.tellerName,
    'order_number':   o.orderNumber,
    'status':         o.status,
    'payment_method': o.paymentMethod,
    'subtotal':       o.subtotal,
    'discount_type':  o.discountType,
    'discount_value': o.discountValue,
    'discount_amount':o.discountAmount,
    'tax_amount':     o.taxAmount,
    'total_amount':   o.totalAmount,
    'customer_name':  o.customerName,
    'notes':          o.notes,
    'created_at':     o.createdAt.toIso8601String(),
    'items': o.items.map((i) => {
      'id':         i.id,
      'item_name':  i.itemName,
      'size_label': i.sizeLabel,
      'unit_price': i.unitPrice,
      'quantity':   i.quantity,
      'line_total': i.lineTotal,
      'addons': i.addons.map((a) => {
        'id':         a.id,
        'addon_name': a.addonName,
        'unit_price': a.unitPrice,
        'quantity':   a.quantity,
        'line_total': a.lineTotal,
      }).toList(),
    }).toList(),
  };
}

final orderApi = OrderApi();

