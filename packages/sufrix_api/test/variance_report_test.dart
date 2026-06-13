import 'package:test/test.dart';
import 'package:sufrix_api/sufrix_api.dart';

// tests for VarianceReport
void main() {
  final VarianceReport? instance = /* VarianceReport(...) */ null;
  // TODO add properties to the entity

  group(VarianceReport, () {
    // overage − shrinkage (net effect on inventory value).
    // int netVarianceValue
    test('to test the property `netVarianceValue`', () async {
      // TODO
    });

    // List<VarianceRow> rows
    test('to test the property `rows`', () async {
      // TODO
    });

    // String stocktakeId
    test('to test the property `stocktakeId`', () async {
      // TODO
    });

    // Piastres of overage (positive variances).
    // int totalOverageValue
    test('to test the property `totalOverageValue`', () async {
      // TODO
    });

    // Piastres lost to shrinkage (negative variances), as a positive number.
    // int totalShrinkageValue
    test('to test the property `totalShrinkageValue`', () async {
      // TODO
    });

    // Count of counted rows whose cost was unknown (excluded from totals).
    // int unknownCostCount
    test('to test the property `unknownCostCount`', () async {
      // TODO
    });

    // Org tolerance used to compute `is_flagged`.
    // double varianceThresholdPct
    test('to test the property `varianceThresholdPct`', () async {
      // TODO
    });

  });
}
