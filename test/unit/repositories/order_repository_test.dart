import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sufrix_pos/core/api/order_api.dart';
import 'package:sufrix_pos/core/db/app_database.dart';
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
  sqfliteFfiInit();

  setUpAll(() {
    registerFallbackValue(<Map<String, dynamic>>[]);
  });

  late Database db;
  late MockOrderApi mockApi;
  late MockStorageService mockStorage;
  late OrderRepository repo;

  setUp(() async {
    db = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(singleInstance: false),
    );
    await AppDatabase.createSchema(db);
    mockApi = MockOrderApi();
    mockStorage = MockStorageService();
    repo = OrderRepository(mockApi, mockStorage, AppDatabase.forTesting(db));
  });

  tearDown(() async => db.close());

  group('OrderRepository', () {
    final sampleOrder = Order(
      id: 'o1', branchId: 'b1', shiftId: 's1',
      tellerId: 't1', tellerName: 'Teller',
      orderType: 'dine_in', deliveryFee: 0,
      orderNumber: 1, status: 'completed',
      paymentMethod: 'cash', subtotal: 10, discountValue: 0,
      discountAmount: 0, taxAmount: 0, totalAmount: 10,
      items: const [], createdAt: DateTime.now(),
    );

    test('create delegates to api', () async {
      when(() => mockApi.create(
        branchId: 'b1', shiftId: 's1', paymentMethod: 'cash', items: [],
        customerName: null, discountType: null, discountValue: null,
        discountId: null, amountTendered: null, tipAmount: null,
        tipPaymentMethod: null, paymentSplits: null, idempotencyKey: 'key',
        createdAt: null,
      )).thenAnswer((_) async => sampleOrder);

      final result = await repo.create(
        branchId: 'b1', shiftId: 's1', cart: FakeCartState(),
        idempotencyKey: 'key',
      );

      expect(result.id, 'o1');
    });

    test('fetchOrdersFresh fetches, persists and bumps sync_meta', () async {
      when(() => mockApi.list(shiftId: 's1'))
          .thenAnswer((_) async => [sampleOrder]);
      when(() => mockStorage.saveOrders('s1', any()))
          .thenAnswer((_) async {});

      final result = await repo.fetchOrdersFresh('s1');

      expect(result.single.id, 'o1');
      verify(() => mockStorage.saveOrders('s1', any())).called(1);
      expect(await repo.isStale('orders:s1'), isFalse,
          reason: 'a fresh fetch must bump sync_meta');
    });

    test('fetchOrdersFresh rethrows on network error (no silent fallback)',
        () async {
      when(() => mockApi.list(shiftId: 's1')).thenThrow(Exception('Error'));

      await expectLater(repo.fetchOrdersFresh('s1'), throwsException);
      verifyNever(() => mockStorage.saveOrders(any(), any()));
    });

    test('loadOrdersLocal parses cached orders', () {
      when(() => mockStorage.loadOrders('s1'))
          .thenReturn([sampleOrder.toJson()]);

      final result = repo.loadOrdersLocal('s1');

      expect(result, isNotNull);
      expect(result!.single.id, 'o1');
    });

    test('loadOrdersLocal returns null when cache is empty or corrupt', () {
      when(() => mockStorage.loadOrders('s1')).thenReturn(null);
      expect(repo.loadOrdersLocal('s1'), isNull);

      when(() => mockStorage.loadOrders('s1')).thenReturn([
        {'not': 'an order'},
      ]);
      expect(repo.loadOrdersLocal('s1'), isNull);
    });

    test('getOrder delegates to api', () async {
      // The old get-with-single-order-cache behaviour was removed: a single
      // order detail is always fetched live (history list covers offline).
      when(() => mockApi.get('o1')).thenAnswer((_) async => sampleOrder);

      final result = await repo.getOrder('o1');

      expect(result.id, 'o1');
      verify(() => mockApi.get('o1')).called(1);
    });

    test('voidOrder delegates to api with default reason', () async {
      when(() => mockApi.voidOrder('o1',
              reason: 'No reason provided', restoreInventory: false))
          .thenAnswer((_) async => sampleOrder);

      final result = await repo.voidOrder('o1');

      expect(result.id, 'o1');
    });

    test('saveOrdersToCache awaits the storage write', () async {
      when(() => mockStorage.saveOrders('s1', any()))
          .thenAnswer((_) async {});

      await repo.saveOrdersToCache('s1', [sampleOrder]);

      verify(() => mockStorage.saveOrders('s1', any())).called(1);
    });

    test('loadCachedOrders loads from storage', () {
      when(() => mockStorage.loadOrders('s1'))
          .thenReturn([sampleOrder.toJson()]);

      final result = repo.loadCachedOrders('s1');

      expect(result, isNotNull);
      expect(result!.single.id, 'o1');
    });
  });
}
