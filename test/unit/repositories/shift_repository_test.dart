import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sufrix_pos/core/api/inventory_api.dart';
import 'package:sufrix_pos/core/api/shift_api.dart';
import 'package:sufrix_pos/core/db/app_database.dart';
import 'package:sufrix_pos/core/models/shift.dart';
import 'package:sufrix_pos/core/models/shift_report.dart';
import 'package:sufrix_pos/core/repositories/shift_repository.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

import '../../helpers/model_fixtures.dart';

class MockShiftApi extends Mock implements ShiftApi {}

class MockInventoryApi extends Mock implements InventoryApi {}

class MockStorageService extends Mock implements StorageService {}

void main() {
  sqfliteFfiInit();

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
    registerFallbackValue(<Map<String, dynamic>>[]);
  });

  late Database db;
  late MockShiftApi mockShiftApi;
  late MockInventoryApi mockInventoryApi;
  late MockStorageService mockStorage;
  late ShiftRepository repo;

  setUp(() async {
    db = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(singleInstance: false),
    );
    await AppDatabase.createSchema(db);
    mockShiftApi = MockShiftApi();
    mockInventoryApi = MockInventoryApi();
    mockStorage = MockStorageService();
    repo = ShiftRepository(
        mockShiftApi, mockInventoryApi, mockStorage, AppDatabase.forTesting(db));
  });

  tearDown(() async => db.close());

  group('ShiftRepository', () {
    final sampleShift = Shift(
      id: 's1', branchId: 'b1', tellerId: 't1', tellerName: 'Teller',
      status: 'open', openingCash: 100, openingCashWasEdited: false,
      openedAt: DateTime.now(),
    );

    ShiftReport report({int openingCash = 100, int? closingCashSystem}) =>
        makeShiftReport(
          shift: makeShift(
            id: 's1', branchId: 'b1', tellerName: 'Teller',
            status: 'closed', openingCash: openingCash,
            closingCashSystem: closingCashSystem,
            openedAt: DateTime.now(),
          ),
          totalPayments: 100, voidedAmount: 0, netPayments: 100,
          cashMovementsIn: 50, cashMovementsOut: 20,
          printedAt: DateTime.now(),
        );

    test('fetchShiftFresh saves the open shift to cache', () async {
      final preFill = ShiftPreFill(
          hasOpenShift: true, openShift: sampleShift, suggestedOpeningCash: 100);
      when(() => mockShiftApi.current('b1')).thenAnswer((_) async => preFill);
      when(() => mockStorage.saveShift('b1', any())).thenAnswer((_) async {});

      final result = await repo.fetchShiftFresh('b1');

      expect(result.hasOpenShift, true);
      verify(() => mockStorage.saveShift('b1', any())).called(1);
      expect(await repo.isStale('shift:b1'), isFalse);
    });

    test('fetchShiftFresh removes from cache when no open shift', () async {
      final preFill = ShiftPreFill(
          hasOpenShift: false, openShift: null, suggestedOpeningCash: 100);
      when(() => mockShiftApi.current('b1')).thenAnswer((_) async => preFill);
      when(() => mockStorage.removeShift('b1')).thenAnswer((_) async {});

      final result = await repo.fetchShiftFresh('b1');

      expect(result.hasOpenShift, false);
      verify(() => mockStorage.removeShift('b1')).called(1);
    });

    test('fetchShiftFresh rethrows on error (no silent fallback)', () async {
      when(() => mockShiftApi.current('b1')).thenThrow(Exception('Error'));

      await expectLater(repo.fetchShiftFresh('b1'), throwsException);
    });

    test('loadShiftLocal builds a pre-fill from the cached shift', () {
      when(() => mockStorage.loadShift('b1')).thenReturn(sampleShift.toJson());

      final result = repo.loadShiftLocal('b1');

      expect(result, isNotNull);
      expect(result!.openShift?.id, 's1');
      expect(result.hasOpenShift, true);
    });

    test('loadShiftLocal returns null with no cache', () {
      when(() => mockStorage.loadShift('b1')).thenReturn(null);
      expect(repo.loadShiftLocal('b1'), isNull);
    });

    test('fetchShiftsFresh fetches and saves to cache', () async {
      when(() => mockShiftApi.list('b1'))
          .thenAnswer((_) async => [sampleShift]);
      when(() => mockStorage.saveShifts('b1', any())).thenAnswer((_) async {});

      final result = await repo.fetchShiftsFresh('b1');

      expect(result.length, 1);
      verify(() => mockStorage.saveShifts('b1', any())).called(1);
      expect(await repo.isStale('shifts:b1'), isFalse);
    });

    test('loadShiftsLocal parses cached shifts', () {
      when(() => mockStorage.loadShifts('b1'))
          .thenReturn([sampleShift.toJson()]);

      final result = repo.loadShiftsLocal('b1');

      expect(result, isNotNull);
      expect(result!.single.id, 's1');
    });

    test('openShift delegates to api and saves to cache', () async {
      when(() => mockShiftApi.open('b1', 100))
          .thenAnswer((_) async => sampleShift);
      when(() => mockStorage.saveShift('b1', any())).thenAnswer((_) async {});

      final result = await repo.openShift('b1', 100);

      expect(result.id, 's1');
      verify(() => mockStorage.saveShift('b1', any())).called(1);
    });

    test('closeShift delegates to api and removes from cache', () async {
      when(() => mockShiftApi.close('s1',
              closingCash: 100, note: null, inventoryCounts: []))
          .thenAnswer((_) async => sampleShift);
      when(() => mockStorage.removeShift('b1')).thenAnswer((_) async {});

      final result = await repo.closeShift('s1',
          branchId: 'b1', closingCash: 100, inventoryCounts: []);

      expect(result.id, 's1');
      verify(() => mockStorage.removeShift('b1')).called(1);
    });

    test('getSystemCash returns the report expected cash', () async {
      // expectedCash = opening(100) + cash payments(0) + in(50) - out(20)
      when(() => mockShiftApi.getReport('s1'))
          .thenAnswer((_) async => report());

      final result = await repo.getSystemCash('s1', 100);

      expect(result, 130);
    });

    test('getSystemCash falls back to opening cash on error', () async {
      when(() => mockShiftApi.getReport('s1')).thenThrow(Exception('Error'));

      final result = await repo.getSystemCash('s1', 100);

      expect(result, 100);
    });

    test('fetchInventoryFresh fetches and saves to cache', () async {
      final item = makeInventoryItem(
        id: 'i1', ingredientName: 'Item 1', currentStock: 10, unit: 'pcs',
      );
      when(() => mockInventoryApi.items('b1'))
          .thenAnswer((_) async => [item]);
      when(() => mockStorage.saveInventory('b1', any()))
          .thenAnswer((_) async {});

      final result = await repo.fetchInventoryFresh('b1');

      expect(result.length, 1);
      verify(() => mockStorage.saveInventory('b1', any())).called(1);
      expect(await repo.isStale('inventory:b1'), isFalse);
    });

    test('loadInventoryLocal parses cached inventory', () {
      final item = makeInventoryItem(
        id: 'i1', ingredientName: 'Item 1', currentStock: 10, unit: 'pcs',
      );
      when(() => mockStorage.loadInventory('b1')).thenReturn([item.toJson()]);

      final result = repo.loadInventoryLocal('b1');

      expect(result, isNotNull);
      expect(result!.single.id, 'i1');
    });

    test('getReport fetches and saves to cache', () async {
      when(() => mockShiftApi.getReport('s1'))
          .thenAnswer((_) async => report());
      when(() => mockStorage.saveShiftReport('s1', any()))
          .thenAnswer((_) async {});

      final result = await repo.getReport('s1');

      expect(result.shiftId, 's1');
      verify(() => mockStorage.saveShiftReport('s1', any())).called(1);
    });

    test('getReport falls back to cache on error', () async {
      when(() => mockShiftApi.getReport('s1')).thenThrow(Exception('Error'));
      when(() => mockStorage.loadShiftReport('s1'))
          .thenReturn(report().toJson());

      final result = await repo.getReport('s1');

      expect(result.shiftId, 's1');
    });
  });
}
