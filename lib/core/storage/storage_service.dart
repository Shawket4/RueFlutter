import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _prefs;
  StorageService(this._prefs);

  String? get token => _prefs.getString('auth_token');
  Future<void> saveToken(String t) => _prefs.setString('auth_token', t);
  Future<void> removeToken() => _prefs.remove('auth_token');

  Future<void> saveUser(Map<String, dynamic> j) => _prefs.setString('cached_user', jsonEncode(j));
  Map<String, dynamic>? loadUser() {
    final raw = _prefs.getString('cached_user');
    if (raw == null) return null;
    try { return jsonDecode(raw) as Map<String, dynamic>; } catch (_) { 
      _prefs.remove('cached_user'); return null; 
    }
  }
  Future<void> removeUser() => _prefs.remove('cached_user');

  Future<void> saveBranch(String id, Map<String, dynamic> j) => _prefs.setString('branch_$id', jsonEncode(j));
  Map<String, dynamic>? loadBranch(String id) {
    final raw = _prefs.getString('branch_$id');
    if (raw == null) return null;
    try { return jsonDecode(raw) as Map<String, dynamic>; } catch (_) { 
      _prefs.remove('branch_$id'); return null; 
    }
  }

  Future<void> saveShift(String branchId, Map<String, dynamic> j) => _prefs.setString('shift_$branchId', jsonEncode(j));
  Map<String, dynamic>? loadShift(String branchId) {
    final raw = _prefs.getString('shift_$branchId');
    if (raw == null) return null;
    try { return jsonDecode(raw) as Map<String, dynamic>; } catch (_) { 
      _prefs.remove('shift_$branchId'); return null; 
    }
  }
  Future<void> removeShift(String branchId) => _prefs.remove('shift_$branchId');

  Future<void> saveMenu(String orgId, Map<String, dynamic> j) async {
    await _prefs.setString('menu_v2_$orgId', jsonEncode(j));
    await _prefs.setString('menu_cached_at_$orgId', DateTime.now().toIso8601String());
  }
  Map<String, dynamic>? loadMenu(String orgId) {
    final raw = _prefs.getString('menu_v2_$orgId');
    if (raw == null) return null;
    try { return jsonDecode(raw) as Map<String, dynamic>; } catch (_) { 
      _prefs.remove('menu_v2_$orgId'); return null; 
    }
  }
  DateTime? menuCachedAt(String orgId) {
    final raw = _prefs.getString('menu_cached_at_$orgId');
    if (raw == null) return null;
    try { return DateTime.parse(raw); } catch (_) { return null; }
  }

  Future<void> saveBundles(String orgId, List<Map<String, dynamic>> bundles) =>
      _prefs.setString('bundles_v1_$orgId', jsonEncode(bundles));

  List<Map<String, dynamic>>? loadBundles(String orgId) {
    final raw = _prefs.getString('bundles_v1_$orgId');
    if (raw == null) return null;
    try {
      return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    } catch (_) {
      _prefs.remove('bundles_v1_$orgId');
      return null;
    }
  }

  Future<void> saveAddons(String orgId, List<Map<String, dynamic>> addons) =>
      _prefs.setString('addons_$orgId', jsonEncode(addons));

  List<Map<String, dynamic>>? loadAddons(String orgId) {
    final raw = _prefs.getString('addons_$orgId');
    if (raw == null) return null;
    try { return (jsonDecode(raw) as List).cast<Map<String, dynamic>>(); } catch (_) { 
      _prefs.remove('addons_$orgId'); return null; 
    }
  }

  Future<void> saveDiscounts(String orgId, List<Map<String, dynamic>> discounts) =>
      _prefs.setString('discounts_$orgId', jsonEncode(discounts));

  List<Map<String, dynamic>> loadDiscounts(String orgId) {
    final raw = _prefs.getString('discounts_$orgId');
    if (raw == null) return [];
    try { return (jsonDecode(raw) as List).cast<Map<String, dynamic>>(); } catch (_) { 
      _prefs.remove('discounts_$orgId'); return []; 
    }
  }

  Future<void> saveOrders(String shiftId, List<Map<String, dynamic>> orders) =>
      _prefs.setString('orders_$shiftId', jsonEncode(orders));

  List<Map<String, dynamic>>? loadOrders(String shiftId) {
    final raw = _prefs.getString('orders_$shiftId');
    if (raw == null) return null;
    try { return (jsonDecode(raw) as List).cast<Map<String, dynamic>>(); } catch (_) { 
      _prefs.remove('orders_$shiftId'); return null; 
    }
  }

  Future<void> saveShifts(String branchId, List<Map<String, dynamic>> shifts) =>
      _prefs.setString('shifts_list_$branchId', jsonEncode(shifts));

  List<Map<String, dynamic>>? loadShifts(String branchId) {
    final raw = _prefs.getString('shifts_list_$branchId');
    if (raw == null) return null;
    try { return (jsonDecode(raw) as List).cast<Map<String, dynamic>>(); } catch (_) {
      _prefs.remove('shifts_list_$branchId'); return null;
    }
  }

  Future<void> saveInventory(String branchId, List<Map<String, dynamic>> items) =>
      _prefs.setString('inventory_$branchId', jsonEncode(items));

  List<Map<String, dynamic>>? loadInventory(String branchId) {
    final raw = _prefs.getString('inventory_$branchId');
    if (raw == null) return null;
    try { return (jsonDecode(raw) as List).cast<Map<String, dynamic>>(); } catch (_) {
      _prefs.remove('inventory_$branchId'); return null;
    }
  }

  Future<void> saveMenuItem(String itemId, Map<String, dynamic> item) =>
      _prefs.setString('menu_item_$itemId', jsonEncode(item));

  Map<String, dynamic>? loadMenuItem(String itemId) {
    final raw = _prefs.getString('menu_item_$itemId');
    if (raw == null) return null;
    try { return jsonDecode(raw) as Map<String, dynamic>; } catch (_) {
      _prefs.remove('menu_item_$itemId'); return null;
    }
  }

  Future<void> saveShiftReport(String shiftId, Map<String, dynamic> report) =>
      _prefs.setString('shift_report_$shiftId', jsonEncode(report));

  Map<String, dynamic>? loadShiftReport(String shiftId) {
    final raw = _prefs.getString('shift_report_$shiftId');
    if (raw == null) return null;
    try { return jsonDecode(raw) as Map<String, dynamic>; } catch (_) {
      _prefs.remove('shift_report_$shiftId'); return null;
    }
  }

  Future<void> saveRecipe(String key, List<Map<String, dynamic>> recipe) =>
      _prefs.setString('recipe_preview_$key', jsonEncode(recipe));

  List<Map<String, dynamic>>? loadRecipe(String key) {
    final raw = _prefs.getString('recipe_preview_$key');
    if (raw == null) return null;
    try { return (jsonDecode(raw) as List).cast<Map<String, dynamic>>(); } catch (_) {
      _prefs.remove('recipe_preview_$key'); return null;
    }
  }

  static const _pendingKey = 'offline_pending_actions_v2';

  Future<void> savePendingActions(List<Map<String, dynamic>> actions) =>
      _prefs.setString(_pendingKey, jsonEncode(actions));

  List<Map<String, dynamic>> loadPendingActions() {
    final raw = _prefs.getString(_pendingKey);
    if (raw == null) return [];
    try { return (jsonDecode(raw) as List).cast<Map<String, dynamic>>(); } catch (_) { 
      _prefs.remove(_pendingKey); return []; 
    }
  }

  static const _legacyDraftKey = 'draft_carts_v1';

  String _draftCartsKey(String scope) => 'draft_carts_v1_$scope';
  String _activeCartKey(String scope) => 'active_cart_v1_$scope';

  Future<void> saveDraftCarts(String scope, List<Map<String, dynamic>> drafts) =>
      _prefs.setString(_draftCartsKey(scope), jsonEncode(drafts));

  List<Map<String, dynamic>> loadDraftCarts(String scope) {
    final raw = _prefs.getString(_draftCartsKey(scope));
    if (raw == null) return [];
    try {
      return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    } catch (_) {
      _prefs.remove(_draftCartsKey(scope));
      return [];
    }
  }

  /// Migrates unscoped `draft_carts_v1` into [scope] once, then removes legacy key.
  List<Map<String, dynamic>> loadDraftCartsWithLegacyMigration(String scope) {
    var drafts = loadDraftCarts(scope);
    if (drafts.isNotEmpty) return drafts;

    final legacyRaw = _prefs.getString(_legacyDraftKey);
    if (legacyRaw == null) return [];

    try {
      drafts = (jsonDecode(legacyRaw) as List).cast<Map<String, dynamic>>();
      if (drafts.isNotEmpty) {
        saveDraftCarts(scope, drafts);
        _prefs.remove(_legacyDraftKey);
      }
      return drafts;
    } catch (_) {
      _prefs.remove(_legacyDraftKey);
      return [];
    }
  }

  Future<void> saveActiveCart(String scope, Map<String, dynamic> cart) =>
      _prefs.setString(_activeCartKey(scope), jsonEncode(cart));

  Map<String, dynamic>? loadActiveCart(String scope) {
    final raw = _prefs.getString(_activeCartKey(scope));
    if (raw == null) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      _prefs.remove(_activeCartKey(scope));
      return null;
    }
  }

  Future<void> clearCartDataForScope(String scope) async {
    await _prefs.remove(_draftCartsKey(scope));
    await _prefs.remove(_activeCartKey(scope));
  }

  Future<void> clearAllCartStorage() async {
    final keys = _prefs.getKeys().where((k) =>
        k == _legacyDraftKey ||
        k.startsWith('draft_carts_v1_') ||
        k.startsWith('active_cart_v1_'));
    for (final k in keys) {
      await _prefs.remove(k);
    }
  }

  Future<void> clearAuth() async {
    await removeToken();
    await removeUser();
  }
}

final storageServiceProvider = Provider<StorageService>((ref) {
  throw UnimplementedError('storageServiceProvider must be overridden in ProviderScope');
});
