import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/discount_api.dart';
import 'package:sufrix_pos/core/models/discount.dart';
import 'package:sufrix_pos/core/providers/discount_notifier.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

import '../../helpers/model_fixtures.dart';

class MockDiscountApi extends Mock implements DiscountApi {}
class MockStorageService extends Mock implements StorageService {}

void main() {
  late MockDiscountApi mockApi;
  late MockStorageService mockStorage;
  late ProviderContainer container;

  setUp(() {
    mockApi = MockDiscountApi();
    mockStorage = MockStorageService();

    container = ProviderContainer(overrides: [
      discountApiProvider.overrideWithValue(mockApi),
      storageServiceProvider.overrideWithValue(mockStorage),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  group('DiscountNotifier', () {
    test('load fetches from api and caches', () async {
      when(() => mockStorage.loadDiscounts('org1')).thenReturn([]);
      when(() => mockStorage.saveDiscounts('org1', any())).thenAnswer((_) async {});
      
      final List<Discount> discounts = [
        makeDiscount(id: 'd1', orgId: 'org1', name: '10% Off', dtype: 'percentage', value: 10)
      ];
      when(() => mockApi.list('org1')).thenAnswer((_) async => discounts);

      final notifier = container.read(discountProvider.notifier);
      await notifier.load('org1');

      final state = container.read(discountProvider);
      expect(state.items.length, 1);
      expect(state.items[0].name, '10% Off');
      expect(state.loadedOrgId, 'org1');
      
      verify(() => mockStorage.saveDiscounts('org1', any())).called(1);
    });

    test('load uses cache initially', () async {
      final cachedDiscounts = [
        {
          'id': 'd1',
          'org_id': 'org1',
          'name': 'Cached',
          'name_translations': <String, dynamic>{},
          'dtype': 'percentage',
          'value': 10,
          'is_active': true,
          'created_at': '2026-01-01T00:00:00.000Z',
          'updated_at': '2026-01-01T00:00:00.000Z',
        }
      ];
      when(() => mockStorage.loadDiscounts('org1')).thenReturn(cachedDiscounts);
      when(() => mockStorage.saveDiscounts('org1', any())).thenAnswer((_) async {});
      when(() => mockApi.list('org1')).thenAnswer((_) async => []);

      final notifier = container.read(discountProvider.notifier);
      // It should load cache synchronously during load before api call finishes
      final future = notifier.load('org1');
      
      // Right after load starts, state should have cached items
      expect(container.read(discountProvider).items.length, 1);
      expect(container.read(discountProvider).items[0].name, 'Cached');

      await future; // Api returns empty, overwrites cache
      expect(container.read(discountProvider).items.length, 0);
    });

    test('load avoids redundant fetches if not forced', () async {
      when(() => mockStorage.loadDiscounts('org1')).thenReturn([]);
      when(() => mockStorage.saveDiscounts('org1', any())).thenAnswer((_) async {});
      
      final List<Discount> discounts = [
        makeDiscount(id: 'd1', orgId: 'org1', name: '10% Off', dtype: 'percentage', value: 10)
      ];
      when(() => mockApi.list('org1')).thenAnswer((_) async => discounts);

      final notifier = container.read(discountProvider.notifier);
      await notifier.load('org1');

      // Call load again
      await notifier.load('org1');
      
      // Should only hit api once
      verify(() => mockApi.list('org1')).called(1);

      // Call load with force = true
      await notifier.load('org1', force: true);
      verify(() => mockApi.list('org1')).called(1); // called 1 more time (total 2)
    });

    test('load fallback keeps existing items on error', () async {
      when(() => mockStorage.loadDiscounts('org1')).thenReturn([]);
      when(() => mockStorage.saveDiscounts('org1', any())).thenAnswer((_) async {});
      
      final List<Discount> discounts = [
        makeDiscount(id: 'd1', orgId: 'org1', name: '10% Off', dtype: 'percentage', value: 10)
      ];
      when(() => mockApi.list('org1')).thenAnswer((_) async => discounts);

      final notifier = container.read(discountProvider.notifier);
      await notifier.load('org1'); // Success load

      // Now api throws
      when(() => mockApi.list('org1')).thenThrow(Exception('Network Error'));
      await notifier.load('org1', force: true);

      final state = container.read(discountProvider);
      expect(state.isLoading, false);
      expect(state.items.length, 1); // Kept existing items
    });
  });
}
