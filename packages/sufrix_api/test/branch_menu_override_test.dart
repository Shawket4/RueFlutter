import 'package:test/test.dart';
import 'package:sufrix_api/sufrix_api.dart';

// tests for BranchMenuOverride
void main() {
  final BranchMenuOverride? instance = /* BranchMenuOverride(...) */ null;
  // TODO add properties to the entity

  group(BranchMenuOverride, () {
    // String branchId
    test('to test the property `branchId`', () async {
      // TODO
    });

    // False disables the item at this branch (excluded from the branch menu).
    // bool isAvailable
    test('to test the property `isAvailable`', () async {
      // TODO
    });

    // String menuItemId
    test('to test the property `menuItemId`', () async {
      // TODO
    });

    // Branch price in piastres; null inherits the org catalog base_price.
    // int priceOverride
    test('to test the property `priceOverride`', () async {
      // TODO
    });

    // Per-size branch prices for this item (empty when none). Availability is item-level.
    // List<BranchSizeOverride> sizes
    test('to test the property `sizes`', () async {
      // TODO
    });

    // DateTime updatedAt
    test('to test the property `updatedAt`', () async {
      // TODO
    });

  });
}
