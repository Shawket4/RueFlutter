import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/order_api.dart';
import '../models/pending_order.dart';

const _kPendingKey = 'offline_pending_orders';

class OfflineSyncService extends ChangeNotifier {
  List<PendingOrder> _pending  = [];
  bool               _syncing  = false;
  bool               _isOnline = true;
  String?            _lastError;
  StreamSubscription<List<ConnectivityResult>>? _sub;

  List<PendingOrder> get pending   => List.unmodifiable(_pending);
  bool               get syncing   => _syncing;
  bool               get isOnline  => _isOnline;
  int                get count     => _pending.length;
  String?            get lastError => _lastError;

  Future<void> init() async {
    await _load();
    final results = await Connectivity().checkConnectivity();
    _isOnline = results.any((r) => r != ConnectivityResult.none);
    _sub = Connectivity().onConnectivityChanged.listen((results) {
      final online = results.any((r) => r != ConnectivityResult.none);
      if (online && !_isOnline && _pending.isNotEmpty) syncAll();
      _isOnline = online;
      notifyListeners();
    });
    if (_isOnline && _pending.isNotEmpty) syncAll();
  }

  @override
  void dispose() { _sub?.cancel(); super.dispose(); }

  Future<void> savePending(PendingOrder order) async {
    _pending.add(order);
    await _persist();
    notifyListeners();
  }

  Future<void> syncAll() async {
    if (_syncing || _pending.isEmpty) return;
    _syncing   = true;
    _lastError = null;
    notifyListeners();
    final done = <String>[];
    for (final p in List.of(_pending)) {
      try {
        await orderApi.create(
          branchId:      p.branchId,
          shiftId:       p.shiftId,
          paymentMethod: p.paymentMethod,
          items:         p.items,
          customerName:  p.customerName,
          discountType:  p.discountType,
          discountValue: p.discountValue,
        );
        done.add(p.localId);
      } catch (e) { _lastError = 'Sync failed: $e'; break; }
    }
    _pending.removeWhere((p) => done.contains(p.localId));
    await _persist();
    _syncing = false;
    notifyListeners();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw   = prefs.getString(_kPendingKey);
      if (raw != null) {
        _pending = (jsonDecode(raw) as List)
            .map((e) => PendingOrder.fromJson(e as Map<String, dynamic>)).toList();
      }
    } catch (_) { _pending = []; }
  }

  Future<void> _persist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kPendingKey,
          jsonEncode(_pending.map((p) => p.toJson()).toList()));
    } catch (_) {}
  }
}

final offlineSyncService = OfflineSyncService();

