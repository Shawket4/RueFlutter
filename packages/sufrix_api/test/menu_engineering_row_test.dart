import 'package:test/test.dart';
import 'package:sufrix_api/sufrix_api.dart';

// tests for MenuEngineeringRow
void main() {
  final MenuEngineeringRow? instance = /* MenuEngineeringRow(...) */ null;
  // TODO add properties to the entity

  group(MenuEngineeringRow, () {
    // String categoryId
    test('to test the property `categoryId`', () async {
      // TODO
    });

    // String categoryName
    test('to test the property `categoryName`', () async {
      // TODO
    });

    // star | workhorse | challenge | dog (Foodics names) — only for cost-tracked rows; `null` when cost is unknown.
    // String class_
    test('to test the property `class_`', () async {
      // TODO
    });

    // Lines in the window whose cost could not be resolved.
    // int costMissingLines
    test('to test the property `costMissingLines`', () async {
      // TODO
    });

    // String itemName
    test('to test the property `itemName`', () async {
      // TODO
    });

    // Average profit per unit, piastres (`(sales - cost) / qty`).
    // int itemProfit
    test('to test the property `itemProfit`', () async {
      // TODO
    });

    // String menuItemId
    test('to test the property `menuItemId`', () async {
      // TODO
    });

    // \"high\" | \"low\" — Kasavana-Smith 70% rule (0.70 / n).
    // String popularityCategory
    test('to test the property `popularityCategory`', () async {
      // TODO
    });

    // Share of units among rows in this report.
    // double popularityPct
    test('to test the property `popularityPct`', () async {
      // TODO
    });

    // \"high\" | \"low\" — vs weighted-average per-unit profit (cost-tracked rows only).
    // String profitCategory
    test('to test the property `profitCategory`', () async {
      // TODO
    });

    // Units sold (standalone lines only — bundle lines are excluded so the per-unit economics stay clean; bundle performance has its own report).
    // int quantitySold
    test('to test the property `quantitySold`', () async {
      // TODO
    });

    // Revenue from those lines, piastres.
    // int sales
    test('to test the property `sales`', () async {
      // TODO
    });

    // `\"one_size\"` for items without sizes.
    // String sizeLabel
    test('to test the property `sizeLabel`', () async {
      // TODO
    });

    // COGS from sale-time snapshots, piastres. `null` ⟺ at least one line in the window had unresolved cost.
    // int totalCost
    test('to test the property `totalCost`', () async {
      // TODO
    });

    // `sales - total_cost`, piastres.
    // int totalProfit
    test('to test the property `totalProfit`', () async {
      // TODO
    });

  });
}
