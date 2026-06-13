import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/models/bundle.dart';
import 'package:sufrix_pos/core/models/menu.dart';
import 'package:sufrix_pos/core/providers/menu_notifier.dart';
import 'package:sufrix_pos/core/repositories/menu_repository.dart';
import 'package:sufrix_pos/core/services/menu_image_cache.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

import '../../helpers/model_fixtures.dart';

class MockMenuRepository extends Mock implements MenuRepository {}

class MockMenuImageCache extends Mock implements MenuImageCache {}

class MockStorageService extends Mock implements StorageService {}

void main() {
  setUpAll(() {
    registerFallbackValue(<String>{});
  });

  late MockMenuRepository mockRepo;
  late MockMenuImageCache mockImageCache;
  late MockStorageService mockStorage;
  late ProviderContainer container;

  setUp(() {
    mockRepo = MockMenuRepository();
    mockImageCache = MockMenuImageCache();
    mockStorage = MockStorageService();

    when(() => mockImageCache.warmUp(any())).thenAnswer((_) async {});
    when(() => mockImageCache.invalidate()).thenAnswer((_) async {});
    when(() => mockStorage.menuCachedAt(any())).thenReturn(null);

    // No local cache by default; everything is stale so load() goes to the
    // network (ConnectivityService.instance.isOnline defaults to true in
    // tests because init() is never called).
    when(() => mockRepo.loadMenuLocal(any())).thenReturn(null);
    when(() => mockRepo.loadBundlesLocal(any())).thenReturn(null);
    when(() => mockRepo.loadAddonsLocal(any())).thenReturn(null);
    when(() => mockRepo.isStale(any())).thenAnswer((_) async => true);

    container = ProviderContainer(overrides: [
      menuRepositoryProvider.overrideWithValue(mockRepo),
      menuImageCacheProvider.overrideWithValue(mockImageCache),
      storageServiceProvider.overrideWithValue(mockStorage),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  group('MenuState computed properties', () {
    test('filtered returns all items if selectedCategoryId null', () {
      final state = MenuState(
        items: [
          makeMenuItem(id: 'm1', orgId: 'o', categoryId: 'c1', name: 'A', basePrice: 10, displayOrder: 1),
          makeMenuItem(id: 'm2', orgId: 'o', categoryId: 'c2', name: 'B', basePrice: 20, displayOrder: 2),
        ],
      );
      expect(state.filtered.length, 2);
    });

    test('filtered returns matching items if selectedCategoryId set', () {
      final state = MenuState(
        items: <MenuItem>[
          makeMenuItem(id: 'm1', orgId: 'o', categoryId: 'c1', name: 'A', basePrice: 10, displayOrder: 1),
          makeMenuItem(id: 'm2', orgId: 'o', categoryId: 'c2', name: 'B', basePrice: 20, displayOrder: 2),
        ],
        selectedCategoryId: 'c1',
      );
      expect(state.filtered.length, 1);
      expect(state.filtered[0].id, 'm1');
    });

    test('hasActiveBundles', () {
      expect(const MenuState().hasActiveBundles, false);
      expect(MenuState(bundles: [
        makeBundle(id: 'b1', orgId: 'o', name: 'B', price: 10, status: BundleStatus.draft, displayOrder: 1)
      ]).hasActiveBundles, false);
      expect(MenuState(bundles: [
        makeBundle(id: 'b1', orgId: 'o', name: 'B', price: 10, status: BundleStatus.active, displayOrder: 1)
      ]).hasActiveBundles, true);
    });

    test('addonsByType groups and sorts', () {
      final state = MenuState(
        allAddons: <AddonItem>[
          makeAddonItem(id: '1', name: 'A1', addonType: 't1', defaultPrice: 1, displayOrder: 2),
          makeAddonItem(id: '2', name: 'A2', addonType: 't1', defaultPrice: 1, displayOrder: 1),
          makeAddonItem(id: '3', name: 'A3', addonType: 't2', defaultPrice: 1, isActive: false, displayOrder: 1),
        ],
      );

      final map = state.addonsByType;
      expect(map.keys.length, 1);
      expect(map['t1']!.length, 2);
      expect(map['t1']![0].id, '2'); // displayOrder 1 comes first
      expect(map['t1']![1].id, '1'); // displayOrder 2
    });

    test('gridEntriesForCategory Combos view sorts bundles by displayOrder',
        () {
      final state = MenuState(
        bundles: [
          makeBundle(id: 'b1', orgId: 'o', name: 'B1', price: 10, status: BundleStatus.active, displayOrder: 2),
          makeBundle(id: 'b2', orgId: 'o', name: 'B2', price: 10, status: BundleStatus.active, displayOrder: 1),
        ],
        selectedCategoryId: kComboCategoryId,
      );

      final entries =
          state.gridEntriesForCategory(branchId: 'b1');
      expect(entries.length, 2);
      expect(entries[0].kind == MenuGridEntryKind.bundle, true);
      expect(entries[0].bundle!.id, 'b2'); // Sorted by displayOrder
    });

    test('gridEntriesForCategory regular view filters and sorts items', () {
      final state = MenuState(
        items: <MenuItem>[
          makeMenuItem(id: 'm1', orgId: 'o', categoryId: 'c1', name: 'M1', basePrice: 1, displayOrder: 2),
          makeMenuItem(id: 'm2', orgId: 'o', categoryId: 'c1', name: 'M2', basePrice: 1, displayOrder: 1),
          makeMenuItem(id: 'm3', orgId: 'o', categoryId: 'c2', name: 'M3', basePrice: 1, displayOrder: 1),
        ],
        selectedCategoryId: 'c1',
      );

      final entries =
          state.gridEntriesForCategory(branchId: 'b1');
      expect(entries.length, 2);
      expect(entries[0].item!.id, 'm2'); // Sorted by displayOrder
      expect(entries[1].item!.id, 'm1');
    });

    test('searchBundles matches by name', () {
      final state = MenuState(
        bundles: [
          makeBundle(id: 'b1', orgId: 'o', name: 'Combo Meal', price: 10, status: BundleStatus.active, displayOrder: 1),
          makeBundle(id: 'b2', orgId: 'o', name: 'Burger Deal', price: 10, status: BundleStatus.active, displayOrder: 2),
        ],
      );

      final result = state.searchBundles('meal', branchId: 'b1');
      expect(result.length, 1);
      expect(result[0].id, 'b1');
    });
  });

  group('MenuNotifier', () {
    void stubFreshFetch({
      List<Category> categories = const [],
      List<MenuItem> items = const [],
      List<Bundle> bundles = const [],
      List<AddonItem> addons = const [],
    }) {
      when(() => mockRepo.fetchMenuFresh('org1'))
          .thenAnswer((_) async => (categories: categories, items: items));
      when(() => mockRepo.fetchBundlesFresh('org1'))
          .thenAnswer((_) async => bundles);
      when(() => mockRepo.fetchAddonsFresh('org1'))
          .thenAnswer((_) async => addons);
    }

    test('load fetches fresh data and updates state', () async {
      final categories = <Category>[makeCategory(id: 'c1', name: 'Cat 1', displayOrder: 1, imageUrl: 'cat1.png')];
      final items = <MenuItem>[makeMenuItem(id: 'm1', orgId: 'o', categoryId: 'c1', name: 'Item', basePrice: 10, displayOrder: 1, imageUrl: 'item1.png')];

      stubFreshFetch(categories: categories, items: items);

      final notifier = container.read(menuProvider.notifier);
      await notifier.load('org1');

      final state = container.read(menuProvider);
      expect(state.isLoading, false);
      expect(state.categories.length, 1);
      expect(state.items.length, 1);
      expect(state.freshness, DataFreshness.live);
      expect(state.fromCache, false);
      expect(state.selectedCategoryId, 'c1');
      expect(state.loadedOrgId, 'org1');

      verify(() => mockImageCache.warmUp(any())).called(1);
    });

    test('load avoids redundant fetches once live', () async {
      stubFreshFetch(items: <MenuItem>[
        makeMenuItem(id: 'm', orgId: 'o', categoryId: 'c', name: 'N', basePrice: 1, displayOrder: 1),
      ]);

      final notifier = container.read(menuProvider.notifier);
      await notifier.load('org1');

      // Call again — already live for this org.
      await notifier.load('org1');
      verify(() => mockRepo.fetchMenuFresh('org1')).called(1);

      // Force refetches.
      await notifier.load('org1', force: true);
      verify(() => mockRepo.fetchMenuFresh('org1')).called(1); // total 2
    });

    test('load serves local cache without fetching when fresh', () async {
      final localItems = <MenuItem>[
        makeMenuItem(id: 'm1', orgId: 'o', categoryId: 'c1', name: 'Cached', basePrice: 1, displayOrder: 1),
      ];
      when(() => mockRepo.loadMenuLocal('org1')).thenReturn(
          (categories: <Category>[], items: localItems));
      when(() => mockRepo.loadBundlesLocal('org1')).thenReturn(<Bundle>[]);
      when(() => mockRepo.loadAddonsLocal('org1')).thenReturn(<AddonItem>[]);
      when(() => mockRepo.isStale(any())).thenAnswer((_) async => false);

      final notifier = container.read(menuProvider.notifier);
      await notifier.load('org1');

      final state = container.read(menuProvider);
      expect(state.items.single.id, 'm1');
      expect(state.freshness, DataFreshness.live);
      verifyNever(() => mockRepo.fetchMenuFresh(any()));
    });

    test('load keeps local data and demotes freshness when network fails',
        () async {
      final localItems = <MenuItem>[
        makeMenuItem(id: 'm1', orgId: 'o', categoryId: 'c1', name: 'Cached', basePrice: 1, displayOrder: 1),
      ];
      when(() => mockRepo.loadMenuLocal('org1')).thenReturn(
          (categories: <Category>[], items: localItems));
      when(() => mockRepo.fetchMenuFresh('org1'))
          .thenThrow(Exception('Network error'));
      when(() => mockRepo.fetchBundlesFresh('org1'))
          .thenThrow(Exception('Network error'));
      when(() => mockRepo.fetchAddonsFresh('org1'))
          .thenThrow(Exception('Network error'));

      final notifier = container.read(menuProvider.notifier);
      await notifier.load('org1');

      final state = container.read(menuProvider);
      expect(state.isLoading, false);
      expect(state.items.single.id, 'm1');
      expect(state.freshness, DataFreshness.offline);
      expect(state.error, isNull, reason: 'cached data is still shown');
    });

    test('selectCategory updates selected id', () {
      final notifier = container.read(menuProvider.notifier);
      notifier.selectCategory('c2');
      expect(container.read(menuProvider).selectedCategoryId, 'c2');
    });
  });
}
