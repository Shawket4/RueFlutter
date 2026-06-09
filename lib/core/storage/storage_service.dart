import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/kv_store.dart';

// ---------------------------------------------------------------------------
// StorageService
// ---------------------------------------------------------------------------
// Public method signatures are byte-for-byte identical to the SharedPreferences
// implementation so that none of the ~80 call sites need to change.
//
// Constructor changed: StorageService(SharedPreferences) → StorageService(KvStore).
// Reads are synchronous (KvStore._cache); writes are async (KvStore.setString).
//
// Removed:
//   - savePendingActions / loadPendingActions / _pendingKey
//     → the OutboxDao (sqflite outbox table) owns the mutation queue now.
//
// Changed:
//   - menuCachedAt(orgId) now reads KvStore.tsOf('menu_v2_$orgId') (ms epoch)
//     instead of the separate 'menu_cached_at_$orgId' ISO8601 string key.
//   - loadDraftCartsWithLegacyMigration: legacy branch is dead (no SharedPrefs);
//     simply delegates to loadDraftCarts(scope).
// ---------------------------------------------------------------------------

class StorageService {
  final KvStore _kv;
  StorageService(this._kv);

  /// Expose raw KvStore for non-domain code (e.g. locale, settings).
  KvStore get raw => _kv;

  // ── Auth ────────────────────────────────────────────────────────────────────

  String? get token => _kv.getString('auth_token');
  Future<void> saveToken(String t) => _kv.setString('auth_token', t);
  Future<void> removeToken() => _kv.remove('auth_token');

  Future<void> saveUser(Map<String, dynamic> j) =>
      _kv.setString('cached_user', jsonEncode(j));

  Map<String, dynamic>? loadUser() {
    final raw = _kv.getString('cached_user');
    if (raw == null) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      _kv.remove('cached_user');
      return null;
    }
  }

  Future<void> removeUser() => _kv.remove('cached_user');

  // ── Branch ──────────────────────────────────────────────────────────────────

  Future<void> saveBranch(String id, Map<String, dynamic> j) =>
      _kv.setString('branch_$id', jsonEncode(j));

  Map<String, dynamic>? loadBranch(String id) {
    final raw = _kv.getString('branch_$id');
    if (raw == null) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      _kv.remove('branch_$id');
      return null;
    }
  }

  // ── Shift ───────────────────────────────────────────────────────────────────

  Future<void> saveShift(String branchId, Map<String, dynamic> j) =>
      _kv.setString('shift_$branchId', jsonEncode(j));

  Map<String, dynamic>? loadShift(String branchId) {
    final raw = _kv.getString('shift_$branchId');
    if (raw == null) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      _kv.remove('shift_$branchId');
      return null;
    }
  }

  Future<void> removeShift(String branchId) => _kv.remove('shift_$branchId');

  // ── Menu ────────────────────────────────────────────────────────────────────

  /// Saves the menu JSON blob.  The write timestamp is stored by KvStore
  /// so [menuCachedAt] reads it back without a separate key.
  Future<void> saveMenu(String orgId, Map<String, dynamic> j) =>
      _kv.setString('menu_v2_$orgId', jsonEncode(j));

  Map<String, dynamic>? loadMenu(String orgId) {
    final raw = _kv.getString('menu_v2_$orgId');
    if (raw == null) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      _kv.remove('menu_v2_$orgId');
      return null;
    }
  }

  /// Returns the wall-clock time of the last [saveMenu] call for [orgId].
  /// Reads the KvStore write-timestamp (epoch ms) instead of a separate key.
  DateTime? menuCachedAt(String orgId) {
    final ms = _kv.tsOf('menu_v2_$orgId');
    if (ms == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(ms);
  }

  // ── Bundles ─────────────────────────────────────────────────────────────────

  Future<void> saveBundles(String orgId, List<Map<String, dynamic>> bundles) =>
      _kv.setString('bundles_v1_$orgId', jsonEncode(bundles));

  List<Map<String, dynamic>>? loadBundles(String orgId) {
    final raw = _kv.getString('bundles_v1_$orgId');
    if (raw == null) return null;
    try {
      return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    } catch (_) {
      _kv.remove('bundles_v1_$orgId');
      return null;
    }
  }

  // ── Addons ──────────────────────────────────────────────────────────────────

  Future<void> saveAddons(
          String orgId, List<Map<String, dynamic>> addons) =>
      _kv.setString('addons_$orgId', jsonEncode(addons));

  List<Map<String, dynamic>>? loadAddons(String orgId) {
    final raw = _kv.getString('addons_$orgId');
    if (raw == null) return null;
    try {
      return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    } catch (_) {
      _kv.remove('addons_$orgId');
      return null;
    }
  }

  // ── Discounts ────────────────────────────────────────────────────────────────

  Future<void> saveDiscounts(
          String orgId, List<Map<String, dynamic>> discounts) =>
      _kv.setString('discounts_$orgId', jsonEncode(discounts));

  List<Map<String, dynamic>> loadDiscounts(String orgId) {
    final raw = _kv.getString('discounts_$orgId');
    if (raw == null) return [];
    try {
      return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    } catch (_) {
      _kv.remove('discounts_$orgId');
      return [];
    }
  }

  // ── Payment methods ──────────────────────────────────────────────────────────

  Future<void> savePaymentMethods(
          String orgId, List<Map<String, dynamic>> methods) =>
      _kv.setString('payment_methods_$orgId', jsonEncode(methods));

  List<Map<String, dynamic>> loadPaymentMethods(String orgId) {
    final raw = _kv.getString('payment_methods_$orgId');
    if (raw == null) return [];
    try {
      return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    } catch (_) {
      _kv.remove('payment_methods_$orgId');
      return [];
    }
  }

  // ── Orders ───────────────────────────────────────────────────────────────────

  Future<void> saveOrders(
          String shiftId, List<Map<String, dynamic>> orders) =>
      _kv.setString('orders_$shiftId', jsonEncode(orders));

  List<Map<String, dynamic>>? loadOrders(String shiftId) {
    final raw = _kv.getString('orders_$shiftId');
    if (raw == null) return null;
    try {
      return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    } catch (_) {
      _kv.remove('orders_$shiftId');
      return null;
    }
  }

  // ── Shifts list ───────────────────────────────────────────────────────────────

  Future<void> saveShifts(
          String branchId, List<Map<String, dynamic>> shifts) =>
      _kv.setString('shifts_list_$branchId', jsonEncode(shifts));

  List<Map<String, dynamic>>? loadShifts(String branchId) {
    final raw = _kv.getString('shifts_list_$branchId');
    if (raw == null) return null;
    try {
      return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    } catch (_) {
      _kv.remove('shifts_list_$branchId');
      return null;
    }
  }

  // ── Inventory ──────────────────────────────────────────────────────────────────

  Future<void> saveInventory(
          String branchId, List<Map<String, dynamic>> items) =>
      _kv.setString('inventory_$branchId', jsonEncode(items));

  List<Map<String, dynamic>>? loadInventory(String branchId) {
    final raw = _kv.getString('inventory_$branchId');
    if (raw == null) return null;
    try {
      return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    } catch (_) {
      _kv.remove('inventory_$branchId');
      return null;
    }
  }

  // ── Single menu item ────────────────────────────────────────────────────────────

  Future<void> saveMenuItem(String itemId, Map<String, dynamic> item) =>
      _kv.setString('menu_item_$itemId', jsonEncode(item));

  Map<String, dynamic>? loadMenuItem(String itemId) {
    final raw = _kv.getString('menu_item_$itemId');
    if (raw == null) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      _kv.remove('menu_item_$itemId');
      return null;
    }
  }

  // ── Shift report ────────────────────────────────────────────────────────────────

  Future<void> saveShiftReport(String shiftId, Map<String, dynamic> report) =>
      _kv.setString('shift_report_$shiftId', jsonEncode(report));

  Map<String, dynamic>? loadShiftReport(String shiftId) {
    final raw = _kv.getString('shift_report_$shiftId');
    if (raw == null) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      _kv.remove('shift_report_$shiftId');
      return null;
    }
  }

  // ── Recipe preview ───────────────────────────────────────────────────────────────

  Future<void> saveRecipe(
          String key, List<Map<String, dynamic>> recipe) =>
      _kv.setString('recipe_preview_$key', jsonEncode(recipe));

  List<Map<String, dynamic>>? loadRecipe(String key) {
    final raw = _kv.getString('recipe_preview_$key');
    if (raw == null) return null;
    try {
      return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    } catch (_) {
      _kv.remove('recipe_preview_$key');
      return null;
    }
  }

  // ── Draft carts ──────────────────────────────────────────────────────────────────

  static const _legacyDraftKey = 'draft_carts_v1';

  String _draftCartsKey(String scope) => 'draft_carts_v1_$scope';
  String _activeCartKey(String scope) => 'active_cart_v1_$scope';

  Future<void> saveDraftCarts(
          String scope, List<Map<String, dynamic>> drafts) =>
      _kv.setString(_draftCartsKey(scope), jsonEncode(drafts));

  List<Map<String, dynamic>> loadDraftCarts(String scope) {
    final raw = _kv.getString(_draftCartsKey(scope));
    if (raw == null) return [];
    try {
      return (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    } catch (_) {
      _kv.remove(_draftCartsKey(scope));
      return [];
    }
  }

  /// Legacy migration path is dead (SharedPreferences no longer exists).
  /// Kept for API compatibility with [DraftCartsNotifier].
  List<Map<String, dynamic>> loadDraftCartsWithLegacyMigration(String scope) =>
      loadDraftCarts(scope);

  Future<void> saveActiveCart(String scope, Map<String, dynamic> cart) =>
      _kv.setString(_activeCartKey(scope), jsonEncode(cart));

  Map<String, dynamic>? loadActiveCart(String scope) {
    final raw = _kv.getString(_activeCartKey(scope));
    if (raw == null) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      _kv.remove(_activeCartKey(scope));
      return null;
    }
  }

  Future<void> clearCartDataForScope(String scope) async {
    await _kv.remove(_draftCartsKey(scope));
    await _kv.remove(_activeCartKey(scope));
  }

  Future<void> clearAllCartStorage() => _kv.removeWhere(
        (k) =>
            k == _legacyDraftKey ||
            k.startsWith('draft_carts_v1_') ||
            k.startsWith('active_cart_v1_'),
      );

  // ── Auth clear ───────────────────────────────────────────────────────────────────

  Future<void> clearAuth() async {
    await removeToken();
    await removeUser();
  }
}

// ── Provider ──────────────────────────────────────────────────────────────────

final storageServiceProvider = Provider<StorageService>(
  (_) => throw UnimplementedError(
      'storageServiceProvider must be overridden in ProviderScope'),
);
