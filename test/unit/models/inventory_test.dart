import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/inventory.dart';

void main() {
  group('InventoryItem', () {
    test('fromJson parses correctly', () {
      final json = {
        'id': 'inv1',
        'ingredient_name': 'Coffee Beans',
        'unit': 'g',
        'current_stock': 1500.5,
      };

      final item = InventoryItem.fromJson(json);

      expect(item.id, 'inv1');
      expect(item.name, 'Coffee Beans');
      expect(item.unit, 'g');
      expect(item.currentStock, 1500.5);
    });

    test('fromJson handles current_stock as string', () {
      final json = {
        'id': 'inv2',
        'ingredient_name': 'Milk',
        'unit': 'ml',
        'current_stock': '2000',
      };

      final item = InventoryItem.fromJson(json);

      expect(item.currentStock, 2000.0);
    });

    test('toJson serializes correctly', () {
      const item = InventoryItem(
        id: 'inv1',
        name: 'Coffee Beans',
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
