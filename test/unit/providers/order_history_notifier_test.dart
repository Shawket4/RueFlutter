import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/models/order.dart';
import 'package:sufrix_pos/core/providers/order_history_notifier.dart';
import 'package:sufrix_pos/core/repositories/order_repository.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

void main() {
  late MockOrderRepository mockRepo;
  late ProviderContainer container;

  setUp(() {
    mockRepo = MockOrderRepository();
    container = ProviderContainer(overrides: [
      orderRepositoryProvider.overrideWithValue(mockRepo),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  group('OrderHistoryNotifier', () {
    test('loadForShift fetches from repo successfully', () async {
      final order = Order(
        id: 'o1', branchId: 'b', shiftId: 's',
        tellerId: 't', tellerName: 'Teller', status: 'completed', paymentMethod: 'cash', orderNumber: 1,
        amountTendered: 10, subtotal: 10, discountValue: 0, discountAmount: 0, taxAmount: 0, totalAmount: 10, items: [],
        createdAt: DateTime.now(),
      );
      
      when(() => mockRepo.listForShift('s1')).thenAnswer((_) async => [order]);
      
      final notifier = container.read(orderHistoryProvider.notifier);
      await notifier.loadForShift('s1');

      final state = container.read(orderHistoryProvider);
      expect(state.isLoading, false);
      expect(state.fromCache, false);
      expect(state.orders.length, 1);
      expect(state.orders[0].id, 'o1');
      expect(state.shiftId, 's1');
      expect(state.error, null);
    });

    test('loadForShift skips if already loaded and not forced', () async {
      when(() => mockRepo.listForShift('s1')).thenAnswer((_) async => [
        Order(id: 'o1', branchId: 'b', shiftId: 's', tellerId: 't', tellerName: 'Teller', status: 'completed', paymentMethod: 'cash', orderNumber: 1, amountTendered: 10, subtotal: 10, discountValue: 0, discountAmount: 0, taxAmount: 0, totalAmount: 10, items: [], createdAt: DateTime.now())
      ]);
      
      final notifier = container.read(orderHistoryProvider.notifier);
      await notifier.loadForShift('s1');
      
      // Call again
      await notifier.loadForShift('s1');
      verify(() => mockRepo.listForShift('s1')).called(1);

      // Force
      await notifier.loadForShift('s1', force: true);
      verify(() => mockRepo.listForShift('s1')).called(1); // 2 total
    });

    test('loadForShift falls back to cache on error', () async {
      when(() => mockRepo.listForShift('s1')).thenThrow(Exception('Network Error'));
      
      final cachedOrder = Order(id: 'o2', branchId: 'b', shiftId: 's', tellerId: 't', tellerName: 'Teller', status: 'completed', paymentMethod: 'cash', orderNumber: 1, amountTendered: 10, subtotal: 10, discountValue: 0, discountAmount: 0, taxAmount: 0, totalAmount: 10, items: [], createdAt: DateTime.now());
      when(() => mockRepo.loadCachedOrders('s1')).thenReturn([cachedOrder]);

      final notifier = container.read(orderHistoryProvider.notifier);
      await notifier.loadForShift('s1');

      final state = container.read(orderHistoryProvider);
      expect(state.isLoading, false);
      expect(state.fromCache, true);
      expect(state.orders.length, 1);
      expect(state.orders[0].id, 'o2');
      expect(state.error, contains('Showing cached orders'));
    });

    test('addOrder adds and saves to cache', () async {
      when(() => mockRepo.listForShift('s1')).thenAnswer((_) async => []);
      when(() => mockRepo.saveOrdersToCache('s1', any())).thenAnswer((_) async {});
      
      final notifier = container.read(orderHistoryProvider.notifier);
      await notifier.loadForShift('s1');

      final order = Order(id: 'o3', branchId: 'b', shiftId: 's', tellerId: 't', tellerName: 'Teller', status: 'completed', paymentMethod: 'cash', orderNumber: 1, amountTendered: 10, subtotal: 10, discountValue: 0, discountAmount: 0, taxAmount: 0, totalAmount: 10, items: [], createdAt: DateTime.now());
      notifier.addOrder(order);

      final state = container.read(orderHistoryProvider);
      expect(state.orders.length, 1);
      expect(state.orders[0].id, 'o3');
      verify(() => mockRepo.saveOrdersToCache('s1', any())).called(1);
    });

    test('replaceOrder replaces by id and saves', () async {
      final oldOrder = Order(id: 'local_1', branchId: 'b', shiftId: 's', tellerId: 't', tellerName: 'Teller', status: 'completed', paymentMethod: 'cash', orderNumber: 1, amountTendered: 10, subtotal: 10, discountValue: 0, discountAmount: 0, taxAmount: 0, totalAmount: 10, items: [], createdAt: DateTime.now());
      when(() => mockRepo.listForShift('s1')).thenAnswer((_) async => [oldOrder]);
      when(() => mockRepo.saveOrdersToCache('s1', any())).thenAnswer((_) async {});
      
      final notifier = container.read(orderHistoryProvider.notifier);
      await notifier.loadForShift('s1');

      final syncedOrder = Order(id: 'synced_1', branchId: 'b', shiftId: 's', tellerId: 't', tellerName: 'Teller', status: 'completed', paymentMethod: 'cash', orderNumber: 1, amountTendered: 10, subtotal: 10, discountValue: 0, discountAmount: 0, taxAmount: 0, totalAmount: 10, items: [], createdAt: DateTime.now());
      notifier.replaceOrder('local_1', syncedOrder);

      final state = container.read(orderHistoryProvider);
      expect(state.orders.length, 1);
      expect(state.orders[0].id, 'synced_1');
      verify(() => mockRepo.saveOrdersToCache('s1', any())).called(1);
    });

    test('replaceOrder falls back to addOrder if not found', () async {
      when(() => mockRepo.listForShift('s1')).thenAnswer((_) async => []);
      when(() => mockRepo.saveOrdersToCache('s1', any())).thenAnswer((_) async {});
      
      final notifier = container.read(orderHistoryProvider.notifier);
      await notifier.loadForShift('s1');

      final order = Order(id: 'o1', branchId: 'b', shiftId: 's', tellerId: 't', tellerName: 'Teller', status: 'completed', paymentMethod: 'cash', orderNumber: 1, amountTendered: 10, subtotal: 10, discountValue: 0, discountAmount: 0, taxAmount: 0, totalAmount: 10, items: [], createdAt: DateTime.now());
      notifier.replaceOrder('non_existent', order);

      expect(container.read(orderHistoryProvider).orders.length, 1);
      expect(container.read(orderHistoryProvider).orders[0].id, 'o1');
    });

    test('updateOrder updates by id and saves', () async {
      final oldOrder = Order(id: 'o1', branchId: 'b', shiftId: 's', tellerId: 't', tellerName: 'Teller', status: 'draft', paymentMethod: 'cash', orderNumber: 1, amountTendered: 10, subtotal: 10, discountValue: 0, discountAmount: 0, taxAmount: 0, totalAmount: 10, items: [], createdAt: DateTime.now());
      when(() => mockRepo.listForShift('s1')).thenAnswer((_) async => [oldOrder]);
      when(() => mockRepo.saveOrdersToCache('s1', any())).thenAnswer((_) async {});
      
      final notifier = container.read(orderHistoryProvider.notifier);
      await notifier.loadForShift('s1');

      final newOrder = Order(id: 'o1', branchId: 'b', shiftId: 's', tellerId: 't', tellerName: 'Teller', status: 'completed', paymentMethod: 'cash', orderNumber: 1, amountTendered: 10, subtotal: 10, discountValue: 0, discountAmount: 0, taxAmount: 0, totalAmount: 10, items: [], createdAt: DateTime.now());
      notifier.updateOrder(newOrder);

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
