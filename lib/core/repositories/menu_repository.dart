import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import '../api/menu_api.dart';
import '../db/app_database.dart';
import '../models/bundle.dart';
import '../models/menu.dart';
import '../storage/storage_service.dart';

/// TTL for menu freshness: 10 minutes in ms.
const _kMenuTtlMs = 10 * 60 * 1000;

/// Cache/sync-meta scope for the menu: the org, or org+branch when a branch is
/// bound. Branch-keying keeps one branch's effective prices/availability from
/// leaking into another branch on a shared device.
String menuScopeKey(String orgId, String? branchId) =>
    (branchId == null || branchId.isEmpty) ? orgId : '$orgId:$branchId';

class MenuRepository {
  final MenuApi        _api;
  final StorageService _storage;
  final AppDatabase    _db;

  MenuRepository(this._api, this._storage, this._db);

  // ── Freshness / sync_meta ────────────────────────────────────────────────

  /// Returns true if [entity] in sync_meta is older than [ttlMs] (or absent).
  Future<bool> isStale(String entity, {int ttlMs = _kMenuTtlMs}) async {
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

  // ── Menu (categories + items) ────────────────────────────────────────────

  /// Reads local KV cache synchronously — may be null on first run.
  ({List<Category> categories, List<MenuItem> items})? loadMenuLocal(String orgId, {String? branchId}) {
    final cached = _storage.loadMenu(menuScopeKey(orgId, branchId));
    if (cached == null) return null;
    try {
      return (
        categories: (cached['categories'] as List)
            .map((c) => Category.fromJson(c as Map<String, dynamic>))
            .toList(),
        items: (cached['items'] as List)
            .map((i) => MenuItem.fromJson(i as Map<String, dynamic>))
            .toList(),
      );
    } catch (_) {
      return null;
    }
  }

  /// Fetches fresh data from the network and persists it. Throws on failure.
  /// When [branchId] is set, items carry branch-effective prices and exclude
  /// branch-disabled items; the cache is keyed by org+branch.
  Future<({List<Category> categories, List<MenuItem> items})> fetchMenuFresh(
      String orgId, {String? branchId}) async {
    final scope = menuScopeKey(orgId, branchId);
    final results =
        await Future.wait([_api.categories(orgId), _api.items(orgId, branchId: branchId)]);
    final cats  = results[0] as List<Category>;
    final items = results[1] as List<MenuItem>;
    await _storage.saveMenu(scope, {
      'categories': cats.map((c) => c.toJson()).toList(),
      'items':      items.map((i) => i.toJson()).toList(),
    });
    await _bumpSyncMeta('menu:$scope');
    return (categories: cats, items: items);
  }

  // ── Bundles ──────────────────────────────────────────────────────────────

  List<Bundle>? loadBundlesLocal(String orgId) {
    final cached = _storage.loadBundles(orgId);
    if (cached == null) return null;
    try {
      return cached
          .map((b) => Bundle.fromJson(b))
          .where((b) => b.status == BundleStatus.active)
          .toList();
    } catch (_) {
      return null;
    }
  }

  Future<List<Bundle>> fetchBundlesFresh(String orgId,
      {DateTime? updatedSince}) async {
    final bundles = await _api.bundles(orgId, updatedSince: updatedSince);
    await _storage.saveBundles(
        orgId, bundles.map((b) => b.toJson()).toList());
    await _bumpSyncMeta('bundles:$orgId');
    return bundles;
  }

  // ── Addon items ──────────────────────────────────────────────────────────

  List<AddonItem>? loadAddonsLocal(String orgId, {String? branchId}) {
    final cached = _storage.loadAddons(menuScopeKey(orgId, branchId));
    if (cached == null) return null;
    try {
      return cached
          .map((a) => AddonItem.fromJson(a))
          .toList();
    } catch (_) {
      return null;
    }
  }

  Future<List<AddonItem>> fetchAddonsFresh(String orgId, {String? branchId}) async {
    final scope = menuScopeKey(orgId, branchId);
    final addons = await _api.addonItems(orgId, branchId: branchId);
    await _storage.saveAddons(scope, addons.map((a) => a.toJson()).toList());
    await _bumpSyncMeta('addons:$scope');
    return addons;
  }

  // ── Single menu item (used by item detail sheet on demand) ───────────────

  Future<MenuItem> fetchItem(String id) async {
    try {
      final item = await _api.item(id);
      await _storage.saveMenuItem(id, item.toJson());
      return item;
    } catch (_) {
      final cached = _storage.loadMenuItem(id);
      if (cached != null) return MenuItem.fromJson(cached);
      rethrow;
    }
  }
}

final menuRepositoryProvider = Provider<MenuRepository>((ref) => MenuRepository(
      ref.watch(menuApiProvider),
      ref.watch(storageServiceProvider),
      AppDatabase.instance,
    ));
