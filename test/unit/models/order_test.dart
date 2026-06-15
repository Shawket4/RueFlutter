import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/order.dart';

import '../../helpers/model_fixtures.dart';

void main() {
  group('OrderItemAddon', () {
    test('fromJson & toJson', () {
      final json = {
        'id': '1',
        'order_item_id': 'o1',
        'addon_item_id': 'a1',
        'addon_name': 'Milk',
        'name_translations': {'en': 'Milk'},
        'unit_price': 10,
        'quantity': 2,
        'line_total': 20,
      };
      final addon = OrderItemAddon.fromJson(json);
      expect(addon.id, '1');
      expect(addon.lineTotal, 20);

      final out = addon.toJson();
      expect(out['id'], '1');
      expect(out['order_item_id'], 'o1');
      expect(out['addon_item_id'], 'a1');
      expect(out['addon_name'], 'Milk');
      expect(out['unit_price'], 10);
      expect(out['quantity'], 2);
      expect(out['line_total'], 20);
    });
  });

  group('OrderItemOptional', () {
    test('fromJson & toJson', () {
      final json = {
        'id': '1',
        'order_item_id': 'o1',
        'optional_field_id': 'of1',
        'field_name': 'No Sugar',
        'name_translations': {'en': 'No Sugar'},
        'price': 0,
      };
      final opt = OrderItemOptional.fromJson(json);
      expect(opt.id, '1');
      expect(opt.fieldName, 'No Sugar');
      expect(opt.quantityDeducted, null);

      final out = opt.toJson();
      expect(out['id'], '1');
      expect(out['order_item_id'], 'o1');
      expect(out['optional_field_id'], 'of1');
      expect(out['field_name'], 'No Sugar');
      expect(out['price'], 0);
    });

    test('fromJson handles quantity_deducted as string (backend BigDecimal)',
        () {
      final opt = OrderItemOptional.fromJson({
        'id': '1',
        'order_item_id': 'o1',
        'field_name': 'Extra Shot',
        'name_translations': const <String, dynamic>{},
        'price': 50,
        'quantity_deducted': '7.5',
      });
      expect(opt.quantityDeducted, 7.5);
    });
  });

  group('InventoryDeduction', () {
    test('fromJson & toJson', () {
      final json = {
        'org_ingredient_id': 'inv1', 'ingredient_name': 'Beans',
        'unit': 'g', 'quantity': 10.5, 'source': 'base', 'category': 'general'
      };
      final ded = InventoryDeduction.fromJson(json);
      expect(ded.ingredientName, 'Beans');
      expect(ded.quantity, 10.5);
      expect(ded.toJson(), json);
    });
  });

  group('OrderItem', () {
    test('fromJson & toJson', () {
      final json = {
        'id': '1',
        'order_id': 'ord1',
        'item_name': 'Coffee',
        'name_translations': {'en': 'Coffee'},
        'size_label': 'L',
        'unit_price': 100,
        'quantity': 2,
        'line_total': 200,
        'cost_missing': false,
        'addons': <Map<String, dynamic>>[],
        'optionals': <Map<String, dynamic>>[],
        'deductions_snapshot': <Map<String, dynamic>>[],
      };
      final item = OrderItem.fromJson(json);
      expect(item.id, '1');
      expect(item.isBundleLine, false);
      expect(item.lineTotal, 200);
      expect(item.deductions, isEmpty);

      final out = item.toJson();
      expect(out['id'], '1');
      expect(out['item_name'], 'Coffee');
      expect(out['size_label'], 'L');
      expect(out['unit_price'], 100);
      expect(out['quantity'], 2);
      expect(out['line_total'], 200);
      expect(out.containsKey('deductions_snapshot'), true);
    });

    test('isBundleLine', () {
      final item = makeOrderItem(bundleId: 'b1');
      expect(item.isBundleLine, true);
      expect(makeOrderItem().isBundleLine, false);
    });

    test('deductions parses the snapshot blob', () {
      final item = makeOrderItem(deductionsSnapshot: [
        {
          'org_ingredient_id': 'inv1',
          'ingredient_name': 'Beans',
          'unit': 'g',
          'quantity': 10.5,
          'source': 'base',
          'category': 'general',
        }
      ]);
      expect(item.deductions.length, 1);
      expect(item.deductions.first.ingredientName, 'Beans');
      expect(item.deductions.first.quantity, 10.5);

      expect(makeOrderItem(deductionsSnapshot: null).deductions, isEmpty);
    });
  });

  group('Order', () {
    test('fromJson & toJson', () {
      final json = {
        'id': 'o1', 'branch_id': 'b1', 'shift_id': 's1', 'teller_id': 't1',
        'teller_name': 'User', 'order_number': 123, 'status': 'completed',
        'payment_method': 'cash', 'subtotal': 1000,
        'discount_value': 0, 'discount_amount': 0, 'tax_amount': 0,
        'total_amount': 1000, 'amount_tendered': 1000, 'change_given': 0,
        'tip_amount': 0, 'order_type': 'dine_in', 'delivery_fee': 0,
        'created_at': '2023-01-01T12:00:00.000Z',
        'items': <Map<String, dynamic>>[],
      };

      final order = Order.fromJson(json);
      expect(order.id, 'o1');
      expect(order.orderNumber, 123);
      expect(order.isVoided, false);

      final out = order.toJson();
      expect(out['id'], 'o1');
      expect(out['branch_id'], 'b1');
      expect(out['shift_id'], 's1');
      expect(out['payment_method'], 'cash');
      expect(out['total_amount'], 1000);
      expect(out['created_at'], '2023-01-01T12:00:00.000Z');
      expect(out['items'], isEmpty);
    });

    test('isVoided', () {
      expect(makeOrder(status: 'voided').isVoided, true);
      expect(makeOrder(status: 'completed').isVoided, false);
    });

    test('copyWith keeps everything but the overridden fields', () {
      final order = makeOrder(
        status: 'completed',
        paymentMethod: 'cash',
        totalAmount: 1234,
        items: [makeOrderItem(itemName: 'Latte')],
      );
      final updated = order.copyWith(status: 'voided', paymentMethod: 'card');
      expect(updated.status, 'voided');
      expect(updated.paymentMethod, 'card');
      expect(updated.totalAmount, 1234);
      expect(updated.items.single.itemName, 'Latte');
      expect(updated.id, order.id);
    });
  });
}
