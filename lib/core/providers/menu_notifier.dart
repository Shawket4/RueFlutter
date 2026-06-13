import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bundle.dart';
import '../models/menu.dart';
import '../repositories/menu_repository.dart';
import '../services/connectivity_service.dart';
import '../services/menu_image_cache.dart';
import '../storage/storage_service.dart';

/// Sentinel category ID for the synthetic "Combos" rail entry.
const String kComboCategoryId = '__combos__';

// ── DataFreshness ────────────────────────────────────────────────────────────

/// Replaces scattered `fromCache` boolean flags.
/// Drives a single freshness indicator chip in the UI.
enum DataFreshness {
  /// Data was loaded from the server in this session.
  live,

  /// Data came from local cache; a refresh is in progress or pending.
  stale,

  /// Device is offline; local cache is the only source.
  offline,
}

// ── MenuState ────────────────────────────────────────────────────────────────

class MenuState {
  final List<Category>  categories;
  final List<MenuItem>  items;
  final List<Bundle>    bundles;
  final List<AddonItem> allAddons;
  final String?         selectedCategoryId;
  final bool            isLoading;
  final DataFreshness   freshness;
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
    this.freshness          = DataFreshness.stale,
    this.error,
    this.loadedOrgId,
    this.cachedAt,
  });

  // ── Backwards compat ──────────────────────────────────────────────────────
  bool get fromCache => freshness != DataFreshness.live;
  List<AddonItem> get addons => allAddons;

  // ── Derived views ─────────────────────────────────────────────────────────

  List<MenuItem> get filtered => selectedCategoryId == null
      ? items
      : items.where((i) => i.categoryId == selectedCategoryId).toList();

  List<MenuGridEntry> gridEntriesForCategory({
    required String branchId,
    DateTime? now,
  }) {
    final n     = now ?? DateTime.now();
    final catId = selectedCategoryId;
    final entries = <MenuGridEntry>[];

    if (catId == kComboCategoryId) {
      for (final b in bundles) {
        if (b.status != BundleStatus.active) continue;
        if (!isBundleAvailableNow(b, branchId, n)) continue;
        entries.add(MenuGridEntry.bundle(b));
      }
      return entries;
    }

    for (final i in items) {
      if (!i.isActive) continue;
      if (catId != null && i.categoryId != catId) continue;
      entries.add(MenuGridEntry.item(i));
    }
    return entries;
  }

  List<Bundle> searchBundles(
    String query, {
    required String branchId,
    DateTime? now,
  }) {
    final q = query.toLowerCase();
    final n = now ?? DateTime.now();
    return bundles.where((b) {
      if (!isBundleAvailableNow(b, branchId, n)) return false;
      return b.name.toLowerCase().contains(q) ||
          (b.description?.toLowerCase().contains(q) ?? false);
    }).toList();
  }

  Map<String, List<AddonItem>> get addonsByType {
    final map = <String, List<AddonItem>>{};
    for (final a in allAddons) {
      if (!a.isActive) continue;
      map.putIfAbsent(a.addonType, () => []).add(a);
    }
    return map;
  }

  bool get hasActiveBundles => bundles.any((b) => b.status == BundleStatus.active);

  MenuState copyWith({
    List<Category>?  categories,
    List<MenuItem>?  items,
    List<Bundle>?    bundles,
    List<AddonItem>? allAddons,
    String?          selectedCategoryId,
    bool?            isLoading,
    DataFreshness?   freshness,
    String?          error,
    String?          loadedOrgId,
    DateTime?        cachedAt,
    bool             clearError = false,
    bool             clearSelectedCategory = false,
  }) =>
      MenuState(
        categories:         categories         ?? this.categories,
        items:              items              ?? this.items,
        bundles:            bundles            ?? this.bundles,
        allAddons:          allAddons          ?? this.allAddons,
        selectedCategoryId: clearSelectedCategory
            ? null
            : (selectedCategoryId ?? this.selectedCategoryId),
        isLoading:          isLoading          ?? this.isLoading,
        freshness:          freshness          ?? this.freshness,
        error:              clearError ? null  : (error ?? this.error),
        loadedOrgId:        loadedOrgId        ?? this.loadedOrgId,
        cachedAt:           cachedAt           ?? this.cachedAt,
      );
}

// ── MenuNotifier ─────────────────────────────────────────────────────────────

class MenuNotifier extends Notifier<MenuState> {
  @override
  MenuState build() => const MenuState();

  /// Two-phase load:
  /// 1. Paint local cache instantly (offline-safe first frame).
  /// 2. Kick background network refresh; on success emit fresh state.
  Future<void> load(String orgId, {bool force = false}) async {
    // Guard: already live for this org and not forced.
    if (!force &&
        state.loadedOrgId == orgId &&
        state.items.isNotEmpty &&
        state.freshness == DataFreshness.live) {
      return;
    }

    final repo      = ref.read(menuRepositoryProvider);
    final isOnline  = ConnectivityService.instance.isOnline;
    final cachedAt  = ref.read(storageServiceProvider).menuCachedAt(orgId);

    // ── Phase 1: serve local immediately ──────────────────────────────────
    final localMenu    = repo.loadMenuLocal(orgId);
    final localBundles = repo.loadBundlesLocal(orgId);
    final localAddons  = repo.loadAddonsLocal(orgId);

    if (localMenu != null) {
      state = state.copyWith(
        categories:         localMenu.categories,
        items:              localMenu.items,
        bundles:            localBundles ?? state.bundles,
        allAddons:          localAddons  ?? state.allAddons,
        freshness:          isOnline ? DataFreshness.stale : DataFreshness.offline,
        isLoading:          isOnline, // still loading if we'll refresh
        loadedOrgId:        orgId,
        cachedAt:           cachedAt,
        selectedCategoryId: localMenu.categories.isNotEmpty
            ? localMenu.categories.first.id
            : null,
        clearError: true,
      );
    } else {
      // No local data: show loading spinner.
      state = state.copyWith(isLoading: true, clearError: true);
    }

    if (!isOnline) {
      // Offline — local is the best we have. With no cache at all the old
      // code left isLoading=true forever (infinite skeleton); say why instead.
      if (localMenu == null) {
        state = state.copyWith(
          isLoading: false,
          freshness: DataFreshness.offline,
          error:
              'No connection and no cached menu yet — connect this device once to set it up',
        );
      }
      return;
    }

    // ── Phase 2: background refresh ───────────────────────────────────────
    try {
      final staleMenu    = await repo.isStale('menu:$orgId');
      final staleBundles = await repo.isStale('bundles:$orgId');
      final staleAddons  = await repo.isStale('addons:$orgId');
      final results = await Future.wait([
        if (staleMenu || force || localMenu == null)
          repo.fetchMenuFresh(orgId)
        else
          Future.value(localMenu),
        if (staleBundles || force || localBundles == null)
          repo.fetchBundlesFresh(orgId)
        else
          Future.value(localBundles),
        if (staleAddons || force || localAddons == null)
          repo.fetchAddonsFresh(orgId)
        else
          Future.value(localAddons),
      ]);

      final freshMenu    = results[0] as ({List<Category> categories, List<MenuItem> items});
      final freshBundles = results[1] as List<Bundle>;
      final freshAddons  = results[2] as List<AddonItem>;
      final freshCachedAt = ref.read(storageServiceProvider).menuCachedAt(orgId);

      state = state.copyWith(
        isLoading:          false,
        categories:         freshMenu.categories,
        items:              freshMenu.items,
        bundles:            freshBundles,
        allAddons:          freshAddons,
        freshness:          DataFreshness.live,
        loadedOrgId:        orgId,
        cachedAt:           freshCachedAt,
        selectedCategoryId: freshMenu.categories.isNotEmpty
            ? freshMenu.categories.first.id
            : null,
        clearError: true,
      );

      // Warm image cache (fire-and-forget).
      final imageCache = ref.read(menuImageCacheProvider);
      if (force) await imageCache.invalidate();
      final urls = <String>{
        for (final i in freshMenu.items)
          if (i.imageUrl != null && i.imageUrl!.isNotEmpty) i.imageUrl!,
        for (final c in freshMenu.categories)
          if (c.imageUrl != null && c.imageUrl!.isNotEmpty) c.imageUrl!,
        for (final b in freshBundles) ...{
          if (b.imageUrl != null && b.imageUrl!.isNotEmpty) b.imageUrl!,
          if (b.previewImageUrl(freshMenu.items) != null)
            b.previewImageUrl(freshMenu.items)!,
        },
      };
      if (urls.isNotEmpty) unawaited(imageCache.warmUp(urls));
    } catch (_) {
      // Network failed — demote to stale/offline; keep showing local data.
      state = state.copyWith(
        isLoading: false,
        freshness: DataFreshness.offline,
        // Only set error when there's nothing to show at all.
        error: state.items.isEmpty
            ? 'No connection and no cached menu available'
            : null,
      );
    }
  }

  void selectCategory(String id) =>
      state = state.copyWith(selectedCategoryId: id);
}

final menuProvider =
    NotifierProvider<MenuNotifier, MenuState>(MenuNotifier.new);