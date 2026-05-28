import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/menu_api.dart';
import 'package:sufrix_pos/core/models/bundle.dart';
import 'package:sufrix_pos/core/models/menu.dart';
import 'package:sufrix_pos/core/repositories/menu_repository.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

class MockMenuApi extends Mock implements MenuApi {}
class MockStorageService extends Mock implements StorageService {}

void main() {
  late MockMenuApi mockApi;
  late MockStorageService mockStorage;
  late ProviderContainer container;

  setUp(() {
    mockApi = MockMenuApi();
    mockStorage = MockStorageService();
    
    container = ProviderContainer(overrides: [
      menuApiProvider.overrideWithValue(mockApi),
      storageServiceProvider.overrideWithValue(mockStorage),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  group('MenuRepository', () {
    test('fetchMenu fetches and saves to cache', () async {
      final category = Category(id: 'c1', name: 'Cat 1', displayOrder: 1, isActive: true);
      final item = MenuItem(
        id: 'i1', orgId: 'org1', categoryId: 'c1', name: 'Item 1', 
        basePrice: 10, displayOrder: 1, isActive: true
      );
      
      when(() => mockApi.categories('org1')).thenAnswer((_) async => [category]);
      when(() => mockApi.items('org1')).thenAnswer((_) async => [item]);
      when(() => mockStorage.saveMenu('org1', any())).thenAnswer((_) async {});

      final repo = container.read(menuRepositoryProvider);
      final result = await repo.fetchMenu('org1');

      expect(result.categories.length, 1);
      expect(result.items.length, 1);
      expect(result.fromCache, false);
      verify(() => mockStorage.saveMenu('org1', any())).called(1);
    });

    test('fetchMenu falls back to cache on error', () async {
      when(() => mockApi.categories('org1')).thenThrow(Exception('Error'));
      
      final category = Category(id: 'c2', name: 'Cat 2', displayOrder: 1, isActive: true);
      final item = MenuItem(
        id: 'i2', orgId: 'org1', categoryId: 'c2', name: 'Item 2', 
        basePrice: 10, displayOrder: 1, isActive: true
      );

      when(() => mockStorage.loadMenu('org1')).thenReturn({
        'categories': [category.toJson()],
        'items': [item.toJson()],
      });

      final repo = container.read(menuRepositoryProvider);
      final result = await repo.fetchMenu('org1');

      expect(result.categories.length, 1);
      expect(result.items.length, 1);
      expect(result.categories.first.id, 'c2');
      expect(result.fromCache, true);
    });

    test('fetchItem fetches and saves to cache', () async {
      final item = MenuItem(
        id: 'i3', orgId: 'org1', categoryId: 'c1', name: 'Item 3', 
        basePrice: 10, displayOrder: 1, isActive: true
      );
      
      when(() => mockApi.item('i3')).thenAnswer((_) async => item);
      when(() => mockStorage.saveMenuItem('i3', any())).thenAnswer((_) async {});

      final repo = container.read(menuRepositoryProvider);
      final result = await repo.fetchItem('i3');

      expect(result.id, 'i3');
      verify(() => mockStorage.saveMenuItem('i3', any())).called(1);
    });

    test('fetchItem falls back to cache on error', () async {
      when(() => mockApi.item('i3')).thenThrow(Exception('Error'));
      
      final item = MenuItem(
        id: 'i3', orgId: 'org1', categoryId: 'c1', name: 'Item 3', 
        basePrice: 10, displayOrder: 1, isActive: true
      );
      
      when(() => mockStorage.loadMenuItem('i3')).thenReturn(item.toJson());

      final repo = container.read(menuRepositoryProvider);
      final result = await repo.fetchItem('i3');

      expect(result.id, 'i3');
    });

    test('fetchAddonItems fetches and saves to cache', () async {
      final addon = AddonItem(
        id: 'a1', name: 'Addon 1', addonType: 'topping',
        defaultPrice: 5, isActive: true, displayOrder: 1,
      );
      
      when(() => mockApi.addonItems('org1')).thenAnswer((_) async => [addon]);
      when(() => mockStorage.saveAddons('org1', any())).thenAnswer((_) async {});

      final repo = container.read(menuRepositoryProvider);
      final result = await repo.fetchAddonItems('org1');

      expect(result.length, 1);
      expect(result.first.id, 'a1');
      verify(() => mockStorage.saveAddons('org1', any())).called(1);
    });

    test('fetchAddonItems falls back to cache on error', () async {
      when(() => mockApi.addonItems('org1')).thenThrow(Exception('Error'));
      
      final addon = AddonItem(
        id: 'a2', name: 'Addon 2', addonType: 'topping',
        defaultPrice: 5, isActive: true, displayOrder: 1,
      );
      
      when(() => mockStorage.loadAddons('org1')).thenReturn([addon.toJson()]);

      final repo = container.read(menuRepositoryProvider);
      final result = await repo.fetchAddonItems('org1');

      expect(result.length, 1);
      expect(result.first.id, 'a2');
    });

    test('fetchBundles fetches and saves to cache', () async {
      final bundle = Bundle(
        id: 'b1', orgId: 'org1', name: 'Bundle 1', 
        status: BundleStatus.active, price: 15, displayOrder: 1,
        components: [],
      );
      
      when(() => mockApi.bundles('org1', updatedSince: null)).thenAnswer((_) async => [bundle]);
      when(() => mockStorage.saveBundles('org1', any())).thenAnswer((_) async {});

      final repo = container.read(menuRepositoryProvider);
      final result = await repo.fetchBundles('org1');

      expect(result.bundles.length, 1);
      expect(result.fromCache, false);
      verify(() => mockStorage.saveBundles('org1', any())).called(1);
    });

    test('fetchBundles falls back to cache on error', () async {
      when(() => mockApi.bundles('org1', updatedSince: null)).thenThrow(Exception('Error'));
      
      final bundle = Bundle(
        id: 'b2', orgId: 'org1', name: 'Bundle 2', 
        status: BundleStatus.active, price: 15, displayOrder: 1,
        components: [],
      );
      
      when(() => mockStorage.loadBundles('org1')).thenReturn([bundle.toJson()]);

      final repo = container.read(menuRepositoryProvider);
      final result = await repo.fetchBundles('org1');

      expect(result.bundles.length, 1);
      expect(result.bundles.first.id, 'b2');
      expect(result.fromCache, true);
    });
  });
}
