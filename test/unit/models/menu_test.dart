import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/menu.dart';

import '../../helpers/model_fixtures.dart';

void main() {
  group('Category', () {
    test('fromJson & toJson', () {
      final json = {
        'id': 'c1',
        'org_id': 'o1',
        'name': 'Drinks',
        'name_translations': {'en': 'Drinks'},
        'image_url': 'url',
        'is_active': true,
        'created_at': '2026-01-01T00:00:00.000Z',
        'updated_at': '2026-01-01T00:00:00.000Z',
      };
      final cat = Category.fromJson(json);
      expect(cat.id, 'c1');
      expect(cat.name, 'Drinks');
      expect(cat.imageUrl, 'url');

      final out = cat.toJson();
      expect(out['id'], 'c1');
      expect(out['name'], 'Drinks');
      expect(out['image_url'], 'url');
      // display_order was removed from the contract; the menu renders in
      // server order, so the key must not be emitted.
      expect(out.containsKey('display_order'), false);
      expect(out['is_active'], true);
    });
  });

  group('ItemSize', () {
    test('fromJson & toJson', () {
      final json = {
        'id': 's1',
        'menu_item_id': 'm1',
        'label': 'Large',
        'price_override': 100,
        'is_active': true,
      };
      final size = ItemSize.fromJson(json);
      expect(size.id, 's1');
      expect(size.label, 'Large');
      expect(size.price, 100);
      expect(size.priceOverride, 100);
      // display_order was removed from the contract; round-trip omits it.
      expect(size.toJson(), json);
      expect(size.toJson().containsKey('display_order'), false);
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

    test('fromJson handles quantity_used as string (backend BigDecimal)', () {
      final rec = MenuItemRecipe.fromJson({
        'quantity_used': '10.5',
        'ingredient_name': 'Beans',
        'ingredient_unit': 'g',
        'category': 'bean',
        'size_label': '',
      });
      expect(rec.quantityUsed, 10.5);
    });
  });

  group('AddonItem', () {
    test('fromJson & toJson', () {
      final json = {
        'id': 'a1',
        'org_id': 'o1',
        'name': 'Extra Shot',
        'name_translations': {'en': 'Extra Shot'},
        'addon_type': 'coffee',
        'default_price': 50,
        'is_active': true,
        'ingredients': <Map<String, dynamic>>[],
        'created_at': '2026-01-01T00:00:00.000Z',
        'updated_at': '2026-01-01T00:00:00.000Z',
      };
      final addon = AddonItem.fromJson(json);
      expect(addon.id, 'a1');
      expect(addon.defaultPrice, 50);
      expect(addon.ingredients, isEmpty);

      final out = addon.toJson();
      expect(out['id'], 'a1');
      expect(out['addon_type'], 'coffee');
      expect(out['default_price'], 50);
      expect(out['is_active'], true);
      // display_order was removed from the contract.
      expect(out.containsKey('display_order'), false);
    });
  });

  group('AddonSlot', () {
    test('displayName returns label if present', () {
      final slot = makeAddonSlot(addonType: 'milk_type', label: 'Choose Milk');
      expect(slot.displayName, 'Choose Milk');
    });

    test('displayName formats addonType if label absent', () {
      final slot = makeAddonSlot(addonType: 'milk_type');
      expect(slot.displayName, 'Milk Type');
    });
  });

  group('OptionalField', () {
    test('getters work', () {
      final opt =
          makeOptionalField(name: 'No Sugar', price: 0, ingredientName: 'Sugar');
      expect(opt.hasIngredient, true);
      expect(opt.isFree, true);

      final opt2 = makeOptionalField(name: 'Syrup', price: 50);
      expect(opt2.hasIngredient, false);
      expect(opt2.isFree, false);
    });
  });

  group('MenuItem', () {
    test('priceForSize returns base price if label null or sizes empty', () {
      final item = makeMenuItem(basePrice: 200);
      expect(item.priceForSize(null), 200);
      expect(item.priceForSize('Large'), 200);
    });

    test('priceForSize returns overridden price if match found', () {
      final item = makeMenuItem(
        basePrice: 200,
        sizes: [makeItemSize(label: 'Large', priceOverride: 300)],
      );
      expect(item.priceForSize('Large'), 300);
      expect(item.priceForSize('Small'), 200); // no match → base price
    });

    test('hasLocalRecipes returns true if recipes not empty', () {
      final item = makeMenuItem(recipes: [makeMenuItemRecipe()]);
      expect(item.hasLocalRecipes, true);
      expect(makeMenuItem().hasLocalRecipes, false);
    });

    test('fromJson & toJson', () {
      final json = {
        'id': 'm1',
        'org_id': 'o1',
        'category_id': 'c1',
        'name': 'Item',
        'name_translations': {'en': 'Item'},
        'description': 'Desc',
        'description_translations': {'en': 'Desc'},
        'image_url': 'url',
        'base_price': 200,
        'is_active': true,
        'sizes': <Map<String, dynamic>>[],
        'addon_slots': <Map<String, dynamic>>[],
        'optional_fields': <Map<String, dynamic>>[],
        'recipes': <Map<String, dynamic>>[],
        'created_at': '2026-01-01T00:00:00.000Z',
        'updated_at': '2026-01-01T00:00:00.000Z',
      };
      final item = MenuItem.fromJson(json);
      expect(item.id, 'm1');
      expect(item.name, 'Item');
      expect(item.basePrice, 200);

      final out = item.toJson();
      expect(out['id'], 'm1');
      expect(out['org_id'], 'o1');
      expect(out['category_id'], 'c1');
      expect(out['base_price'], 200);
      expect(out['is_active'], true);
      // display_order was removed from the contract.
      expect(out.containsKey('display_order'), false);
      expect(out['sizes'], isEmpty);
      expect(out['addon_slots'], isEmpty);
      expect(out['optional_fields'], isEmpty);
      expect(out['recipes'], isEmpty);
    });
  });
}
