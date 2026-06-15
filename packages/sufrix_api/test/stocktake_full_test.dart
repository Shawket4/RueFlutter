import 'package:test/test.dart';
import 'package:sufrix_api/sufrix_api.dart';

// tests for StocktakeFull
void main() {
  final StocktakeFull? instance = /* StocktakeFull(...) */ null;
  // TODO add properties to the entity

  group(StocktakeFull, () {
    // String branchId
    test('to test the property `branchId`', () async {
      // TODO
    });

    // Branch label — only populated by the stocktakes list (so the \"All branches\" view can show which branch each stocktake belongs to). Other stocktake endpoints leave it `null`.
    // String branchName
    test('to test the property `branchName`', () async {
      // TODO
    });

    // DateTime createdAt
    test('to test the property `createdAt`', () async {
      // TODO
    });

    // DateTime finalizedAt
    test('to test the property `finalizedAt`', () async {
      // TODO
    });

    // String finalizedBy
    test('to test the property `finalizedBy`', () async {
      // TODO
    });

    // String id
    test('to test the property `id`', () async {
      // TODO
    });

    // String note
    test('to test the property `note`', () async {
      // TODO
    });

    // String orgId
    test('to test the property `orgId`', () async {
      // TODO
    });

    // DateTime startedAt
    test('to test the property `startedAt`', () async {
      // TODO
    });

    // String startedBy
    test('to test the property `startedBy`', () async {
      // TODO
    });

    // String startedByName
    test('to test the property `startedByName`', () async {
      // TODO
    });

    // String status
    test('to test the property `status`', () async {
      // TODO
    });

    // List<StocktakeItem> items
    test('to test the property `items`', () async {
      // TODO
    });

    // Org tolerance: a counted row whose |difference| is >= this percent of the expected quantity (or that appears-from / vanishes-to zero) is flagged and requires a `variance_reason` before the count can be finalized.
    // double varianceThresholdPct
    test('to test the property `varianceThresholdPct`', () async {
      // TODO
    });

  });
}
