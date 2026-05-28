import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/menu.dart';

void main() {
  group('Category', () {
    test('fromJson & toJson', () {
      final json = {'id': 'c1', 'name': 'Drinks', 'image_url': 'url', 'display_order': 1, 'is_active': true};
      final cat = Category.fromJson(json);
      expect(cat.id, 'c1');
      expect(cat.name, 'Drinks');
      expect(cat.imageUrl, 'url');
      expect(cat.toJson(), json);
    });
  });

  group('ItemSize', () {
    test('fromJson & toJson', () {
      final json = {'id': 's1', 'label': 'Large', 'price_override': 100};
      final size = ItemSize.fromJson(json);
      expect(size.id, 's1');
      expect(size.label, 'Large');
      expect(size.price, 100);
      expect(size.toJson(), json);
    });
  });

  group('MenuItemRecipe', () {
    test('fromJson & toJson', () {
      final json = {
        'org_ingredient_id': 'inv1',
        'quantity_used': 10.5,
        'ingredient_name': 'Beans',
        'ingredient_unit': 'g',
        'category': 'bean',
        'size_label': 'Large'
      };
      final rec = MenuItemRecipe.fromJson(json);
      expect(rec.quantityUsed, 10.5);
      expect(rec.category, 'bean');
      expect(rec.toJson(), json);
    });
  });

  group('AddonItem', () {
    test('fromJson & toJson', () {
      final json = {
        'id': 'a1',
        'name': 'Extra Shot',
        'addon_type': 'coffee',
        'default_price': 50,
        'is_active': true,
        'display_order': 1,
        'primary_ingredient_id': null,
        'ingredients': []
      };
      final addon = AddonItem.fromJson(json);
      expect(addon.id, 'a1');
      expect(addon.defaultPrice, 50);
      expect(addon.toJson(), json);
    });
  });

  group('AddonSlot', () {
    test('displayName returns label if present', () {
      final slot = AddonSlot(id: 's1', menuItemId: 'm1', addonType: 'milk_type', label: 'Choose Milk', isRequired: true, minSelections: 1, displayOrder: 1);
      expect(slot.displayName, 'Choose Milk');
    });

    test('displayName formats addonType if label absent', () {
      final slot = AddonSlot(id: 's1', menuItemId: 'm1', addonType: 'milk_type', isRequired: true, minSelections: 1, displayOrder: 1);
      expect(slot.displayName, 'Milk Type');
    });
  });

  group('OptionalField', () {
    test('getters work', () {
      final opt = OptionalField(id: 'o1', menuItemId: 'm1', name: 'No Sugar', price: 0, displayOrder: 1, isActive: true, ingredientName: 'Sugar');
      expect(opt.hasIngredient, true);
      expect(opt.isFree, true);

      final opt2 = OptionalField(id: 'o2', menuItemId: 'm1', name: 'Syrup', price: 50, displayOrder: 2, isActive: true);
      expect(opt2.hasIngredient, false);
      expect(opt2.isFree, false);
    });
  });

  group('MenuItem', () {
    test('priceForSize returns base price if label null or sizes empty', () {
      final item = MenuItem(id: 'm1', orgId: 'o1', name: 'Item', basePrice: 200, isActive: true, displayOrder: 1);
      expect(item.priceForSize(null), 200);
      expect(item.priceForSize('Large'), 200);
    });

    test('priceForSize returns overridden price if match found', () {
      final item = MenuItem(
        id: 'm1', orgId: 'o1', name: 'Item', basePrice: 200, isActive: true, displayOrder: 1,
        sizes: [ItemSize(id: 's1', label: 'Large', price: 300)]
      );
      expect(item.priceForSize('Large'), 300);
    });

    test('hasLocalRecipes returns true if recipes not empty', () {
      final item = MenuItem(
        id: 'm1', orgId: 'o1', name: 'Item', basePrice: 200, isActive: true, displayOrder: 1,
        recipes: [MenuItemRecipe(quantityUsed: 1, ingredientName: 'A', ingredientUnit: 'B', category: 'C')]
      );
      expect(item.hasLocalRecipes, true);
    });

    test('fromJson & toJson', () {
      final json = {
        'id': 'm1',
        'org_id': 'o1',
        'category_id': 'c1',
        'name': 'Item',
        'description': 'Desc',
        'image_url': 'url',
        'base_price': 200,
        'is_active': true,
        'display_order': 1,
        'sizes': [],
        'addon_slots': [],
        'optional_fields': [],
        'default_milk_addon_id': null,
        'recipes': []
      };
      final item = MenuItem.fromJson(json);
      expect(item.id, 'm1');
      expect(item.name, 'Item');
      expect(item.basePrice, 200);
      expect(item.toJson(), json);
    });
  });
}
