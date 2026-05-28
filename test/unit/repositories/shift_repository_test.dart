import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/inventory_api.dart';
import 'package:sufrix_pos/core/api/order_api.dart';
import 'package:sufrix_pos/core/api/shift_api.dart';
import 'package:sufrix_pos/core/models/inventory.dart';
import 'package:sufrix_pos/core/models/order.dart';
import 'package:sufrix_pos/core/models/shift.dart';
import 'package:sufrix_pos/core/models/shift_report.dart';
import 'package:sufrix_pos/core/repositories/shift_repository.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

class MockShiftApi extends Mock implements ShiftApi {}
class MockOrderApi extends Mock implements OrderApi {}
class MockInventoryApi extends Mock implements InventoryApi {}
class MockStorageService extends Mock implements StorageService {}

void main() {
  late MockShiftApi mockShiftApi;
  late MockOrderApi mockOrderApi;
  late MockInventoryApi mockInventoryApi;
  late MockStorageService mockStorage;
  late ProviderContainer container;

  setUp(() {
    mockShiftApi = MockShiftApi();
    mockOrderApi = MockOrderApi();
    mockInventoryApi = MockInventoryApi();
    mockStorage = MockStorageService();
    
    container = ProviderContainer(overrides: [
      shiftApiProvider.overrideWithValue(mockShiftApi),
      orderApiProvider.overrideWithValue(mockOrderApi),
      inventoryApiProvider.overrideWithValue(mockInventoryApi),
      storageServiceProvider.overrideWithValue(mockStorage),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  group('ShiftRepository', () {
    final sampleShift = Shift(
      id: 's1', branchId: 'b1', tellerId: 't1', tellerName: 'Teller', 
      status: 'open', openingCash: 100, openedAt: DateTime.now(),
    );

    test('currentShift fetches and saves to cache', () async {
      final preFill = ShiftPreFill(hasOpenShift: true, openShift: sampleShift, suggestedOpeningCash: 100);
      when(() => mockShiftApi.current('b1')).thenAnswer((_) async => preFill);
      when(() => mockStorage.saveShift('b1', any())).thenAnswer((_) async {});

      final repo = container.read(shiftRepositoryProvider);
      final result = await repo.currentShift('b1');

      expect(result.hasOpenShift, true);
      verify(() => mockStorage.saveShift('b1', any())).called(1);
    });

    test('currentShift removes from cache if no open shift', () async {
      final preFill = ShiftPreFill(hasOpenShift: false, openShift: null, suggestedOpeningCash: 100);
      when(() => mockShiftApi.current('b1')).thenAnswer((_) async => preFill);
      when(() => mockStorage.removeShift('b1')).thenAnswer((_) async {});

      final repo = container.read(shiftRepositoryProvider);
      final result = await repo.currentShift('b1');

      expect(result.hasOpenShift, false);
      verify(() => mockStorage.removeShift('b1')).called(1);
    });

    test('currentShift falls back to cache on error', () async {
      when(() => mockShiftApi.current('b1')).thenThrow(Exception('Error'));
      when(() => mockStorage.loadShift('b1')).thenReturn(sampleShift.toJson());

      final repo = container.read(shiftRepositoryProvider);
      final result = await repo.currentShift('b1');

      expect(result.openShift?.id, 's1');
      expect(result.hasOpenShift, true);
    });

    test('listShifts fetches and saves to cache', () async {
      when(() => mockShiftApi.list('b1')).thenAnswer((_) async => [sampleShift]);
      when(() => mockStorage.saveShifts('b1', any())).thenAnswer((_) async {});

      final repo = container.read(shiftRepositoryProvider);
      final result = await repo.listShifts('b1');

      expect(result.length, 1);
      verify(() => mockStorage.saveShifts('b1', any())).called(1);
    });

    test('listShifts falls back to cache on error', () async {
      when(() => mockShiftApi.list('b1')).thenThrow(Exception('Error'));
      when(() => mockStorage.loadShifts('b1')).thenReturn([sampleShift.toJson()]);

      final repo = container.read(shiftRepositoryProvider);
      final result = await repo.listShifts('b1');

      expect(result.length, 1);
    });

    test('openShift delegates to api and saves to cache', () async {
      when(() => mockShiftApi.open('b1', 100)).thenAnswer((_) async => sampleShift);
      when(() => mockStorage.saveShift('b1', any())).thenAnswer((_) async {});

      final repo = container.read(shiftRepositoryProvider);
      final result = await repo.openShift('b1', 100);

      expect(result.id, 's1');
      verify(() => mockStorage.saveShift('b1', any())).called(1);
    });

    test('closeShift delegates to api and removes from cache', () async {
      when(() => mockShiftApi.close('s1', closingCash: 100, note: null, inventoryCounts: []))
          .thenAnswer((_) async => sampleShift);
      when(() => mockStorage.removeShift('b1')).thenAnswer((_) async {});

      final repo = container.read(shiftRepositoryProvider);
      final result = await repo.closeShift('s1', branchId: 'b1', closingCash: 100, inventoryCounts: []);

      expect(result.id, 's1');
      verify(() => mockStorage.removeShift('b1')).called(1);
    });

    test('getSystemCash calculates cash correctly', () async {
      final order1 = Order(
        id: 'o1', branchId: 'b1', shiftId: 's1', tellerId: 't1', tellerName: 'Teller', 
        status: 'completed', paymentMethod: 'cash', orderNumber: 1, 
        amountTendered: 10, subtotal: 10, discountValue: 0, discountAmount: 0, 
        taxAmount: 0, totalAmount: 10, items: [], createdAt: DateTime.now(),
      );
      final order2 = Order(
        id: 'o2', branchId: 'b1', shiftId: 's1', tellerId: 't1', tellerName: 'Teller', 
        status: 'completed', paymentMethod: 'card', orderNumber: 2, 
        amountTendered: 10, subtotal: 10, discountValue: 0, discountAmount: 0, 
        taxAmount: 0, totalAmount: 10, items: [], createdAt: DateTime.now(),
      );

      when(() => mockOrderApi.list(shiftId: 's1')).thenAnswer((_) async => [order1, order2]);
      when(() => mockShiftApi.cashMovementsTotal('s1')).thenAnswer((_) async => 50);

      final repo = container.read(shiftRepositoryProvider);
      final result = await repo.getSystemCash('s1', 100);

      // opening(100) + cashOrder(10) + movements(50) = 160
      expect(result, 160);
    });

    test('getInventory fetches and saves to cache', () async {
      final item = InventoryItem(
        id: 'i1', name: 'Item 1', currentStock: 10, unit: 'pcs',
      );
      when(() => mockInventoryApi.items('b1')).thenAnswer((_) async => [item]);
      when(() => mockStorage.saveInventory('b1', any())).thenAnswer((_) async {});

      final repo = container.read(shiftRepositoryProvider);
      final result = await repo.getInventory('b1');

      expect(result.length, 1);
      verify(() => mockStorage.saveInventory('b1', any())).called(1);
    });

    test('getInventory falls back to cache on error', () async {
      when(() => mockInventoryApi.items('b1')).thenThrow(Exception('Error'));
      final item = InventoryItem(
        id: 'i1', name: 'Item 1', currentStock: 10, unit: 'pcs',
      );
      when(() => mockStorage.loadInventory('b1')).thenReturn([item.toJson()]);

      final repo = container.read(shiftRepositoryProvider);
      final result = await repo.getInventory('b1');

      expect(result.length, 1);
    });

    test('getReport fetches and saves to cache', () async {
      final report = ShiftReport(
        shiftId: 's1', branchId: 'b1', tellerName: 'Teller', status: 'closed', openingCash: 100,
        openedAt: DateTime.now(), paymentSummary: [], cashMovements: [],
        totalPayments: 100, totalReturns: 0, netPayments: 100,
        cashMovementsIn: 0, cashMovementsOut: 0, printedAt: DateTime.now(),
      );
      when(() => mockShiftApi.getReport('s1')).thenAnswer((_) async => report);
      when(() => mockStorage.saveShiftReport('s1', any())).thenAnswer((_) async {});

      final repo = container.read(shiftRepositoryProvider);
      final result = await repo.getReport('s1');

      expect(result.shiftId, 's1');
      verify(() => mockStorage.saveShiftReport('s1', any())).called(1);
    });

    test('getReport falls back to cache on error', () async {
      when(() => mockShiftApi.getReport('s1')).thenThrow(Exception('Error'));
      final report = ShiftReport(
        shiftId: 's1', branchId: 'b1', tellerName: 'Teller', status: 'closed', openingCash: 100,
        openedAt: DateTime.now(), paymentSummary: [], cashMovements: [],
        totalPayments: 100, totalReturns: 0, netPayments: 100,
        cashMovementsIn: 0, cashMovementsOut: 0, printedAt: DateTime.now(),
      );
      when(() => mockStorage.loadShiftReport('s1')).thenReturn(report.toJson());

      final repo = container.read(shiftRepositoryProvider);
      final result = await repo.getReport('s1');

      expect(result.shiftId, 's1');
    });
  });
}
