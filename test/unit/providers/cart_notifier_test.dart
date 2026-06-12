import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/models/bundle.dart';
import 'package:sufrix_pos/core/models/cart.dart';
import 'package:sufrix_pos/core/models/shift.dart';
import 'package:sufrix_pos/core/providers/cart_notifier.dart';
import 'package:sufrix_pos/core/providers/shift_notifier.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

import '../../helpers/model_fixtures.dart';

class MockStorageService extends Mock implements StorageService {}
class MockShiftNotifier extends Notifier<ShiftState> implements ShiftNotifier {
  @override
  ShiftState build() => const ShiftState();
  @override Future<bool> closeShift({required String branchId, required int closingCash, String? note, required List<Map<String, dynamic>> inventoryCounts}) async => true;
  @override Future<void> load(String branchId) async {}
  @override Future<void> loadInventory(String branchId) async {}
  @override Future<void> loadSystemCash() async {}
  @override Future<bool> openShift(String branchId, int openingCash) async => true;
  @override void updateShiftSynced(Shift shift) {}
  @override void addLocalCash(int amount) {}
}

void main() {
  late MockStorageService mockStorage;
  late ProviderContainer container;

  setUp(() {
    mockStorage = MockStorageService();
    container = ProviderContainer(overrides: [
      storageServiceProvider.overrideWithValue(mockStorage),
      shiftProvider.overrideWith(() => MockShiftNotifier()),
    ]);

    when(() => mockStorage.loadActiveCart(any())).thenReturn(null);
    when(() => mockStorage.saveActiveCart(any(), any())).thenAnswer((_) async {});
  });

  tearDown(() {
    container.dispose();
  });

  group('CartNotifier', () {
    test('initializes with default empty cart if no storage', () {
      final state = container.read(cartProvider);
      expect(state.isEmpty, true);
      expect(state.displayName, 'Order 1');
      expect(state.id, 'order_1');
    });

    test('add inserts item or increments quantity', () {
      final notifier = container.read(cartProvider.notifier);
      
      const item = CartItem(menuItemId: 'm1', itemName: 'Burger', unitPrice: 100);
      notifier.add(item);
      expect(container.read(cartProvider).items.length, 1);
      expect(container.read(cartProvider).items[0].quantity, 1);

      // Add same item again -> increments qty
      notifier.add(item);
      expect(container.read(cartProvider).items.length, 1);
      expect(container.read(cartProvider).items[0].quantity, 2);

      // Add different item
      const item2 = CartItem(menuItemId: 'm2', itemName: 'Fries', unitPrice: 50);
      notifier.add(item2);
      expect(container.read(cartProvider).items.length, 2);
    });

    test('addBundle inserts bundle cart item', () {
      final notifier = container.read(cartProvider.notifier);
      final bundle = makeBundle(id: 'b1', orgId: 'o1', name: 'Combo', price: 100, status: BundleStatus.active, displayOrder: 1);
      
      notifier.addBundle(bundle, []);
      final state = container.read(cartProvider);
      expect(state.items.length, 1);
      expect(state.items[0].bundleId, 'b1');
      expect(state.items[0].isBundleLine, true);
    });

    test('removeAt and restoreLastRemoved', () {
      final notifier = container.read(cartProvider.notifier);
      notifier.add(const CartItem(menuItemId: 'm1', itemName: 'Burger', unitPrice: 100));
      notifier.add(const CartItem(menuItemId: 'm2', itemName: 'Fries', unitPrice: 50));
      
      expect(container.read(cartProvider).items.length, 2);

      notifier.removeAt(0);
      expect(container.read(cartProvider).items.length, 1);
      expect(container.read(cartProvider).items[0].menuItemId, 'm2');

      notifier.restoreLastRemoved();
      expect(container.read(cartProvider).items.length, 2);
      expect(container.read(cartProvider).items[0].menuItemId, 'm1');
    });

    test('setQty updates qty or removes if 0', () {
      final notifier = container.read(cartProvider.notifier);
      notifier.add(const CartItem(menuItemId: 'm1', itemName: 'Burger', unitPrice: 100));

      notifier.setQty(0, 5);
      expect(container.read(cartProvider).items[0].quantity, 5);

      notifier.setQty(0, 0);
      expect(container.read(cartProvider).items.length, 0);
    });

    test('setPayment updates payment', () {
      final notifier = container.read(cartProvider.notifier);
      notifier.setPayment('card');
      expect(container.read(cartProvider).payment, 'card');
    });

    test('applyCheckoutFields updates cart state', () {
      final notifier = container.read(cartProvider.notifier);
      notifier.applyCheckoutFields(
        payment: 'card', customerName: 'John', amountTendered: 1500, discountType: DiscountType.percentage, discountValue: 10
      );
      
      final state = container.read(cartProvider);
      expect(state.payment, 'card');
      expect(state.customerName, 'John');
      expect(state.amountTendered, 1500);
      expect(state.discountType, DiscountType.percentage);
      expect(state.discountValue, 10);
    });

    test('clear empties cart but keeps id and display name', () {
      final notifier = container.read(cartProvider.notifier);
      notifier.add(const CartItem(menuItemId: 'm1', itemName: 'Burger', unitPrice: 100));
      notifier.clear();
      
      final state = container.read(cartProvider);
      expect(state.items.length, 0);
      expect(state.id, 'order_1');
    });

    test('startNewOrder creates new cart', () {
      final notifier = container.read(cartProvider.notifier);
      notifier.startNewOrder(id: 'new_1', displayName: 'New Order');
      
      final state = container.read(cartProvider);
      expect(state.items.length, 0);
      expect(state.id, 'new_1');
      expect(state.displayName, 'New Order');
    });
  });
}
