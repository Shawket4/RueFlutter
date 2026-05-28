import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/bundle.dart';
import 'package:sufrix_pos/core/models/inventory.dart';
import 'package:sufrix_pos/core/models/menu.dart';

void main() {
  group('BundleStatus', () {
    test('fromApi parses correctly', () {
      expect(BundleStatus.fromApi('active'), BundleStatus.active);
      expect(BundleStatus.fromApi('archived'), BundleStatus.archived);
      expect(BundleStatus.fromApi('draft'), BundleStatus.draft);
      expect(BundleStatus.fromApi('unknown'), BundleStatus.archived);
      expect(BundleStatus.fromApi(null), BundleStatus.archived);
    });

    test('apiValue matches', () {
      expect(BundleStatus.active.apiValue, 'active');
      expect(BundleStatus.draft.apiValue, 'draft');
    });
  });

  group('BundleComponent', () {
    test('fromJson & toJson', () {
      final json = {
        'bundle_id': 'b1',
        'item_id': 'm1',
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

    test('fromJson inherits bundleId if provided', () {
      final json = {'item_id': 'm1'};
      final comp = BundleComponent.fromJson(json, bundleId: 'b2');
      expect(comp.bundleId, 'b2');
      expect(comp.quantity, 1);
      expect(comp.position, 0);
    });
  });

  group('Bundle', () {
    final mockMenuItem1 = MenuItem(
      id: 'm1',
      orgId: 'org1',
      name: 'Coffee',
      categoryId: 'c1',
      basePrice: 200,
      isActive: true,
      displayOrder: 1,
      imageUrl: 'http://coffee.png',
      recipes: [
        MenuItemRecipe(quantityUsed: 10, ingredientName: 'Beans', ingredientUnit: 'g', category: 'bean', orgIngredientId: 'inv1')
      ],
    );

    final mockMenuItem2 = MenuItem(
      id: 'm2',
      orgId: 'org1',
      name: 'Cake',
      categoryId: 'c2',
      basePrice: 300,
      isActive: true,
      displayOrder: 2,
    );

    final mockBundle = Bundle(
      id: 'b1',
      orgId: 'org1',
      name: 'Combo',
      price: 400,
      status: BundleStatus.active,
      displayOrder: 1,
      components: [
        BundleComponent(bundleId: 'b1', itemId: 'm1', quantity: 1, position: 2),
        BundleComponent(bundleId: 'b1', itemId: 'm2', quantity: 1, position: 1),
      ],
      branchAvailability: ['br1'],
      availableFromMinutes: 480, // 8:00 AM
      availableUntilMinutes: 720, // 12:00 PM
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
      expect(mockBundle.previewImageUrl([mockMenuItem1, mockMenuItem2]), 'http://coffee.png');
      
      final bWithImage = Bundle(
        id: 'b2', orgId: 'org1', name: 'B', price: 10, status: BundleStatus.active, displayOrder: 1, imageUrl: 'http://bundle.png'
      );
      expect(bWithImage.previewImageUrl([mockMenuItem1, mockMenuItem2]), 'http://bundle.png');
    });

    test('fromJson & toJson', () {
      final json = {
        'id': 'b1',
        'org_id': 'org1',
        'name': 'Combo',
        'description': null,
        'price': 400,
        'status': 'active',
        'image_url': null,
        'display_order': 1,
        'available_from_date': '2023-01-01',
        'available_until_date': '2023-12-31',
        'available_from_time': 480,
        'available_until_time': 720,
        'branch_ids': ['br1'],
        'components': [
          {'bundle_id': 'b1', 'item_id': 'm1', 'quantity': 1, 'position': 2},
          {'bundle_id': 'b1', 'item_id': 'm2', 'quantity': 1, 'position': 1}
        ],
        'updated_at': '2023-01-01T12:00:00.000Z'
      };

      final b = Bundle.fromJson(json);
      expect(b.id, 'b1');
      expect(b.branchAvailability, ['br1']);
      expect(b.components.length, 2);
      expect(b.availableFromMinutes, 480);
      expect(b.availableFromDate?.year, 2023);

      final out = b.toJson();
      expect(out['id'], 'b1');
      expect(out['available_from_date'], '2023-01-01');
    });

    test('isBundleAvailableNow logic', () {
      final nowInTime = DateTime(2023, 6, 1, 10, 0); // 10:00 AM (600 mins)
      final nowTooEarly = DateTime(2023, 6, 1, 7, 0); // 7:00 AM (420 mins)
      final nowTooLate = DateTime(2023, 6, 1, 13, 0); // 1:00 PM (780 mins)
      
      expect(isBundleAvailableNow(mockBundle, 'br1', nowInTime), true);
      expect(isBundleAvailableNow(mockBundle, 'br2', nowInTime), false); // wrong branch
      expect(isBundleAvailableNow(mockBundle, 'br1', nowTooEarly), false);
      expect(isBundleAvailableNow(mockBundle, 'br1', nowTooLate), false);
      
      final draftBundle = Bundle(id: 'd1', orgId: 'o', name: 'D', price: 1, status: BundleStatus.draft, displayOrder: 1);
      expect(isBundleAvailableNow(draftBundle, 'br1', nowInTime), false);
    });

    test('bundleOutOfStockReason logic', () {
      final invFull = [InventoryItem(id: 'inv1', name: 'Beans', unit: 'g', currentStock: 50.0)];
      final invEmpty = [InventoryItem(id: 'inv1', name: 'Beans', unit: 'g', currentStock: 5.0)]; // needs 10

      expect(bundleOutOfStockReason(mockBundle, [mockMenuItem1, mockMenuItem2], invFull), null);
      expect(bundleOutOfStockReason(mockBundle, [mockMenuItem1, mockMenuItem2], invEmpty), 'Coffee');
    });
  });

  group('MenuGridEntry', () {
    test('item and bundle factories', () {
      final item = MenuItem(id: '1', orgId: '1', name: '1', basePrice: 1, isActive: true, displayOrder: 1);
      final eItem = MenuGridEntry.item(item);
      expect(eItem.kind, MenuGridEntryKind.item);
      expect(eItem.item, item);
      expect(eItem.bundle, null);

      final bundle = Bundle(id: '2', orgId: '1', name: '2', price: 2, status: BundleStatus.active, displayOrder: 2);
      final eBundle = MenuGridEntry.bundle(bundle, enabled: false, disabledReason: 'Out');
      expect(eBundle.kind, MenuGridEntryKind.bundle);
      expect(eBundle.bundle, bundle);
      expect(eBundle.enabled, false);
      expect(eBundle.disabledReason, 'Out');
    });
  });
}
