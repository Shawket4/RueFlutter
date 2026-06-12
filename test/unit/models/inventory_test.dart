import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/inventory.dart';

import '../../helpers/model_fixtures.dart';

void main() {
  group('InventoryItem', () {
    final wire = {
      'id': 'inv1',
      'branch_id': 'br1',
      'org_ingredient_id': 'ing1',
      'ingredient_name': 'Coffee Beans',
      'unit': 'g',
      'cost_per_unit': 0.5,
      'current_stock': 1500.5,
      'reorder_threshold': 100.0,
      'below_reorder': false,
      'created_at': '2026-01-01T00:00:00.000Z',
      'updated_at': '2026-01-01T00:00:00.000Z',
    };

    test('fromJson parses correctly', () {
      final item = InventoryItem.fromJson(wire);

      expect(item.id, 'inv1');
      expect(item.name, 'Coffee Beans');
      expect(item.ingredientName, 'Coffee Beans');
      expect(item.unit, 'g');
      expect(item.currentStock, 1500.5);
    });

    test('fromJson handles current_stock as string (backend BigDecimal)', () {
      final item = InventoryItem.fromJson({
        ...wire,
        'current_stock': '2000',
        'reorder_threshold': '10.5',
      });

      expect(item.currentStock, 2000.0);
      expect(item.reorderThreshold, 10.5);
    });

    test('toJson keeps wire key names', () {
      final item = makeInventoryItem(
        id: 'inv1',
        ingredientName: 'Coffee Beans',
        unit: 'g',
        currentStock: 1500.5,
      );

      final json = item.toJson();

      expect(json['id'], 'inv1');
      expect(json['ingredient_name'], 'Coffee Beans');
      expect(json['unit'], 'g');
      expect(json['current_stock'], 1500.5);
    });
  });
}
