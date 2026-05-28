import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/models/bundle.dart';
import 'package:sufrix_pos/core/models/menu.dart';
import 'package:sufrix_pos/core/providers/menu_notifier.dart';
import 'package:sufrix_pos/core/repositories/menu_repository.dart';
import 'package:sufrix_pos/core/services/menu_image_cache.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

class MockMenuRepository extends Mock implements MenuRepository {}
class MockMenuImageCache extends Mock implements MenuImageCache {}
class MockStorageService extends Mock implements StorageService {}

void main() {
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
          MenuItem(id: 'm1', orgId: 'o', categoryId: 'c1', name: 'A', isActive: true, basePrice: 10, sizes: [], optionalFields: [], displayOrder: 1),
          MenuItem(id: 'm2', orgId: 'o', categoryId: 'c2', name: 'B', isActive: true, basePrice: 20, sizes: [], optionalFields: [], displayOrder: 2),
        ],
        selectedCategoryId: null,
      );
      expect(state.filtered.length, 2);
    });

    test('filtered returns matching items if selectedCategoryId set', () {
      final state = MenuState(
        items: <MenuItem>[
          MenuItem(id: 'm1', orgId: 'o', categoryId: 'c1', name: 'A', isActive: true, basePrice: 10, sizes: [], optionalFields: [], displayOrder: 1),
          MenuItem(id: 'm2', orgId: 'o', categoryId: 'c2', name: 'B', isActive: true, basePrice: 20, sizes: [], optionalFields: [], displayOrder: 2),
        ],
        selectedCategoryId: 'c1',
      );
      expect(state.filtered.length, 1);
      expect(state.filtered[0].id, 'm1');
    });

    test('hasActiveBundles', () {
      expect(MenuState(bundles: []).hasActiveBundles, false);
      expect(MenuState(bundles: [
        Bundle(id: 'b1', orgId: 'o', name: 'B', price: 10, status: BundleStatus.draft, displayOrder: 1)
      ]).hasActiveBundles, false);
      expect(MenuState(bundles: [
        Bundle(id: 'b1', orgId: 'o', name: 'B', price: 10, status: BundleStatus.active, displayOrder: 1)
      ]).hasActiveBundles, true);
    });

    test('addonsByType groups and sorts', () {
      final state = MenuState(
        allAddons: <AddonItem>[
          AddonItem(id: '1', name: 'A1', addonType: 't1', defaultPrice: 1, isActive: true, displayOrder: 2),
          AddonItem(id: '2', name: 'A2', addonType: 't1', defaultPrice: 1, isActive: true, displayOrder: 1),
          AddonItem(id: '3', name: 'A3', addonType: 't2', defaultPrice: 1, isActive: false, displayOrder: 1),
        ]
      );
      
      final map = state.addonsByType;
      expect(map.keys.length, 1);
      expect(map['t1']!.length, 2);
      expect(map['t1']![0].id, '2'); // displayOrder 1 comes first
      expect(map['t1']![1].id, '1'); // displayOrder 2
    });
  });

  group('MenuNotifier', () {
    test('load fetches and updates state', () async {
      final categories = <Category>[Category(id: 'c1', name: 'Cat 1', isActive: true, displayOrder: 1, imageUrl: 'cat1.png')];
      final items = <MenuItem>[MenuItem(id: 'm1', orgId: 'o', categoryId: 'c1', name: 'Item', isActive: true, basePrice: 10, sizes: [], optionalFields: [], displayOrder: 1, imageUrl: 'item1.png')];
      
      when(() => mockRepo.fetchMenu('org1')).thenAnswer((_) async => (categories: categories, items: items, fromCache: false));
      when(() => mockRepo.fetchBundles('org1')).thenAnswer((_) async => (bundles: <Bundle>[], fromCache: false));
      when(() => mockRepo.fetchAddonItems('org1')).thenAnswer((_) async => []);

      final notifier = container.read(menuProvider.notifier);
      await notifier.load('org1');

      final state = container.read(menuProvider);
      expect(state.isLoading, false);
      expect(state.categories.length, 1);
      expect(state.items.length, 1);
      expect(state.selectedCategoryId, 'c1');
      expect(state.loadedOrgId, 'org1');
      
      verify(() => mockImageCache.warmUp(any())).called(1);
    });

    test('load avoids redundant fetches', () async {
      when(() => mockRepo.fetchMenu('org1')).thenAnswer((_) async => (categories: <Category>[], items: <MenuItem>[MenuItem(id: 'm', orgId: 'o', categoryId: 'c', name: 'N', isActive: true, basePrice: 1, sizes: [], optionalFields: [], displayOrder: 1)], fromCache: false));
      when(() => mockRepo.fetchBundles('org1')).thenAnswer((_) async => (bundles: <Bundle>[], fromCache: false));
      when(() => mockRepo.fetchAddonItems('org1')).thenAnswer((_) async => []);

      final notifier = container.read(menuProvider.notifier);
      await notifier.load('org1');
      
      // Call again
      await notifier.load('org1');
      verify(() => mockRepo.fetchMenu('org1')).called(1);

      // Force
      await notifier.load('org1', force: true);
      verify(() => mockRepo.fetchMenu('org1')).called(1); // total 2
    });

    test('selectCategory updates selected id', () {
      final notifier = container.read(menuProvider.notifier);
      notifier.selectCategory('c2');
      expect(container.read(menuProvider).selectedCategoryId, 'c2');
    });

    test('gridEntriesForCategory Combos view', () {
      final notifier = container.read(menuProvider.notifier);
      final bundles = [
        Bundle(id: 'b1', orgId: 'o', name: 'B1', price: 10, status: BundleStatus.active, displayOrder: 2),
        Bundle(id: 'b2', orgId: 'o', name: 'B2', price: 10, status: BundleStatus.active, displayOrder: 1),
      ];
      // Inject state manually
      notifier.state = MenuState(bundles: bundles, selectedCategoryId: kComboCategoryId);

      final entries = notifier.state.gridEntriesForCategory(branchId: 'b1', inventory: []);
      expect(entries.length, 2);
      expect(entries[0].kind == MenuGridEntryKind.bundle, true);
      expect(entries[0].bundle!.id, 'b2'); // Sorted by displayOrder
    });

    test('gridEntriesForCategory regular view', () {
      final notifier = container.read(menuProvider.notifier);
      final items = <MenuItem>[
        MenuItem(id: 'm1', orgId: 'o', categoryId: 'c1', name: 'M1', isActive: true, basePrice: 1, sizes: [], optionalFields: [], displayOrder: 2),
        MenuItem(id: 'm2', orgId: 'o', categoryId: 'c1', name: 'M2', isActive: true, basePrice: 1, sizes: [], optionalFields: [], displayOrder: 1),
        MenuItem(id: 'm3', orgId: 'o', categoryId: 'c2', name: 'M3', isActive: true, basePrice: 1, sizes: [], optionalFields: [], displayOrder: 1),
      ];
      notifier.state = MenuState(items: items, selectedCategoryId: 'c1');

      final entries = notifier.state.gridEntriesForCategory(branchId: 'b1', inventory: []);
      expect(entries.length, 2);
      expect(entries[0].item!.id, 'm2'); // Sorted by displayOrder
      expect(entries[1].item!.id, 'm1');
    });

    test('searchBundles', () {
      final notifier = container.read(menuProvider.notifier);
      final bundles = [
        Bundle(id: 'b1', orgId: 'o', name: 'Combo Meal', price: 10, status: BundleStatus.active, displayOrder: 1),
        Bundle(id: 'b2', orgId: 'o', name: 'Burger Deal', price: 10, status: BundleStatus.active, displayOrder: 2),
      ];
      notifier.state = MenuState(bundles: bundles);

      final result = notifier.state.searchBundles('meal', branchId: 'b1', inventory: []);
      expect(result.length, 1);
      expect(result[0].id, 'b1');
    });
  });
}
