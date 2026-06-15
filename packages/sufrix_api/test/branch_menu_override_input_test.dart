import 'package:test/test.dart';
import 'package:sufrix_api/sufrix_api.dart';

// tests for BranchMenuOverrideInput
void main() {
  final BranchMenuOverrideInput? instance = /* BranchMenuOverrideInput(...) */ null;
  // TODO add properties to the entity

  group(BranchMenuOverrideInput, () {
    // String branchId
    test('to test the property `branchId`', () async {
      // TODO
    });

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

    // Per-size branch prices. `null`/omitted → leave existing size overrides untouched; a list → REPLACE the item's size overrides with exactly that set (empty clears them).
    // List<BranchSizeOverrideInput> sizes
    test('to test the property `sizes`', () async {
      // TODO
    });

  });
}
