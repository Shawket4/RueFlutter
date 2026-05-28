import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/order.dart';

void main() {
  group('OrderItemAddon', () {
    test('fromJson & toJson', () {
      final json = {
        'id': '1', 'order_item_id': 'o1', 'addon_item_id': 'a1',
        'addon_name': 'Milk', 'unit_price': 10, 'quantity': 2, 'line_total': 20
      };
      final addon = OrderItemAddon.fromJson(json);
      expect(addon.id, '1');
      expect(addon.lineTotal, 20);
      expect(addon.toJson(), json);
    });
  });

  group('OrderItemOptional', () {
    test('fromJson & toJson', () {
      final json = {
        'id': '1', 'order_item_id': 'o1', 'optional_field_id': 'of1',
        'field_name': 'No Sugar', 'price': 0, 'org_ingredient_id': null,
        'ingredient_name': null, 'ingredient_unit': null, 'quantity_deducted': null
      };
      final opt = OrderItemOptional.fromJson(json);
      expect(opt.id, '1');
      expect(opt.fieldName, 'No Sugar');
      expect(opt.toJson(), json);
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
        'id': '1', 'item_name': 'Coffee', 'size_label': 'L',
        'bundle_id': null, 'unit_price': 100, 'quantity': 2, 'line_total': 200,
        'addons': [], 'optionals': [], 'deductions_snapshot': []
      };
      final item = OrderItem.fromJson(json);
      expect(item.id, '1');
      expect(item.isBundleLine, false);
      expect(item.lineTotal, 200);
      
      final out = item.toJson();
      expect(out['id'], '1');
      expect(out['item_name'], 'Coffee');
    });

    test('isBundleLine', () {
      final item = OrderItem(
        id: '1', itemName: 'B', bundleId: 'b1', unitPrice: 100, quantity: 1, lineTotal: 100, addons: []
      );
      expect(item.isBundleLine, true);
    });
  });

  group('Order', () {
    test('fromJson & toJson', () {
      final json = {
        'id': 'o1', 'branch_id': 'b1', 'shift_id': 's1', 'teller_id': 't1',
        'teller_name': 'User', 'order_number': 123, 'status': 'completed',
        'payment_method': 'cash', 'subtotal': 1000, 'discount_type': null,
        'discount_value': 0, 'discount_amount': 0, 'tax_amount': 0,
        'total_amount': 1000, 'amount_tendered': 1000, 'change_given': 0,
        'tip_amount': 0, 'tip_payment_method': null, 'discount_id': null,
        'customer_name': null, 'notes': null, 'void_reason': null,
        'created_at': '2023-01-01T12:00:00.000Z', 'items': []
      };

      final order = Order.fromJson(json);
      expect(order.id, 'o1');
      expect(order.orderNumber, 123);
      expect(order.isVoided, false);
      
      final out = order.toJson();
      expect(out['id'], 'o1');
      expect(out['created_at'], '2023-01-01T12:00:00.000Z');
    });

    test('isVoided', () {
      final order = Order(
        id: '1', branchId: 'b', shiftId: 's', tellerId: 't', tellerName: 't',
        orderNumber: 1, status: 'voided', paymentMethod: 'cash', subtotal: 0,
        discountValue: 0, discountAmount: 0, taxAmount: 0, totalAmount: 0,
        createdAt: DateTime.now(), items: []
      );
      expect(order.isVoided, true);
    });
  });
}
