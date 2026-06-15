import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/models/order.dart';
import 'package:sufrix_pos/core/providers/menu_notifier.dart' show DataFreshness;
import 'package:sufrix_pos/core/providers/order_history_notifier.dart';
import 'package:sufrix_pos/core/repositories/order_repository.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

Order order(String id, {String status = 'completed'}) => Order(
      id: id, branchId: 'b', shiftId: 's',
      tellerId: 't', tellerName: 'Teller', status: status,
      orderType: 'dine_in', deliveryFee: 0,
      paymentMethod: 'cash', orderNumber: 1, amountTendered: 10,
      subtotal: 10, discountValue: 0, discountAmount: 0, taxAmount: 0,
      totalAmount: 10, items: const [], createdAt: DateTime.now(),
    );

void main() {
  setUpAll(() {
    registerFallbackValue(<Order>[]);
  });

  late MockOrderRepository mockRepo;
  late ProviderContainer container;

  setUp(() {
    mockRepo = MockOrderRepository();

    // No local cache by default; ConnectivityService.instance.isOnline
    // defaults to true in tests (init() is never called), so loadForShift
    // goes straight to the network refresh.
    when(() => mockRepo.loadOrdersLocal(any())).thenReturn(null);
    when(() => mockRepo.saveOrdersToCache(any(), any()))
        .thenAnswer((_) async {});

    container = ProviderContainer(overrides: [
      orderRepositoryProvider.overrideWithValue(mockRepo),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  group('OrderHistoryNotifier', () {
    test('loadForShift fetches fresh orders successfully', () async {
      when(() => mockRepo.fetchOrdersFresh('s1'))
          .thenAnswer((_) async => [order('o1')]);

      final notifier = container.read(orderHistoryProvider.notifier);
      await notifier.loadForShift('s1');

      final state = container.read(orderHistoryProvider);
      expect(state.isLoading, false);
      expect(state.freshness, DataFreshness.live);
      expect(state.fromCache, false);
      expect(state.orders.length, 1);
      expect(state.orders[0].id, 'o1');
      expect(state.shiftId, 's1');
      expect(state.error, null);
    });

    test('loadForShift skips if already loaded and not forced', () async {
      when(() => mockRepo.fetchOrdersFresh('s1'))
          .thenAnswer((_) async => [order('o1')]);

      final notifier = container.read(orderHistoryProvider.notifier);
      await notifier.loadForShift('s1');

      // Call again — already live.
      await notifier.loadForShift('s1');
      verify(() => mockRepo.fetchOrdersFresh('s1')).called(1);

      // Force refetches.
      await notifier.loadForShift('s1', force: true);
      verify(() => mockRepo.fetchOrdersFresh('s1')).called(1); // 2 total
    });

    test('loadForShift keeps cached orders when the refresh fails', () async {
      when(() => mockRepo.loadOrdersLocal('s1')).thenReturn([order('o2')]);
      when(() => mockRepo.fetchOrdersFresh('s1'))
          .thenThrow(Exception('Network Error'));

      final notifier = container.read(orderHistoryProvider.notifier);
      await notifier.loadForShift('s1');

      final state = container.read(orderHistoryProvider);
      expect(state.isLoading, false);
      expect(state.freshness, DataFreshness.offline);
      expect(state.fromCache, true);
      expect(state.orders.length, 1);
      expect(state.orders[0].id, 'o2');
      expect(state.error, isNull,
          reason: 'cached orders are still shown — no error banner');
    });

    test('loadForShift surfaces an error when fetch fails with no cache',
        () async {
      when(() => mockRepo.fetchOrdersFresh('s1'))
          .thenThrow(Exception('Network Error'));

      final notifier = container.read(orderHistoryProvider.notifier);
      await notifier.loadForShift('s1');

      final state = container.read(orderHistoryProvider);
      expect(state.isLoading, false);
      expect(state.orders, isEmpty);
      expect(state.error, contains('Could not load orders'));
    });

    test('addOrder adds and saves to cache', () async {
      when(() => mockRepo.fetchOrdersFresh('s1')).thenAnswer((_) async => []);

      final notifier = container.read(orderHistoryProvider.notifier);
      await notifier.loadForShift('s1');

      await notifier.addOrder(order('o3'));

      final state = container.read(orderHistoryProvider);
      expect(state.orders.length, 1);
      expect(state.orders[0].id, 'o3');
      verify(() => mockRepo.saveOrdersToCache('s1', any())).called(1);
    });

    test('replaceOrder replaces by id and saves', () async {
      when(() => mockRepo.fetchOrdersFresh('s1'))
          .thenAnswer((_) async => [order('local_1')]);

      final notifier = container.read(orderHistoryProvider.notifier);
      await notifier.loadForShift('s1');

      await notifier.replaceOrder('local_1', order('synced_1'));

      final state = container.read(orderHistoryProvider);
      expect(state.orders.length, 1);
      expect(state.orders[0].id, 'synced_1');
      verify(() => mockRepo.saveOrdersToCache('s1', any())).called(1);
    });

    test('replaceOrder falls back to addOrder if not found', () async {
      when(() => mockRepo.fetchOrdersFresh('s1')).thenAnswer((_) async => []);

      final notifier = container.read(orderHistoryProvider.notifier);
      await notifier.loadForShift('s1');

      await notifier.replaceOrder('non_existent', order('o1'));

      expect(container.read(orderHistoryProvider).orders.length, 1);
      expect(container.read(orderHistoryProvider).orders[0].id, 'o1');
    });

    test('updateOrder updates by id and saves', () async {
      when(() => mockRepo.fetchOrdersFresh('s1'))
          .thenAnswer((_) async => [order('o1', status: 'draft')]);

      final notifier = container.read(orderHistoryProvider.notifier);
      await notifier.loadForShift('s1');

      await notifier.updateOrder(order('o1'));

      final state = container.read(orderHistoryProvider);
      expect(state.orders.length, 1);
      expect(state.orders[0].status, 'completed');
      verify(() => mockRepo.saveOrdersToCache('s1', any())).called(1);
    });

    test('clear resets state', () {
      final notifier = container.read(orderHistoryProvider.notifier);
      notifier.clear();
      expect(container.read(orderHistoryProvider).orders, isEmpty);
      expect(container.read(orderHistoryProvider).shiftId, null);
    });
  });
}
