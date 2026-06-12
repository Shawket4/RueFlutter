import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sufrix_pos/core/api/menu_api.dart';
import 'package:sufrix_pos/core/db/app_database.dart';
import 'package:sufrix_pos/core/models/bundle.dart';
import 'package:sufrix_pos/core/models/menu.dart';
import 'package:sufrix_pos/core/repositories/menu_repository.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

import '../../helpers/model_fixtures.dart';

class MockMenuApi extends Mock implements MenuApi {}

class MockStorageService extends Mock implements StorageService {}

void main() {
  sqfliteFfiInit();

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
    registerFallbackValue(<Map<String, dynamic>>[]);
  });

  late Database db;
  late MockMenuApi mockApi;
  late MockStorageService mockStorage;
  late MenuRepository repo;

  setUp(() async {
    db = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(singleInstance: false),
    );
    await AppDatabase.createSchema(db);
    mockApi = MockMenuApi();
    mockStorage = MockStorageService();
    repo = MenuRepository(mockApi, mockStorage, AppDatabase.forTesting(db));
  });

  tearDown(() async => db.close());

  Category category(String id) =>
      makeCategory(id: id, name: 'Cat $id', displayOrder: 1, isActive: true);

  MenuItem item(String id) => makeMenuItem(
        id: id,
        orgId: 'org1',
        categoryId: 'c1',
        name: 'Item $id',
        basePrice: 10,
        displayOrder: 1,
        isActive: true,
      );

  AddonItem addon(String id) => makeAddonItem(
        id: id,
        name: 'Addon $id',
        addonType: 'topping',
        defaultPrice: 5,
        isActive: true,
        displayOrder: 1,
      );

  Bundle bundle(String id, {BundleStatus status = BundleStatus.active}) =>
      makeBundle(
        id: id,
        orgId: 'org1',
        name: 'Bundle $id',
        status: status,
        price: 15,
        displayOrder: 1,
        components: const [],
      );

  group('MenuRepository — menu', () {
    test('fetchMenuFresh fetches, persists and bumps sync_meta', () async {
      when(() => mockApi.categories('org1'))
          .thenAnswer((_) async => [category('c1')]);
      when(() => mockApi.items('org1')).thenAnswer((_) async => [item('i1')]);
      when(() => mockStorage.saveMenu('org1', any())).thenAnswer((_) async {});

      final result = await repo.fetchMenuFresh('org1');

      expect(result.categories.single.id, 'c1');
      expect(result.items.single.id, 'i1');
      verify(() => mockStorage.saveMenu('org1', any())).called(1);
      expect(await repo.isStale('menu:org1'), isFalse,
          reason: 'a fresh fetch must bump sync_meta');
    });

    test('fetchMenuFresh rethrows on network error (no silent fallback)',
        () async {
      when(() => mockApi.categories('org1')).thenThrow(Exception('Error'));
      when(() => mockApi.items('org1')).thenAnswer((_) async => [item('i1')]);

      await expectLater(repo.fetchMenuFresh('org1'), throwsException);
      verifyNever(() => mockStorage.saveMenu(any(), any()));
    });

    test('loadMenuLocal parses cached blob', () {
      when(() => mockStorage.loadMenu('org1')).thenReturn({
        'categories': [category('c2').toJson()],
        'items': [item('i2').toJson()],
      });

      final result = repo.loadMenuLocal('org1');

      expect(result, isNotNull);
      expect(result!.categories.single.id, 'c2');
      expect(result.items.single.id, 'i2');
    });

    test('loadMenuLocal returns null when cache is empty or corrupt', () {
      when(() => mockStorage.loadMenu('org1')).thenReturn(null);
      expect(repo.loadMenuLocal('org1'), isNull);

      when(() => mockStorage.loadMenu('org1'))
          .thenReturn({'categories': 'garbage', 'items': 42});
      expect(repo.loadMenuLocal('org1'), isNull);
    });
  });

  group('MenuRepository — bundles', () {
    test('fetchBundlesFresh fetches, persists and bumps sync_meta', () async {
      when(() => mockApi.bundles('org1', updatedSince: null))
          .thenAnswer((_) async => [bundle('b1')]);
      when(() => mockStorage.saveBundles('org1', any()))
          .thenAnswer((_) async {});

      final result = await repo.fetchBundlesFresh('org1');

      expect(result.single.id, 'b1');
      verify(() => mockStorage.saveBundles('org1', any())).called(1);
      expect(await repo.isStale('bundles:org1'), isFalse);
    });

    test('loadBundlesLocal keeps only active bundles', () {
      when(() => mockStorage.loadBundles('org1')).thenReturn([
        bundle('b1').toJson(),
        bundle('b2', status: BundleStatus.draft).toJson(),
      ]);

      final result = repo.loadBundlesLocal('org1');

      expect(result, isNotNull);
      expect(result!.map((b) => b.id), ['b1']);
    });

    test('loadBundlesLocal returns null when nothing is cached', () {
      when(() => mockStorage.loadBundles('org1')).thenReturn(null);
      expect(repo.loadBundlesLocal('org1'), isNull);
    });
  });

  group('MenuRepository — addons', () {
    test('fetchAddonsFresh fetches, persists and bumps sync_meta', () async {
      when(() => mockApi.addonItems('org1'))
          .thenAnswer((_) async => [addon('a1')]);
      when(() => mockStorage.saveAddons('org1', any()))
          .thenAnswer((_) async {});

      final result = await repo.fetchAddonsFresh('org1');

      expect(result.single.id, 'a1');
      verify(() => mockStorage.saveAddons('org1', any())).called(1);
      expect(await repo.isStale('addons:org1'), isFalse);
    });

    test('loadAddonsLocal parses cached list', () {
      when(() => mockStorage.loadAddons('org1'))
          .thenReturn([addon('a2').toJson()]);

      final result = repo.loadAddonsLocal('org1');

      expect(result, isNotNull);
      expect(result!.single.id, 'a2');
    });
  });

  group('MenuRepository — single item', () {
    test('fetchItem fetches and saves to cache', () async {
      when(() => mockApi.item('i3')).thenAnswer((_) async => item('i3'));
      when(() => mockStorage.saveMenuItem('i3', any()))
          .thenAnswer((_) async {});

      final result = await repo.fetchItem('i3');

      expect(result.id, 'i3');
      verify(() => mockStorage.saveMenuItem('i3', any())).called(1);
    });

    test('fetchItem falls back to cache on error', () async {
      when(() => mockApi.item('i3')).thenThrow(Exception('Error'));
      when(() => mockStorage.loadMenuItem('i3'))
          .thenReturn(item('i3').toJson());

      final result = await repo.fetchItem('i3');

      expect(result.id, 'i3');
    });
  });

  group('MenuRepository — isStale', () {
    test('true when entity absent, true again after the TTL elapses',
        () async {
      expect(await repo.isStale('menu:org1'), isTrue);

      final old =
          DateTime.now().millisecondsSinceEpoch - 11 * 60 * 1000; // > 10m TTL
      await db.insert(
          'sync_meta', {'entity': 'menu:org1', 'last_synced_at': old});
      expect(await repo.isStale('menu:org1'), isTrue);

      await db.update(
        'sync_meta',
        {'last_synced_at': DateTime.now().millisecondsSinceEpoch},
        where: 'entity = ?',
        whereArgs: ['menu:org1'],
      );
      expect(await repo.isStale('menu:org1'), isFalse);
    });
  });
}
