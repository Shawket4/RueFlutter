import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/api/order_api.dart';
import 'package:sufrix_pos/core/models/cart.dart';
import 'package:sufrix_pos/core/models/order.dart';
import 'package:sufrix_pos/core/repositories/order_repository.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

class MockOrderApi extends Mock implements OrderApi {}
class MockStorageService extends Mock implements StorageService {}
class FakeCartState extends Fake implements CartState {
  @override
  String get payment => 'cash';
  @override
  List<CartItem> get items => [];
  @override
  String? get customerName => null;
  @override
  DiscountType? get discountType => null;
  @override
  int? get discountValue => null;
  @override
  String? get discountId => null;
  @override
  int? get amountTendered => null;
  @override
  int? get tipAmount => null;
  @override
  List<PaymentSplit>? get paymentSplits => null;
}

void main() {
  late MockOrderApi mockApi;
  late MockStorageService mockStorage;
  late ProviderContainer container;

  setUp(() {
    mockApi = MockOrderApi();
    mockStorage = MockStorageService();
    
    container = ProviderContainer(overrides: [
      orderApiProvider.overrideWithValue(mockApi),
      storageServiceProvider.overrideWithValue(mockStorage),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  group('OrderRepository', () {
    final sampleOrder = Order(
      id: 'o1', branchId: 'b1', shiftId: 's1', 
      tellerId: 't1', tellerName: 'Teller', 
      orderNumber: 1, status: 'completed', 
      paymentMethod: 'cash', subtotal: 10, discountValue: 0,
      discountAmount: 0, taxAmount: 0, totalAmount: 10, 
      items: [], createdAt: DateTime.now(),
    );

    test('create delegates to api', () async {
      when(() => mockApi.create(
        branchId: 'b1', shiftId: 's1', paymentMethod: 'cash', items: [],
        customerName: null, discountType: null, discountValue: null,
        discountId: null, amountTendered: null, tipAmount: null,
        tipPaymentMethod: null, paymentSplits: null, idempotencyKey: 'key',
        createdAt: null,
      )).thenAnswer((_) async => sampleOrder);

      final repo = container.read(orderRepositoryProvider);
      final result = await repo.create(
        branchId: 'b1', shiftId: 's1', cart: FakeCartState(),
        idempotencyKey: 'key',
      );

      expect(result.id, 'o1');
    });

    test('listForShift fetches and saves to cache', () async {
      when(() => mockApi.list(shiftId: 's1')).thenAnswer((_) async => [sampleOrder]);
      when(() => mockStorage.saveOrders('s1', any())).thenAnswer((_) async {});

      final repo = container.read(orderRepositoryProvider);
      final result = await repo.listForShift('s1');

      expect(result.length, 1);
      expect(result.first.id, 'o1');
      verify(() => mockStorage.saveOrders('s1', any())).called(1);
    });

    test('listForShift falls back to cache on error', () async {
      when(() => mockApi.list(shiftId: 's1')).thenThrow(Exception('Error'));
      when(() => mockStorage.loadOrders('s1')).thenReturn([sampleOrder.toJson()]);

      final repo = container.read(orderRepositoryProvider);
      final result = await repo.listForShift('s1');

      expect(result.length, 1);
      expect(result.first.id, 'o1');
    });

    test('get fetches and saves to cache', () async {
      when(() => mockApi.get('o1')).thenAnswer((_) async => sampleOrder);
      when(() => mockStorage.saveOrders('single_o1', any())).thenAnswer((_) async {});

      final repo = container.read(orderRepositoryProvider);
      final result = await repo.get('o1');

      expect(result.id, 'o1');
      verify(() => mockStorage.saveOrders('single_o1', any())).called(1);
    });

    test('get falls back to cache on error', () async {
      when(() => mockApi.get('o1')).thenThrow(Exception('Error'));
      when(() => mockStorage.loadOrders('single_o1')).thenReturn([sampleOrder.toJson()]);

      final repo = container.read(orderRepositoryProvider);
      final result = await repo.get('o1');

      expect(result.id, 'o1');
    });

    test('voidOrder delegates to api', () async {
      when(() => mockApi.voidOrder('o1', reason: 'No reason provided', restoreInventory: false))
          .thenAnswer((_) async => sampleOrder);

      final repo = container.read(orderRepositoryProvider);
      final result = await repo.voidOrder('o1');

      expect(result.id, 'o1');
    });

    test('saveOrdersToCache saves to storage', () {
      when(() => mockStorage.saveOrders('s1', any())).thenAnswer((_) async {});

      final repo = container.read(orderRepositoryProvider);
      repo.saveOrdersToCache('s1', [sampleOrder]);

      verify(() => mockStorage.saveOrders('s1', any())).called(1);
    });

    test('loadCachedOrders loads from storage', () {
      when(() => mockStorage.loadOrders('s1')).thenReturn([sampleOrder.toJson()]);

      final repo = container.read(orderRepositoryProvider);
      final result = repo.loadCachedOrders('s1');

      expect(result, isNotNull);
      expect(result!.length, 1);
      expect(result.first.id, 'o1');
    });
  });
}
