import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/menu_api.dart';
import '../models/bundle.dart';
import '../models/menu.dart';
import '../storage/storage_service.dart';

class MenuRepository {
  final MenuApi _api;
  final StorageService _storage;
  MenuRepository(this._api, this._storage);

  Future<({List<Category> categories, List<MenuItem> items, bool fromCache})>
      fetchMenu(String orgId) async {
    try {
      final results =
          await Future.wait([_api.categories(orgId), _api.items(orgId)]);
      final cats = results[0] as List<Category>;
      final items = results[1] as List<MenuItem>;
      await _storage.saveMenu(orgId, {
        'categories': cats.map((c) => c.toJson()).toList(),
        'items': items.map((i) => i.toJson()).toList(),
      });
      return (categories: cats, items: items, fromCache: false);
    } catch (_) {
      final cached = _storage.loadMenu(orgId);
      if (cached != null) {
        return (
          categories: (cached['categories'] as List)
              .map((c) => Category.fromJson(c as Map<String, dynamic>))
              .toList(),
          items: (cached['items'] as List)
              .map((i) => MenuItem.fromJson(i as Map<String, dynamic>))
              .toList(),
          fromCache: true,
        );
      }
      rethrow;
    }
  }

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

  Future<List<AddonItem>> fetchAddonItems(String orgId) async {
    try {
      final addons = await _api.addonItems(orgId);
      await _storage.saveAddons(orgId, addons.map((a) => a.toJson()).toList());
      return addons;
    } catch (_) {
      final cached = _storage.loadAddons(orgId);
      if (cached != null) {
        return (cached as List)
            .map((a) => AddonItem.fromJson(a as Map<String, dynamic>))
            .toList();
      }
      return [];
    }
  }

  Future<({List<Bundle> bundles, bool fromCache})> fetchBundles(
    String orgId, {
    DateTime? updatedSince,
  }) async {
    try {
      final bundles = await _api.bundles(orgId, updatedSince: updatedSince);
      await _storage.saveBundles(
        orgId,
        bundles.map((b) => b.toJson()).toList(),
      );
      return (bundles: bundles, fromCache: false);
    } catch (_) {
      final cached = _storage.loadBundles(orgId);
      if (cached != null) {
        return (
          bundles: cached
              .map((b) => Bundle.fromJson(b))
              .where((b) => b.status == BundleStatus.active)
              .toList(),
          fromCache: true,
        );
      }
      return (bundles: <Bundle>[], fromCache: true);
    }
  }
}

final menuRepositoryProvider = Provider<MenuRepository>((ref) => MenuRepository(
      ref.watch(menuApiProvider),
      ref.watch(storageServiceProvider),
    ));
