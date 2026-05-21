import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/bundle.dart';
import 'package:sufrix_pos/core/models/cart.dart';

void main() {
  group('CartItem bundle serialization', () {
    test('toApiJson sends bundle fields and null menu_item_id', () {
      const item = CartItem(
        bundleId: 'bundle-1',
        bundleComponents: [
          BundleComponentSnapshot(
            itemId: 'item-a',
            itemName: 'Latte',
            quantity: 1,
            sizeLabel: 'medium',
            addons: [
              SelectedAddon(
                addonItemId: 'oat',
                name: 'Oat milk',
                priceModifier: 500,
              ),
            ],
          ),
          BundleComponentSnapshot(
            itemId: 'item-b',
            itemName: 'Croissant',
            quantity: 1,
          ),
        ],
        itemName: 'Breakfast Combo',
        unitPrice: 4500,
        quantity: 2,
      );

      final json = item.toApiJson();
      expect(json['menu_item_id'], isNull);
      expect(json['bundle_id'], 'bundle-1');
      expect(json['bundle_unit_price'], 4500);
      expect(json['quantity'], 2);
      final comps = json['bundle_components'] as List;
      expect(comps[0]['size_label'], 'medium');
      expect(comps[0]['addons'], [
        {'addon_item_id': 'oat', 'quantity': 1},
      ]);
    });

    test('lineTotal includes component addon surcharges', () {
      const item = CartItem(
        bundleId: 'bundle-1',
        bundleComponents: [
          BundleComponentSnapshot(
            itemId: 'item-a',
            itemName: 'Latte',
            quantity: 1,
            addons: [
              SelectedAddon(
                addonItemId: 'oat',
                name: 'Oat',
                priceModifier: 500,
              ),
            ],
          ),
        ],
        itemName: 'Breakfast Combo',
        unitPrice: 4500,
        quantity: 1,
      );
      expect(item.lineTotal, 5000);
    });

    test('round-trip through storage JSON', () {
      const original = CartItem(
        bundleId: 'bundle-1',
        bundleComponents: [
          BundleComponentSnapshot(
            itemId: 'item-a',
            itemName: 'Latte',
            quantity: 1,
          ),
        ],
        itemName: 'Breakfast Combo',
        unitPrice: 4500,
      );

      final restored = CartItem.fromStorageJson(original.toStorageJson());
      expect(restored.bundleId, original.bundleId);
      expect(restored.menuItemId, isNull);
      expect(restored.itemName, original.itemName);
      expect(restored.bundleComponents!.length, 1);
      expect(restored.bundleComponents!.first.itemName, 'Latte');
      expect(restored.lineTotal, 4500);
    });
  });
}
