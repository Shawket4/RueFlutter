import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/cart.dart';

void main() {
  group('SelectedOptional', () {
    test('toApiJson & toStorageJson & fromStorageJson', () {
      const opt = SelectedOptional(optionalFieldId: 'o1', name: 'Extra Sugar', price: 50);
      expect(opt.toApiJson(), {'optional_field_id': 'o1'});
      
      final storage = opt.toStorageJson();
      expect(storage['optional_field_id'], 'o1');
      expect(storage['name'], 'Extra Sugar');
      expect(storage['price'], 50);

      final restored = SelectedOptional.fromStorageJson(storage);
      expect(restored.optionalFieldId, 'o1');
      expect(restored.name, 'Extra Sugar');
      expect(restored.price, 50);
    });
  });

  group('SelectedAddon', () {
    test('copyWith & toApiJson & toStorageJson & fromStorageJson', () {
      const addon = SelectedAddon(addonItemId: 'a1', name: 'Milk', priceModifier: 100, quantity: 2);
      
      final modified = addon.copyWith(quantity: 3);
      expect(modified.quantity, 3);
      expect(modified.name, 'Milk');

      expect(addon.toApiJson(), {'addon_item_id': 'a1', 'quantity': 2});
      
      final storage = addon.toStorageJson();
      expect(storage['addon_item_id'], 'a1');
      expect(storage['name'], 'Milk');
      expect(storage['price_modifier'], 100);

      final restored = SelectedAddon.fromStorageJson(storage);
      expect(restored.addonItemId, 'a1');
      expect(restored.quantity, 2);
    });
  });

  group('BundleComponentSnapshot', () {
    test('price calculations & serialization', () {
      const snap = BundleComponentSnapshot(
        itemId: 'm1',
        itemName: 'Coffee',
        quantity: 1,
        addons: [SelectedAddon(addonItemId: 'a1', name: 'A', priceModifier: 10, quantity: 2)],
        optionals: [SelectedOptional(optionalFieldId: 'o1', name: 'O', price: 5)],
      );

      expect(snap.addonsPrice, 20); // 10 * 2
      expect(snap.optionalsPrice, 5);

      final apiJson = snap.toApiJson();
      expect(apiJson['item_id'], 'm1');
      expect(apiJson['quantity'], 1);

      final storageJson = snap.toStorageJson();
      final restored = BundleComponentSnapshot.fromStorageJson(storageJson);
      expect(restored.itemId, 'm1');
      expect(restored.addons.length, 1);
      expect(restored.optionals.length, 1);
    });
  });

  group('CartItem', () {
    test('lineTotal for regular item', () {
      const item = CartItem(
        menuItemId: 'm1',
        itemName: 'Burger',
        unitPrice: 500,
        quantity: 2,
        addons: [SelectedAddon(addonItemId: 'a1', name: 'Cheese', priceModifier: 50)],
        optionals: [SelectedOptional(optionalFieldId: 'o1', name: 'No Pickles', price: 0)],
      );
      // unitPrice (500) + addons (50) + opt (0) = 550 * 2 = 1100
      expect(item.lineTotal, 1100);
      expect(item.addonsPrice, 50);
      expect(item.optionalsPrice, 0);
      expect(item.isBundleLine, false);
    });

    test('lineTotal for bundle item', () {
      final bundleComps = [
        const BundleComponentSnapshot(
          itemId: 'm1', itemName: 'Burger', quantity: 1,
          addons: [SelectedAddon(addonItemId: 'a1', name: 'Cheese', priceModifier: 50)]
        )
      ];
      final item = CartItem(
        bundleId: 'b1',
        bundleComponents: bundleComps,
        itemName: 'Combo',
        unitPrice: 1000,
        quantity: 2,
      );
      // base price 1000 + component extras 50 = 1050 * 2 = 2100
      expect(item.lineTotal, 2100);
      expect(item.isBundleLine, true);
    });

    test('serialization regular item', () {
      const item = CartItem(
        menuItemId: 'm1',
        itemName: 'Burger',
        unitPrice: 500,
        quantity: 1,
      );
      final storage = item.toStorageJson();
      final restored = CartItem.fromStorageJson(storage);
      expect(restored.menuItemId, 'm1');
      expect(restored.itemName, 'Burger');
      expect(restored.unitPrice, 500);
    });

    test('serialization bundle item', () {
      const item = CartItem(
        bundleId: 'b1',
        bundleComponents: [BundleComponentSnapshot(itemId: 'm1', itemName: 'B', quantity: 1)],
        itemName: 'Combo',
        unitPrice: 1000,
        quantity: 1,
      );
      final storage = item.toStorageJson();
      final restored = CartItem.fromStorageJson(storage);
      expect(restored.bundleId, 'b1');
      expect(restored.bundleComponents?.length, 1);
    });

    test('addonsMatch & optionalsMatch', () {
      final a1 = [const SelectedAddon(addonItemId: '1', name: '1', priceModifier: 1)];
      final a2 = [const SelectedAddon(addonItemId: '1', name: '1', priceModifier: 1)];
      final a3 = [const SelectedAddon(addonItemId: '2', name: '2', priceModifier: 1)];

      expect(CartItem.addonsMatch(a1, a2), true);
      expect(CartItem.addonsMatch(a1, a3), false);

      final o1 = [const SelectedOptional(optionalFieldId: '1', name: '1', price: 1)];
      final o2 = [const SelectedOptional(optionalFieldId: '1', name: '1', price: 1)];
      
      expect(CartItem.optionalsMatch(o1, o2), true);
    });
  });

  group('CartState', () {
    test('calculations', () {
      const state = CartState(
        items: [
          CartItem(menuItemId: 'm1', itemName: 'Burger', unitPrice: 500, quantity: 2), // 1000
          CartItem(menuItemId: 'm2', itemName: 'Fries', unitPrice: 200, quantity: 1), // 200
        ],
        discountType: DiscountType.percentage,
        discountValue: 10,
        amountTendered: 1500,
      );

      expect(state.count, 3);
      expect(state.subtotal, 1200);
      expect(state.discountAmount, 120); // 10% of 1200
      expect(state.total, 1080);
      expect(state.changeGiven, 420); // 1500 - 1080
    });

    test('fixed discount', () {
      const state = CartState(
        items: [CartItem(menuItemId: 'm1', itemName: 'Burger', unitPrice: 500, quantity: 1)],
        discountType: DiscountType.fixed,
        discountValue: 100,
      );
      expect(state.discountAmount, 100);
      expect(state.total, 400);
    });

    test('discount clamped to subtotal', () {
      const state = CartState(
        items: [CartItem(menuItemId: 'm1', itemName: 'Burger', unitPrice: 500, quantity: 1)],
        discountType: DiscountType.fixed,
        discountValue: 1000,
      );
      expect(state.discountAmount, 500);
      expect(state.total, 0);
    });

    test('tax: rate applied to subtotal with no discount', () {
      const state = CartState(
        items: [
          CartItem(menuItemId: 'm1', itemName: 'Burger', unitPrice: 1000, quantity: 1),
        ],
        taxRate: 0.14,
        amountTendered: 1200,
      );
      expect(state.subtotal, 1000);
      expect(state.taxableAmount, 1000);
      expect(state.taxAmount, 140); // round(1000 * 0.14)
      expect(state.total, 1140);
      expect(state.changeGiven, 60); // 1200 - 1140
    });

    test('tax: applied to discounted (taxable) amount', () {
      const state = CartState(
        items: [
          CartItem(menuItemId: 'm1', itemName: 'Burger', unitPrice: 1000, quantity: 1),
        ],
        discountType: DiscountType.fixed,
        discountValue: 100,
        taxRate: 0.14,
      );
      expect(state.subtotal, 1000);
      expect(state.discountAmount, 100);
      expect(state.taxableAmount, 900);
      expect(state.taxAmount, 126); // round(900 * 0.14)
      expect(state.total, 1026);
    });

    test('tax: rounds to the nearest piastre (matches backend round())', () {
      const state = CartState(
        items: [
          CartItem(menuItemId: 'm1', itemName: 'Burger', unitPrice: 995, quantity: 1),
        ],
        taxRate: 0.14,
      );
      expect(state.taxableAmount, 995);
      expect(state.taxAmount, 139); // round(139.3) == 139
      expect(state.total, 1134);
    });

    test('tax: zero rate keeps total = subtotal - discount (backward compat)', () {
      const state = CartState(
        items: [
          CartItem(menuItemId: 'm1', itemName: 'Burger', unitPrice: 1000, quantity: 1),
        ],
        discountType: DiscountType.fixed,
        discountValue: 100,
        // taxRate defaults to 0.0
      );
      expect(state.taxAmount, 0);
      expect(state.total, state.subtotal - state.discountAmount); // 900
    });

    test('tax: copyWith carries the tax rate', () {
      const state = CartState(taxRate: 0.14);
      final copied = state.copyWith(payment: 'card');
      expect(copied.taxRate, 0.14);
      final reapplied = state.copyWith(taxRate: 0.10);
      expect(reapplied.taxRate, 0.10);
    });

    test('tax: not persisted in storage (re-injected on load)', () {
      const state = CartState(
        id: 'c1',
        items: [CartItem(menuItemId: 'm1', itemName: 'Burger', unitPrice: 500)],
        taxRate: 0.14,
      );
      final restored = CartState.fromStorageJson(state.toStorageJson());
      // Storage never carries the session tax rate — defaults back to 0.0.
      expect(restored.taxRate, 0.0);
    });

    test('copyWith clears fields', () {
      const state = CartState(
        customerName: 'John',
        discountType: DiscountType.fixed,
        amountTendered: 100,
      );

      final cleared = state.copyWith(
        clearCustomer: true,
        clearDiscount: true,
        clearTendered: true,
      );

      expect(cleared.customerName, null);
      expect(cleared.discountType, null);
      expect(cleared.amountTendered, null);
    });

    test('toStorageJson & fromStorageJson', () {
      const state = CartState(
        id: 'c1',
        customerName: 'John',
        items: [CartItem(menuItemId: 'm1', itemName: 'Burger', unitPrice: 500)],
        paymentSplits: [PaymentSplit(method: 'cash', amount: 500)],
      );

      final storage = state.toStorageJson();
      final restored = CartState.fromStorageJson(storage);

      expect(restored.id, 'c1');
      expect(restored.customerName, 'John');
      expect(restored.items.length, 1);
      expect(restored.paymentSplits?.length, 1);
      expect(restored.paymentSplits?[0].method, 'cash');
    });
  });
}
