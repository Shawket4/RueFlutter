import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order.dart';
import '../api/order_api.dart';

class OrderHistoryProvider extends ChangeNotifier {
  List<Order> _orders    = [];
  bool        _loading   = false;
  String?     _error;
  String?     _shiftId;
  bool        _fromCache = false;

  List<Order> get orders    => _orders;
  bool        get loading   => _loading;
  String?     get error     => _error;
  bool        get fromCache => _fromCache;

  Future<void> loadForShift(String shiftId) async {
    if (_shiftId == shiftId && _orders.isNotEmpty) return;
    _loading   = true;
    _fromCache = false;
    _error     = null;
    notifyListeners();
    try {
      _orders   = await orderApi.list(shiftId: shiftId);
      _shiftId  = shiftId;
      _fromCache = false;
      await _saveOrders(shiftId, _orders);
    } catch (_) {
      final cached = await _loadOrders(shiftId);
      if (cached != null) {
        _orders    = cached;
        _shiftId   = shiftId;
        _fromCache = true;
      } else {
        _error = 'Could not load orders — check connection';
      }
    }
    _loading = false;
    notifyListeners();
  }

  void refresh(String shiftId) {
    _shiftId = null;
    loadForShift(shiftId);
  }

  void addOrder(Order o) {
    _orders.insert(0, o);
    notifyListeners();
    if (_shiftId != null) _saveOrders(_shiftId!, _orders);
  }

  // Called by OfflineSyncService after a pending order syncs successfully
  void onOrderSynced(Order o) => addOrder(o);

  // ── Persistence ──────────────────────────────────────────────────────────
  static String _key(String shiftId) => 'orders_$shiftId';

  Future<void> _saveOrders(String shiftId, List<Order> orders) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          _key(shiftId), jsonEncode(orders.map(_orderToJson).toList()));
    } catch (_) {}
  }

  Future<List<Order>?> _loadOrders(String shiftId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw   = prefs.getString(_key(shiftId));
      if (raw == null) return null;
      return (jsonDecode(raw) as List)
          .map((o) => Order.fromJson(o as Map<String, dynamic>))
          .toList();
    } catch (_) { return null; }
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

