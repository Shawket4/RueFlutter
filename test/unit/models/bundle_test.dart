import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/bundle.dart';

import '../../helpers/model_fixtures.dart';

void main() {
  group('BundleStatus', () {
    test('unknown wire value falls back instead of crashing', () {
      final b = Bundle.fromJson({
        ..._wireBundle,
        'status': 'brand_new_status',
      });
      expect(b.status, BundleStatus.unknownDefaultOpenApi);
    });
  });

  group('BundleComponent', () {
    test('fromJson & toJson', () {
      final json = {
        'id': 'bc1',
        'bundle_id': 'b1',
        'item_id': 'm1',
        'item_name': 'Coffee',
        'item_price': 200,
        'item_cost': 100,
        'quantity': 2,
        'position': 1,
      };
      final comp = BundleComponent.fromJson(json);
      expect(comp.bundleId, 'b1');
      expect(comp.itemId, 'm1');
      expect(comp.quantity, 2);
      expect(comp.position, 1);

      expect(comp.toJson(), json);
    });
  });

  group('Bundle', () {
    final mockMenuItem1 = makeMenuItem(
      id: 'm1',
      name: 'Coffee',
      categoryId: 'c1',
      basePrice: 200,
      displayOrder: 1,
      imageUrl: 'http://coffee.png',
      recipes: [
        makeMenuItemRecipe(
          quantityUsed: 10,
          ingredientName: 'Beans',
          ingredientUnit: 'g',
          category: 'bean',
          orgIngredientId: 'inv1',
        )
      ],
    );

    final mockMenuItem2 = makeMenuItem(
      id: 'm2',
      name: 'Cake',
      categoryId: 'c2',
      basePrice: 300,
      displayOrder: 2,
    );

    final mockBundle = makeBundle(
      id: 'b1',
      name: 'Combo',
      price: 400,
      status: BundleStatus.active,
      displayOrder: 1,
      components: [
        makeBundleComponent(bundleId: 'b1', itemId: 'm1', quantity: 1, position: 2),
        makeBundleComponent(bundleId: 'b1', itemId: 'm2', quantity: 1, position: 1),
      ],
      branchIds: ['br1'],
      availableFromTime: '08:00', // 8:00 AM → 480 mins
      availableUntilTime: '12:00', // 12:00 PM → 720 mins
    );

    test('effectiveCategoryId returns category of first component', () {
      // position 1 is m2, category c2
      expect(mockBundle.effectiveCategoryId([mockMenuItem1, mockMenuItem2]), 'c2');
    });

    test('componentListPrice calculates total base price', () {
      expect(mockBundle.componentListPrice([mockMenuItem1, mockMenuItem2]), 500); // 200 + 300
    });

    test('savingsVsComponents calculates difference', () {
      expect(mockBundle.savingsVsComponents([mockMenuItem1, mockMenuItem2]), 100); // 500 - 400
    });

    test('previewImageUrl uses bundle image or first item image', () {
      // m2 (pos 1) has no image, m1 (pos 2) has image
      expect(mockBundle.previewImageUrl([mockMenuItem1, mockMenuItem2]),
          'http://coffee.png');

      final bWithImage = makeBundle(id: 'b2', imageUrl: 'http://bundle.png');
      expect(bWithImage.previewImageUrl([mockMenuItem1, mockMenuItem2]),
          'http://bundle.png');
    });

    test('fromJson & toJson', () {
      final b = Bundle.fromJson(_wireBundle);
      expect(b.id, 'b1');
      expect(b.branchAvailability, ['br1']);
      expect(b.components.length, 2);
      expect(b.availableFromMinutes, 480);
      expect(b.availableUntilMinutes, 720);
      expect(b.availableFromDate?.year, 2023);
      expect(b.status, BundleStatus.active);

      final out = b.toJson();
      expect(out['id'], 'b1');
      expect(out['org_id'], 'org1');
      expect(out['price'], 400);
      expect(out['status'], 'active');
      expect(out['branch_ids'], ['br1']);
      expect(out['components'].length, 2);
    });

    test('isBundleAvailableNow logic', () {
      final nowInTime = DateTime(2023, 6, 1, 10, 0); // 10:00 AM (600 mins)
      final nowTooEarly = DateTime(2023, 6, 1, 7, 0); // 7:00 AM (420 mins)
      final nowTooLate = DateTime(2023, 6, 1, 13, 0); // 1:00 PM (780 mins)

      expect(isBundleAvailableNow(mockBundle, 'br1', nowInTime), true);
      expect(isBundleAvailableNow(mockBundle, 'br2', nowInTime), false); // wrong branch
      expect(isBundleAvailableNow(mockBundle, 'br1', nowTooEarly), false);
      expect(isBundleAvailableNow(mockBundle, 'br1', nowTooLate), false);

      final draftBundle = makeBundle(id: 'd1', status: BundleStatus.draft);
      expect(isBundleAvailableNow(draftBundle, 'br1', nowInTime), false);

      final unknownStatus =
          makeBundle(id: 'u1', status: BundleStatus.unknownDefaultOpenApi);
      expect(isBundleAvailableNow(unknownStatus, 'br1', nowInTime), false);
    });

    test('bundleOutOfStockReason logic', () {
      // Recipes reference org_ingredient_id (NOT the inventory row id) —
      // give the row a different id to prove the lookup keys correctly.
      final invFull = [
        makeInventoryItem(
            id: 'row-9',
            orgIngredientId: 'inv1',
            ingredientName: 'Beans',
            unit: 'g',
            currentStock: 50.0)
      ];
      final invEmpty = [
        makeInventoryItem(
            id: 'row-9',
            orgIngredientId: 'inv1',
            ingredientName: 'Beans',
            unit: 'g',
            currentStock: 5.0)
      ]; // needs 10

      expect(bundleOutOfStockReason(mockBundle, [mockMenuItem1, mockMenuItem2], invFull), null);
      expect(bundleOutOfStockReason(mockBundle, [mockMenuItem1, mockMenuItem2], invEmpty), 'Coffee');
    });
  });

  group('MenuGridEntry', () {
    test('item and bundle factories', () {
      final item = makeMenuItem(id: '1', displayOrder: 1);
      final eItem = MenuGridEntry.item(item);
      expect(eItem.kind, MenuGridEntryKind.item);
      expect(eItem.item, item);
      expect(eItem.bundle, null);

      final bundle = makeBundle(id: '2', displayOrder: 2);
      final eBundle = MenuGridEntry.bundle(bundle, enabled: false, disabledReason: 'Out');
      expect(eBundle.kind, MenuGridEntryKind.bundle);
      expect(eBundle.bundle, bundle);
      expect(eBundle.enabled, false);
      expect(eBundle.disabledReason, 'Out');
    });
  });
}

final Map<String, dynamic> _wireBundle = {
  'id': 'b1',
  'org_id': 'org1',
  'name': 'Combo',
  'name_translations': {'en': 'Combo'},
  'description_translations': null,
  'price': 400,
  'status': 'active',
  'display_order': 1,
  'available_from_date': '2023-01-01',
  'available_until_date': '2023-12-31',
  'available_from_time': '08:00:00',
  'available_until_time': '12:00:00',
  'branch_ids': ['br1'],
  'components': [
    {
      'id': 'bc1',
      'bundle_id': 'b1',
      'item_id': 'm1',
      'item_name': 'Coffee',
      'item_price': 200,
      'item_cost': 100,
      'quantity': 1,
      'position': 2,
    },
    {
      'id': 'bc2',
      'bundle_id': 'b1',
      'item_id': 'm2',
      'item_name': 'Cake',
      'item_price': 300,
      'item_cost': 150,
      'quantity': 1,
      'position': 1,
    },
  ],
  'computed_cost': 250,
  'created_at': '2023-01-01T12:00:00.000Z',
  'updated_at': '2023-01-01T12:00:00.000Z',
};
