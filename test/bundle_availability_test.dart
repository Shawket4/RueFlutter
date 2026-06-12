import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/bundle.dart';

import 'helpers/model_fixtures.dart';

/// Converts legacy minutes-since-midnight into the wire "HH:MM" format.
String? _hhmm(int? minutes) => minutes == null
    ? null
    : '${(minutes ~/ 60).toString().padLeft(2, '0')}:'
        '${(minutes % 60).toString().padLeft(2, '0')}';

Bundle _bundle({
  BundleStatus status = BundleStatus.active,
  List<String> branches = const [],
  DateTime? fromDate,
  DateTime? untilDate,
  int? fromMin,
  int? untilMin,
  List<BundleComponent> components = const [],
}) =>
    makeBundle(
      id: 'b1',
      orgId: 'o1',
      name: 'Breakfast Combo',
      price: 4500,
      status: status,
      displayOrder: 1,
      branchIds: branches,
      availableFromDate: fromDate,
      availableUntilDate: untilDate,
      availableFromTime: _hhmm(fromMin),
      availableUntilTime: _hhmm(untilMin),
      components: components,
    );

void main() {
  group('isBundleAvailableNow', () {
    test('active bundle with no restrictions is available', () {
      final b = _bundle();
      expect(
        isBundleAvailableNow(b, 'branch-1', DateTime(2026, 5, 20, 12)),
        isTrue,
      );
    });

    test('archived bundle is not available', () {
      final b = _bundle(status: BundleStatus.archived);
      expect(
        isBundleAvailableNow(b, 'branch-1', DateTime(2026, 5, 20, 12)),
        isFalse,
      );
    });

    test('branch restriction excludes other branches', () {
      final b = _bundle(branches: ['branch-a']);
      expect(
        isBundleAvailableNow(b, 'branch-b', DateTime(2026, 5, 20, 12)),
        isFalse,
      );
      expect(
        isBundleAvailableNow(b, 'branch-a', DateTime(2026, 5, 20, 12)),
        isTrue,
      );
    });

    test('date window is enforced', () {
      final b = _bundle(
        fromDate: DateTime(2026, 5, 21),
        untilDate: DateTime(2026, 5, 25),
      );
      expect(
        isBundleAvailableNow(b, 'branch-1', DateTime(2026, 5, 20, 12)),
        isFalse,
      );
      expect(
        isBundleAvailableNow(b, 'branch-1', DateTime(2026, 5, 22, 12)),
        isTrue,
      );
    });

    test('time window is enforced', () {
      final b = _bundle(fromMin: 9 * 60, untilMin: 17 * 60);
      expect(
        isBundleAvailableNow(b, 'branch-1', DateTime(2026, 5, 20, 8, 30)),
        isFalse,
      );
      expect(
        isBundleAvailableNow(b, 'branch-1', DateTime(2026, 5, 20, 10)),
        isTrue,
      );
    });
  });

  group('bundleOutOfStockReason', () {
    test('returns component name when ingredient stock is low', () {
      final menuItems = [
        makeMenuItem(
          id: 'item-1',
          orgId: 'o1',
          name: 'Croissant',
          basePrice: 2000,
          displayOrder: 0,
          recipes: [
            makeMenuItemRecipe(
              orgIngredientId: 'ing-1',
              quantityUsed: 1,
              ingredientName: 'Flour',
              ingredientUnit: 'g',
              category: 'general',
            ),
          ],
        ),
      ];
      final inventory = [
        makeInventoryItem(
          id: 'ing-1',
          orgIngredientId: 'ing-1',
          ingredientName: 'Flour',
          unit: 'g',
          currentStock: 0,
        ),
      ];
      final bundle = _bundle(components: [
        makeBundleComponent(
          bundleId: 'b1',
          itemId: 'item-1',
          quantity: 1,
          position: 0,
        ),
      ]);

      expect(
        bundleOutOfStockReason(bundle, menuItems, inventory),
        'Croissant',
      );
    });

    test('returns null when all components are in stock', () {
      final menuItems = [
        makeMenuItem(
          id: 'item-1',
          orgId: 'o1',
          name: 'Latte',
          basePrice: 3000,
          displayOrder: 0,
          recipes: [
            makeMenuItemRecipe(
              orgIngredientId: 'ing-milk',
              quantityUsed: 0.2,
              ingredientName: 'Milk',
              ingredientUnit: 'L',
              category: 'milk',
            ),
          ],
        ),
      ];
      final inventory = [
        makeInventoryItem(
          id: 'ing-milk',
          orgIngredientId: 'ing-milk',
          ingredientName: 'Milk',
          unit: 'L',
          currentStock: 10,
        ),
      ];
      final bundle = _bundle(components: [
        makeBundleComponent(
          bundleId: 'b1',
          itemId: 'item-1',
          quantity: 1,
          position: 0,
        ),
      ]);

      expect(bundleOutOfStockReason(bundle, menuItems, inventory), isNull);
    });
  });
}
