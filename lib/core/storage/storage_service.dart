import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/kv_store.dart';
import '../utils/app_log.dart';
import 'secure_token_store.dart';

// ---------------------------------------------------------------------------
// StorageService
// ---------------------------------------------------------------------------
// Public method signatures are byte-for-byte identical to the SharedPreferences
// implementation so that none of the ~80 call sites need to change.
//
// Reads are synchronous (KvStore._cache); writes are async (KvStore.setString).
// The JWT lives in SecureTokenStore (platform keychain), not the kv table.
//
// Corrupt cache entries are dropped (so a bad blob can't brick a load path)
// but every drop is recorded in AppLog so it is diagnosable from Settings →
// Diagnostics instead of vanishing silently.
// ---------------------------------------------------------------------------

class StorageService {
  final KvStore _kv;
  final SecureTokenStore _tokens;
  StorageService(this._kv, this._tokens);

  /// Expose raw KvStore for non-domain code (e.g. locale, settings).
  KvStore get raw => _kv;

  /// Decodes a cached JSON value; on corruption logs, deletes, returns null.
  T? _decode<T>(String key, T Function(String raw) parse) {
    final raw = _kv.getString(key);
    if (raw == null) return null;
    try {
      return parse(raw);
    } catch (e) {
      AppLog.warn('storage', 'Corrupt cache "$key" dropped: $e');
      _kv.remove(key);
      return null;
    }
  }

  Map<String, dynamic>? _decodeMap(String key) =>
      _decode(key, (r) => jsonDecode(r) as Map<String, dynamic>);

  List<Map<String, dynamic>>? _decodeList(String key) =>
      _decode(key, (r) => (jsonDecode(r) as List).cast<Map<String, dynamic>>());

  // ── Auth ────────────────────────────────────────────────────────────────────

  String? get token => _tokens.token;
  Future<void> saveToken(String t) => _tokens.write(t);
  Future<void> removeToken() => _tokens.clear();

  Future<void> saveUser(Map<String, dynamic> j) =>
      _kv.setString('cached_user', jsonEncode(j));

  Map<String, dynamic>? loadUser() => _decodeMap('cached_user');

  Future<void> removeUser() => _kv.remove('cached_user');

  // ── Device config (one-time setup: which org/branch this till serves) ─────

  static const _kDeviceOrgId      = 'device_org_id';
  static const _kDeviceBranchId   = 'device_branch_id';
  static const _kDeviceBranchName = 'device_branch_name';

  Future<void> saveDeviceConfig({
    required String orgId,
    required String branchId,
    required String branchName,
  }) async {
    await _kv.setString(_kDeviceOrgId, orgId);
    await _kv.setString(_kDeviceBranchId, branchId);
    await _kv.setString(_kDeviceBranchName, branchName);
  }

  String? get deviceOrgId      => _kv.getString(_kDeviceOrgId);
  String? get deviceBranchId   => _kv.getString(_kDeviceBranchId);
  String? get deviceBranchName => _kv.getString(_kDeviceBranchName);

  bool get isDeviceConfigured =>
      deviceOrgId != null && deviceBranchId != null;

  Future<void> clearDeviceConfig() async {
    await _kv.remove(_kDeviceOrgId);
    await _kv.remove(_kDeviceBranchId);
    await _kv.remove(_kDeviceBranchName);
  }

  // ── Offline unlock (salted PIN hash — never the PIN itself) ────────────────
  // These survive logout/clearAuth on purpose: they exist precisely so a
  // teller can get back in when the network (and therefore /auth/login) is
  // unreachable.

  String _normName(String name) => name.trim().toLowerCase();

  Future<void> saveOfflineUnlock(String name, String saltedHash) =>
      _kv.setString('offline_unlock_${_normName(name)}', saltedHash);

  String? offlineUnlockHash(String name) =>
      _kv.getString('offline_unlock_${_normName(name)}');

  /// Snapshot of the user object for offline unlock; kept separate from
  /// `cached_user` because that one is wiped by [clearAuth].
  Future<void> saveOfflineUser(String name, Map<String, dynamic> j) =>
      _kv.setString('offline_user_${_normName(name)}', jsonEncode(j));

  Map<String, dynamic>? loadOfflineUser(String name) =>
      _decodeMap('offline_user_${_normName(name)}');

  // ── Branch ──────────────────────────────────────────────────────────────────

  Future<void> saveBranch(String id, Map<String, dynamic> j) =>
      _kv.setString('branch_$id', jsonEncode(j));

  Map<String, dynamic>? loadBranch(String id) => _decodeMap('branch_$id');

  // ── Shift ───────────────────────────────────────────────────────────────────

  Future<void> saveShift(String branchId, Map<String, dynamic> j) =>
      _kv.setString('shift_$branchId', jsonEncode(j));

  Map<String, dynamic>? loadShift(String branchId) =>
      _decodeMap('shift_$branchId');

  Future<void> removeShift(String branchId) => _kv.remove('shift_$branchId');

  // ── Menu ────────────────────────────────────────────────────────────────────

  /// Saves the menu JSON blob.  The write timestamp is stored by KvStore
  /// so [menuCachedAt] reads it back without a separate key.
  Future<void> saveMenu(String orgId, Map<String, dynamic> j) =>
      _kv.setString('menu_v2_$orgId', jsonEncode(j));

  Map<String, dynamic>? loadMenu(String orgId) => _decodeMap('menu_v2_$orgId');

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

  List<Map<String, dynamic>>? loadBundles(String orgId) =>
      _decodeList('bundles_v1_$orgId');

  // ── Addons ──────────────────────────────────────────────────────────────────

  Future<void> saveAddons(
          String orgId, List<Map<String, dynamic>> addons) =>
      _kv.setString('addons_$orgId', jsonEncode(addons));

  List<Map<String, dynamic>>? loadAddons(String orgId) =>
      _decodeList('addons_$orgId');

  // ── Discounts ────────────────────────────────────────────────────────────────

  Future<void> saveDiscounts(
          String orgId, List<Map<String, dynamic>> discounts) =>
      _kv.setString('discounts_$orgId', jsonEncode(discounts));

  List<Map<String, dynamic>> loadDiscounts(String orgId) =>
      _decodeList('discounts_$orgId') ?? [];

  // ── Payment methods ──────────────────────────────────────────────────────────

  Future<void> savePaymentMethods(
          String orgId, List<Map<String, dynamic>> methods) =>
      _kv.setString('payment_methods_$orgId', jsonEncode(methods));

  List<Map<String, dynamic>> loadPaymentMethods(String orgId) =>
      _decodeList('payment_methods_$orgId') ?? [];

  // ── Orders ───────────────────────────────────────────────────────────────────

  Future<void> saveOrders(
          String shiftId, List<Map<String, dynamic>> orders) =>
      _kv.setString('orders_$shiftId', jsonEncode(orders));

  List<Map<String, dynamic>>? loadOrders(String shiftId) =>
      _decodeList('orders_$shiftId');

  // ── Delivery orders ────────────────────────────────────────────────────────────

  Future<void> saveDeliveryOrders(
          String branchId, List<Map<String, dynamic>> orders) =>
      _kv.setString('delivery_orders_$branchId', jsonEncode(orders));

  List<Map<String, dynamic>>? loadDeliveryOrders(String branchId) =>
      _decodeList('delivery_orders_$branchId');

  // ── Shifts list ───────────────────────────────────────────────────────────────

  Future<void> saveShifts(
          String branchId, List<Map<String, dynamic>> shifts) =>
      _kv.setString('shifts_list_$branchId', jsonEncode(shifts));

  List<Map<String, dynamic>>? loadShifts(String branchId) =>
      _decodeList('shifts_list_$branchId');

  // ── Inventory ──────────────────────────────────────────────────────────────────

  Future<void> saveInventory(
          String branchId, List<Map<String, dynamic>> items) =>
      _kv.setString('inventory_$branchId', jsonEncode(items));

  List<Map<String, dynamic>>? loadInventory(String branchId) =>
      _decodeList('inventory_$branchId');

  // ── Single menu item ────────────────────────────────────────────────────────────

  Future<void> saveMenuItem(String itemId, Map<String, dynamic> item) =>
      _kv.setString('menu_item_$itemId', jsonEncode(item));

  Map<String, dynamic>? loadMenuItem(String itemId) =>
      _decodeMap('menu_item_$itemId');

  // ── Shift report ────────────────────────────────────────────────────────────────

  Future<void> saveShiftReport(String shiftId, Map<String, dynamic> report) =>
      _kv.setString('shift_report_$shiftId', jsonEncode(report));

  Map<String, dynamic>? loadShiftReport(String shiftId) =>
      _decodeMap('shift_report_$shiftId');

  // ── Recipe preview ───────────────────────────────────────────────────────────────

  Future<void> saveRecipe(
          String key, List<Map<String, dynamic>> recipe) =>
      _kv.setString('recipe_preview_$key', jsonEncode(recipe));

  List<Map<String, dynamic>>? loadRecipe(String key) =>
      _decodeList('recipe_preview_$key');

  // ── Draft carts ──────────────────────────────────────────────────────────────────

  static const _legacyDraftKey = 'draft_carts_v1';

  String _draftCartsKey(String scope) => 'draft_carts_v1_$scope';
  String _activeCartKey(String scope) => 'active_cart_v1_$scope';

  Future<void> saveDraftCarts(
          String scope, List<Map<String, dynamic>> drafts) =>
      _kv.setString(_draftCartsKey(scope), jsonEncode(drafts));

  List<Map<String, dynamic>> loadDraftCarts(String scope) =>
      _decodeList(_draftCartsKey(scope)) ?? [];

  /// Legacy migration path is dead (SharedPreferences no longer exists).
  /// Kept for API compatibility with [DraftCartsNotifier].
  List<Map<String, dynamic>> loadDraftCartsWithLegacyMigration(String scope) =>
      loadDraftCarts(scope);

  Future<void> saveActiveCart(String scope, Map<String, dynamic> cart) =>
      _kv.setString(_activeCartKey(scope), jsonEncode(cart));

  Map<String, dynamic>? loadActiveCart(String scope) =>
      _decodeMap(_activeCartKey(scope));

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
