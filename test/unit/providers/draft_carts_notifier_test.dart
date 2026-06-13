import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/models/cart.dart';
import 'package:sufrix_pos/core/providers/cart_notifier.dart';
import 'package:sufrix_pos/core/providers/draft_carts_notifier.dart';
import 'package:sufrix_pos/core/providers/shift_notifier.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

class MockStorageService extends Mock implements StorageService {}
class MockCartNotifier extends Notifier<CartState> implements CartNotifier {
  @override CartState build() => const CartState(id: 'c1');
  @override void replaceWith(CartState newState) => state = newState;
  @override void startNewOrder({String? id, String? displayName}) {}
  @override void add(CartItem incoming) {}
  @override void addBundle(dynamic bundle, dynamic components) {}
  @override void applyCheckoutFields({int? amountTendered, String? customerName, String? discountId, dynamic discountType, int? discountValue, required String payment, List<dynamic>? paymentSplits, int? tipAmount}) {}
  @override void clear() {}
  @override void clearDiscount() {}
  @override void clearSplits() {}
  @override String idempotencyKey() => '';
  @override void removeAt(int index) {}
  @override void renameDisplayName(String name) {}
  @override void replaceAt(int index, CartItem incoming) {}
  @override void restoreLastRemoved() {}
  @override void setAmountTendered(int? amount) {}
  @override void setCustomer(String? n) {}
  @override void setDiscount(dynamic type, int? value) {}
  @override void setDiscountById(String id, dynamic type, int value) {}
  @override void setNotes(String? n) {}
  @override void setPayment(String m) {}
  @override void setPaymentSplits(List<dynamic> splits) {}
  @override void setQty(int index, int qty) {}
  @override void setTip(int? tip) {}
}

class MockShiftNotifier extends Notifier<ShiftState> implements ShiftNotifier {
  @override ShiftState build() => const ShiftState();
  @override Future<bool> closeShift({required String branchId, required int closingCash, List<Map<String, dynamic>> inventoryCounts = const [], String? note}) async => true;
  @override Future<void> load(String branchId) async {}
  @override Future<void> loadSystemCash() async {}
  @override Future<bool> openShift(String branchId, int openingCash) async => true;
  @override void updateShiftSynced(dynamic shift) {}
  @override void addLocalCash(int amount) {}
  @override void seedFromAuth(dynamic shift) {}
  @override void loadLocal(String branchId) {}
}

void main() {
  late MockStorageService mockStorage;
  late ProviderContainer container;

  setUp(() {
    mockStorage = MockStorageService();
    when(() => mockStorage.loadDraftCartsWithLegacyMigration(any())).thenReturn([]);
    when(() => mockStorage.saveDraftCarts(any(), any())).thenAnswer((_) async {});

    container = ProviderContainer(overrides: [
      storageServiceProvider.overrideWithValue(mockStorage),
      cartProvider.overrideWith(() => MockCartNotifier()),
      shiftProvider.overrideWith(() => MockShiftNotifier()),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  group('CartDraft', () {
    test('fromJson & toJson', () {
      final json = {
        'id': 'd1',
        'name': 'Order 1',
        'cart_state': {'id': 'c1', 'items': [], 'created_at': '2023-01-01T12:00:00.000Z'},
        'created_at': '2023-01-01T12:00:00.000Z'
      };
      
      final draft = CartDraft.fromJson(json);
      expect(draft.id, 'd1');
      expect(draft.name, 'Order 1');
      expect(draft.cartState.id, 'c1');
      
      final out = draft.toJson();
      expect(out['id'], 'd1');
      expect(out['name'], 'Order 1');
      expect(out['cart_state']['id'], 'c1');
    });
  });

  group('DraftCartsNotifier', () {
    test('initializes empty if no storage', () {
      final state = container.read(draftCartsProvider);
      expect(state, isEmpty);
    });

    test('parkCurrentCart adds to drafts and starts new order', () async {
      final notifier = container.read(draftCartsProvider.notifier);
      const current = CartState(
        id: 'c1',
        displayName: 'Order 1',
        items: [CartItem(menuItemId: 'm1', itemName: 'Burger', unitPrice: 100)]
      );

      final success = await notifier.parkCurrentCart(current);
      expect(success, true);
      
      final state = container.read(draftCartsProvider);
      expect(state.length, 1);
      expect(state.first.name, 'Order 1');
      expect(state.first.cartState.id, 'c1');
    });

    test('parkCurrentCart ignores empty cart', () async {
      final notifier = container.read(draftCartsProvider.notifier);
      final success = await notifier.parkCurrentCart(const CartState());
      
      expect(success, false);
      expect(container.read(draftCartsProvider), isEmpty);
    });

    test('renameDraft updates name', () async {
      final notifier = container.read(draftCartsProvider.notifier);
      const current = CartState(id: 'c1', items: [CartItem(menuItemId: 'm1', itemName: 'Burger', unitPrice: 100)]);
      await notifier.parkCurrentCart(current);

      final draftId = container.read(draftCartsProvider).first.id;
      notifier.renameDraft(draftId, 'My Order');

      final state = container.read(draftCartsProvider);
      expect(state.first.name, 'My Order');
      expect(state.first.cartState.displayName, 'My Order');
    });

    test('deleteDraft removes from list', () async {
      final notifier = container.read(draftCartsProvider.notifier);
      const current = CartState(id: 'c1', items: [CartItem(menuItemId: 'm1', itemName: 'Burger', unitPrice: 100)]);
      await notifier.parkCurrentCart(current);

      final draftId = container.read(draftCartsProvider).first.id;
      await notifier.deleteDraft(draftId);

      expect(container.read(draftCartsProvider), isEmpty);
    });
  });
}
