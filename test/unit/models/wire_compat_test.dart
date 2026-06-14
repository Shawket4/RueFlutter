// Wire-compatibility regression tests for the migration from hand-rolled
// models to the OpenAPI-generated ones (packages/sufrix_api).
//
// For each cached/wire entity: take a representative wire JSON map (field
// shapes follow what the backend serializes — the same keys the old
// hand-rolled toJson used) → fromJson → assert key values → toJson → assert
// the wire key names survive a round-trip, so existing KV caches and the
// backend contract stay intact.
import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/branch.dart';
import 'package:sufrix_pos/core/models/menu.dart';
import 'package:sufrix_pos/core/models/order.dart';
import 'package:sufrix_pos/core/models/payment_method.dart';
import 'package:sufrix_pos/core/models/shift.dart';

void main() {
  group('wire compat: order (with items + addons)', () {
    final wire = {
      'id': 'ord-1',
      'branch_id': 'br-1',
      'shift_id': 'sh-1',
      'teller_id': 'u-1',
      'teller_name': 'Sara',
      'order_number': 42,
      'status': 'completed',
      'payment_method': 'cash',
      'subtotal': 5500,
      'discount_type': 'percentage',
      'discount_value': 10,
      'discount_amount': 550,
      'tax_amount': 0,
      'total_amount': 4950,
      'amount_tendered': 10000,
      'change_given': 5050,
      'tip_amount': 200,
      'tip_payment_method': 'cash',
      'discount_id': 'd-1',
      'customer_name': 'Walk-in',
      'notes': 'no foam',
      'created_at': '2026-02-03T10:15:00.000Z',
      'items': [
        {
          'id': 'oi-1',
          'order_id': 'ord-1',
          'item_name': 'Latte',
          'name_translations': {'en': 'Latte', 'ar': 'لاتيه'},
          'size_label': 'L',
          'unit_price': 5000,
          'quantity': 1,
          'line_total': 5500,
          'cost_missing': false,
          'addons': [
            {
              'id': 'oia-1',
              'order_item_id': 'oi-1',
              'addon_item_id': 'a-1',
              'addon_name': 'Oat Milk',
              'name_translations': {'en': 'Oat Milk'},
              'unit_price': 500,
              'quantity': 1,
              'line_total': 500,
            }
          ],
          'optionals': [
            {
              'id': 'oio-1',
              'order_item_id': 'oi-1',
              'optional_field_id': 'of-1',
              'field_name': 'Extra Hot',
              'name_translations': {'en': 'Extra Hot'},
              'price': 0,
              'org_ingredient_id': null,
              'quantity_deducted': 2.5,
            }
          ],
          'deductions_snapshot': [
            {
              'org_ingredient_id': 'ing-1',
              'ingredient_name': 'Espresso Beans',
              'unit': 'g',
              'quantity': 18.0,
              'source': 'drink_recipe',
              'category': 'coffee_bean',
            }
          ],
        }
      ],
    };

    test('fromJson → values', () {
      final order = Order.fromJson(wire);
      expect(order.id, 'ord-1');
      expect(order.orderNumber, 42);
      expect(order.paymentMethod, 'cash');
      expect(order.totalAmount, 4950);
      expect(order.tipAmount, 200);
      expect(order.isVoided, false);
      expect(order.createdAt.toUtc().toIso8601String(),
          '2026-02-03T10:15:00.000Z');

      final item = order.items.single;
      expect(item.itemName, 'Latte');
      expect(item.sizeLabel, 'L');
      expect(item.unitPrice, 5000);
      expect(item.lineTotal, 5500);
      expect(item.isBundleLine, false);

      final addon = item.addons.single;
      expect(addon.addonName, 'Oat Milk');
      expect(addon.unitPrice, 500);
      expect(addon.lineTotal, 500);

      final optional = item.optionals.single;
      expect(optional.fieldName, 'Extra Hot');
      expect(optional.price, 0);
      expect(optional.quantityDeducted, 2.5);

      // Client-side parse of the deductions blob.
      final deduction = item.deductions.single;
      expect(deduction.ingredientName, 'Espresso Beans');
      expect(deduction.quantity, 18.0);
      expect(deduction.category, 'coffee_bean');
    });

    test('toJson → wire key names preserved', () {
      final out = Order.fromJson(wire).toJson();
      for (final key in [
        'id', 'branch_id', 'shift_id', 'teller_id', 'teller_name',
        'order_number', 'status', 'payment_method', 'subtotal',
        'discount_type', 'discount_value', 'discount_amount', 'tax_amount',
        'total_amount', 'amount_tendered', 'change_given', 'tip_amount',
        'tip_payment_method', 'discount_id', 'customer_name', 'notes',
        'created_at', 'items',
      ]) {
        expect(out.containsKey(key), true, reason: 'order key $key');
      }

      final item = (out['items'] as List).single as Map<String, dynamic>;
      for (final key in [
        'id', 'order_id', 'item_name', 'size_label', 'unit_price',
        'quantity', 'line_total', 'addons', 'optionals',
        'deductions_snapshot',
      ]) {
        expect(item.containsKey(key), true, reason: 'item key $key');
      }

      final addon = (item['addons'] as List).single as Map<String, dynamic>;
      for (final key in [
        'id', 'order_item_id', 'addon_item_id', 'addon_name', 'unit_price',
        'quantity', 'line_total',
      ]) {
        expect(addon.containsKey(key), true, reason: 'addon key $key');
      }

      // And the whole thing round-trips (cache write → cache read).
      final restored = Order.fromJson(out);
      expect(restored.totalAmount, 4950);
      expect(restored.items.single.addons.single.addonName, 'Oat Milk');
      expect(restored.items.single.deductions.single.quantity, 18.0);
    });
  });

  group('wire compat: menu item', () {
    final wire = {
      'id': 'm-1',
      'org_id': 'o-1',
      'category_id': 'c-1',
      'name': 'Latte',
      'name_translations': {'en': 'Latte'},
      'description': 'Smooth',
      'description_translations': {'en': 'Smooth'},
      'image_url': 'http://img',
      'base_price': 5000,
      'is_active': true,
      'display_order': 3,
      'default_milk_addon_id': 'a-9',
      'sizes': [
        {
          'id': 's-1',
          'menu_item_id': 'm-1',
          'label': 'L',
          'price_override': 5500,
          'display_order': 0,
          'is_active': true,
        }
      ],
      'addon_slots': [
        {
          'id': 'slot-1',
          'menu_item_id': 'm-1',
          'addon_type': 'milk_type',
          'label': null,
          'label_translations': {},
          'is_required': false,
          'min_selections': 0,
          'max_selections': 1,
          'display_order': 0,
          'created_at': '2026-01-01T00:00:00.000Z',
        }
      ],
      'optional_fields': [
        {
          'id': 'f-1',
          'menu_item_id': 'm-1',
          'name': 'Extra Shot',
          'name_translations': {},
          'price': 700,
          'org_ingredient_id': 'ing-1',
          'ingredient_name': 'Beans',
          'ingredient_unit': 'g',
          'quantity_used': '9.5', // backend BigDecimal serializes as string
          'display_order': 0,
          'is_active': true,
          'created_at': '2026-01-01T00:00:00.000Z',
          'updated_at': '2026-01-01T00:00:00.000Z',
        }
      ],
      'recipes': [
        {
          'org_ingredient_id': 'ing-1',
          'quantity_used': '18', // backend BigDecimal serializes as string
          'ingredient_name': 'Beans',
          'ingredient_unit': 'g',
          'category': 'coffee_bean',
          'size_label': 'L',
        }
      ],
      'created_at': '2026-01-01T00:00:00.000Z',
      'updated_at': '2026-01-01T00:00:00.000Z',
    };

    test('fromJson → values', () {
      final item = MenuItem.fromJson(wire);
      expect(item.name, 'Latte');
      expect(item.basePrice, 5000);
      expect(item.priceForSize('L'), 5500);
      expect(item.priceForSize(null), 5000);
      expect(item.sizes.single.price, 5500);
      expect(item.addonSlots.single.displayName, 'Milk Type');
      expect(item.optionalFields.single.hasIngredient, true);
      expect(item.optionalFields.single.quantityUsed, 9.5);
      expect(item.hasLocalRecipes, true);
      expect(item.recipes.single.quantityUsed, 18.0);
    });

    test('toJson → wire key names preserved', () {
      final out = MenuItem.fromJson(wire).toJson();
      for (final key in [
        'id', 'org_id', 'category_id', 'name', 'base_price', 'is_active',
        'sizes', 'addon_slots', 'optional_fields', 'recipes',
        'default_milk_addon_id',
      ]) {
        expect(out.containsKey(key), true, reason: 'menu item key $key');
      }
      // display_order was removed from the contract; the menu renders in
      // server order, so neither the item nor its sizes emit the key.
      expect(out.containsKey('display_order'), false);
      final size = (out['sizes'] as List).single as Map<String, dynamic>;
      expect(size['label'], 'L');
      expect(size['price_override'], 5500);
      expect(size.containsKey('display_order'), false);

      final restored = MenuItem.fromJson(out);
      expect(restored.priceForSize('L'), 5500);
    });
  });

  group('wire compat: shift', () {
    final wire = {
      'id': 'sh-1',
      'branch_id': 'br-1',
      'teller_id': 'u-1',
      'teller_name': 'Sara',
      'status': 'open',
      'opening_cash': 20000,
      'opening_cash_was_edited': false,
      'closing_cash_declared': null,
      'closing_cash_system': null,
      'cash_discrepancy': null,
      'opened_at': '2026-02-03T08:00:00.000Z',
      'closed_at': null,
    };

    test('fromJson → values → toJson keys', () {
      final shift = Shift.fromJson(wire);
      expect(shift.id, 'sh-1');
      expect(shift.isOpen, true);
      expect(shift.openingCash, 20000);

      final out = shift.toJson();
      for (final key in [
        'id', 'branch_id', 'teller_id', 'teller_name', 'status',
        'opening_cash', 'opened_at',
      ]) {
        expect(out.containsKey(key), true, reason: 'shift key $key');
      }

      final restored = Shift.fromJson(out);
      expect(restored.isOpen, true);
      expect(restored.openingCash, 20000);
    });
  });

  group('wire compat: branch', () {
    final wire = {
      'id': 'br-1',
      'org_id': 'o-1',
      'name': 'Main',
      'address': null,
      'phone': null,
      'printer_brand': 'epson',
      'printer_ip': '10.0.0.5',
      'printer_port': 9100,
      'is_active': true,
      'org_logo_url': null,
      'timezone': 'Africa/Cairo',
      'created_at': '2026-01-01T00:00:00.000Z',
      'updated_at': '2026-01-01T00:00:00.000Z',
    };

    test('fromJson → values → toJson keys', () {
      final branch = Branch.fromJson(wire);
      expect(branch.name, 'Main');
      expect(branch.printerBrand, PrinterBrand.epson);
      expect(branch.hasPrinter, true);

      final out = branch.toJson();
      for (final key in [
        'id', 'org_id', 'name', 'printer_brand', 'printer_ip',
        'printer_port', 'is_active',
      ]) {
        expect(out.containsKey(key), true, reason: 'branch key $key');
      }
      expect(out['printer_brand'], 'epson');

      final restored = Branch.fromJson(out);
      expect(restored.hasPrinter, true);
    });
  });

  group('wire compat: payment method', () {
    final wire = {
      'id': 'pm-1',
      'org_id': 'o-1',
      'name': 'talabat_cash',
      'label_translations': {'en': 'Talabat Cash', 'ar': 'طلبات كاش'},
      'color': '#FF5A00',
      'icon': 'delivery',
      'is_cash': true,
      'is_active': true,
      'display_order': 4,
      'created_at': '2026-01-01T00:00:00.000Z',
      'updated_at': '2026-01-01T00:00:00.000Z',
    };

    test('fromJson → values → toJson keys', () {
      final method = PaymentMethod.fromJson(wire);
      expect(method.wireFormat, 'talabat_cash');
      expect(method.isCash, true);
      expect(method.label('en'), 'Talabat Cash');
      expect(method.label('ar-EG'), 'طلبات كاش');

      final out = method.toJson();
      for (final key in [
        'id', 'org_id', 'name', 'label_translations', 'color', 'icon',
        'is_cash', 'is_active',
      ]) {
        expect(out.containsKey(key), true, reason: 'payment method key $key');
      }
      // display_order was removed from the payment-method contract.
      expect(out.containsKey('display_order'), false);

      final restored = PaymentMethod.fromJson(out);
      expect(restored.wireFormat, 'talabat_cash');
      expect(restored.label('en'), 'Talabat Cash');
    });
  });
}
