import 'package:test/test.dart';
import 'package:sufrix_api/sufrix_api.dart';

// tests for SkuCost
void main() {
  final SkuCost? instance = /* SkuCost(...) */ null;
  // TODO add properties to the entity

  group(SkuCost, () {
    // String categoryId
    test('to test the property `categoryId`', () async {
      // TODO
    });

    // Recipe cost rollup in piastres. `null` ⟺ unknown (no recipe, or any ingredient unlinked / missing a cost).
    // int cost
    test('to test the property `cost`', () async {
      // TODO
    });

    // bool costMissing
    test('to test the property `costMissing`', () async {
      // TODO
    });

    // `cost / price` when both known and price > 0.
    // double foodCostPct
    test('to test the property `foodCostPct`', () async {
      // TODO
    });

    // String itemName
    test('to test the property `itemName`', () async {
      // TODO
    });

    // `(price - cost) / price` when both known and price > 0.
    // double marginPct
    test('to test the property `marginPct`', () async {
      // TODO
    });

    // String menuItemId
    test('to test the property `menuItemId`', () async {
      // TODO
    });

    // Current price in piastres for this SKU.
    // int price
    test('to test the property `price`', () async {
      // TODO
    });

    // `\"one_size\"` when the item has no sizes.
    // String sizeLabel
    test('to test the property `sizeLabel`', () async {
      // TODO
    });

  });
}
