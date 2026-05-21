import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bundle.dart';
import '../models/inventory.dart';
import '../models/menu.dart';
import '../repositories/menu_repository.dart';
import '../services/menu_image_cache.dart';
import '../storage/storage_service.dart';

/// Sentinel category ID for the synthetic "Combos" rail entry.
const String kComboCategoryId = '__combos__';

class MenuState {
  final List<Category>  categories;
  final List<MenuItem>  items;
  final List<Bundle>    bundles;
  final List<AddonItem> allAddons;
  final String?         selectedCategoryId;
  final bool            isLoading;
  final bool            fromCache;
  final String?         error;
  final String?         loadedOrgId;
  final DateTime?       cachedAt;

  const MenuState({
    this.categories         = const [],
    this.items              = const [],
    this.bundles            = const [],
    this.allAddons          = const [],
    this.selectedCategoryId,
    this.isLoading          = false,
    this.fromCache          = false,
    this.error,
    this.loadedOrgId,
    this.cachedAt,
  });

  // Alias for backwards compatibility with any code referencing .addons
  List<AddonItem> get addons => allAddons;

  List<MenuItem> get filtered => selectedCategoryId == null
      ? items
      : items.where((i) => i.categoryId == selectedCategoryId).toList();

  /// Merged menu items + bundles for the current category, sorted by display order.
  /// When [kComboCategoryId] is selected, only bundles are shown.
  /// Availability and stock are evaluated once per call (not per tile).
  List<MenuGridEntry> gridEntriesForCategory({
    required String branchId,
    required List<InventoryItem> inventory,
    DateTime? now,
  }) {
    final n = now ?? DateTime.now();
    final catId = selectedCategoryId;

    final entries = <MenuGridEntry>[];

    // ── Combos-only view ────────────────────────────────────────────────────
    if (catId == kComboCategoryId) {
      for (final b in bundles) {
        if (b.status != BundleStatus.active) continue;
        final available = isBundleAvailableNow(b, branchId, n);
        final oos = bundleOutOfStockReason(b, items, inventory);
        entries.add(MenuGridEntry.bundle(
          b,
          enabled: available && oos == null,
          disabledReason: oos,
        ));
      }
      entries.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
      return entries;
    }

    // ── Regular category view (items only — bundles live in Combos) ─────────
    for (final i in items) {
      if (!i.isActive) continue;
      if (catId != null && i.categoryId != catId) continue;
      entries.add(MenuGridEntry.item(i));
    }

    entries.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    return entries;
  }

  /// Bundles matching search query (availability + stock checked once).
  List<Bundle> searchBundles(
    String query, {
    required String branchId,
    required List<InventoryItem> inventory,
    DateTime? now,
  }) {
    final q = query.toLowerCase();
    final n = now ?? DateTime.now();
    return bundles.where((b) {
      if (!isBundleAvailableNow(b, branchId, n)) return false;
      if (bundleOutOfStockReason(b, items, inventory) != null) return false;
      return b.name.toLowerCase().contains(q) ||
          (b.description?.toLowerCase().contains(q) ?? false);
    }).toList();
  }

  /// Active addon items grouped by type, sorted by display_order.
  /// Used by ItemDetailSheet to populate each slot's chip list.
  Map<String, List<AddonItem>> get addonsByType {
    final map = <String, List<AddonItem>>{};
    for (final a in allAddons) {
      if (!a.isActive) continue;
      map.putIfAbsent(a.addonType, () => []).add(a);
    }
    for (final list in map.values) {
      list.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    }
    return map;
  }

  /// True when there is at least one active bundle that should show
  /// in the Combos rail entry.
  bool get hasActiveBundles => bundles.any((b) => b.status == BundleStatus.active);

  MenuState copyWith({
    List<Category>?  categories,
    List<MenuItem>?  items,
    List<Bundle>?    bundles,
    List<AddonItem>? allAddons,
    String?          selectedCategoryId,
    bool?            isLoading,
    bool?            fromCache,
    String?          error,
    String?          loadedOrgId,
    DateTime?        cachedAt,
    bool             clearError = false,
  }) =>
      MenuState(
        categories:         categories         ?? this.categories,
        items:              items              ?? this.items,
        bundles:            bundles            ?? this.bundles,
        allAddons:          allAddons          ?? this.allAddons,
        selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
        isLoading:          isLoading          ?? this.isLoading,
        fromCache:          fromCache          ?? this.fromCache,
        error:              clearError ? null  : (error ?? this.error),
        loadedOrgId:        loadedOrgId        ?? this.loadedOrgId,
        cachedAt:           cachedAt           ?? this.cachedAt,
      );
}

class MenuNotifier extends Notifier<MenuState> {
  @override
  MenuState build() => const MenuState();

  Future<void> load(String orgId, {bool force = false}) async {
    if (!force &&
        state.loadedOrgId == orgId &&
        state.items.isNotEmpty &&
        !state.fromCache) {
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final repo = ref.read(menuRepositoryProvider);

      // Fetch menu (categories + items), bundles, and addon items concurrently.
      final menuResult = await repo.fetchMenu(orgId);
      final bundleResult = await repo.fetchBundles(orgId);
      final addonItems = await repo.fetchAddonItems(orgId);
      final cachedAt   = ref.read(storageServiceProvider).menuCachedAt(orgId);

      state = state.copyWith(
        isLoading:          false,
        categories:         menuResult.categories,
        items:              menuResult.items,
        bundles:            bundleResult.bundles,
        allAddons:          addonItems,
        fromCache:          menuResult.fromCache,
        loadedOrgId:        orgId,
        cachedAt:           cachedAt,
        selectedCategoryId: menuResult.categories.isNotEmpty
            ? menuResult.categories.first.id
            : null,
      );

      // Image cache handling (only on successful FRESH fetches — offline
      // fallbacks leave the existing disk cache alone so the order screen
      // keeps working without network).
      if (!menuResult.fromCache) {
        final imageCache = ref.read(menuImageCacheProvider);

        // On forced refresh (user-initiated sync) wipe the disk cache so
        // fresh images are fetched from the server. On a first-time /
        // background fresh load we keep the disk cache — warmUp just
        // fills in anything missing.
        if (force) {
          await imageCache.invalidate();
        }

        final urls = <String>{
          for (final i in menuResult.items)
            if (i.imageUrl != null && i.imageUrl!.isNotEmpty) i.imageUrl!,
          for (final c in menuResult.categories)
            if (c.imageUrl != null && c.imageUrl!.isNotEmpty) c.imageUrl!,
          for (final b in bundleResult.bundles) ...{
            if (b.imageUrl != null && b.imageUrl!.isNotEmpty) b.imageUrl!,
            if (b.previewImageUrl(menuResult.items) != null)
              b.previewImageUrl(menuResult.items)!,
          },
        };
        if (urls.isNotEmpty) {
          // Fire-and-forget so the UI isn't blocked on image downloads.
          // MenuImage widgets render skeletons until each image lands on
          // disk, then fade in.
          unawaited(imageCache.warmUp(urls));
        }
      }
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error:     'No connection and no cached menu available',
      );
    }
  }

  void selectCategory(String id) =>
      state = state.copyWith(selectedCategoryId: id);
}

final menuProvider =
    NotifierProvider<MenuNotifier, MenuState>(MenuNotifier.new);