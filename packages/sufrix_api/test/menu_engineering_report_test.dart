import 'package:test/test.dart';
import 'package:sufrix_api/sufrix_api.dart';

// tests for MenuEngineeringReport
void main() {
  final MenuEngineeringReport? instance = /* MenuEngineeringReport(...) */ null;
  // TODO add properties to the entity

  group(MenuEngineeringReport, () {
    // String branchId
    test('to test the property `branchId`', () async {
      // TODO
    });

    // Cost basis the report was computed with: \"snapshot\" | \"current\".
    // String costBasis
    test('to test the property `costBasis`', () async {
      // TODO
    });

    // Realized revenue (piastres) carried by the excluded SKUs — explains why `total_sales` differs between cost bases: each basis excludes a different set of un-costable rows.
    // int excludedSales
    test('to test the property `excludedSales`', () async {
      // TODO
    });

    // DateTime from
    test('to test the property `from`', () async {
      // TODO
    });

    // List<MenuEngineeringRow> rows
    test('to test the property `rows`', () async {
      // TODO
    });

    // SKUs sold in the window but EXCLUDED from this report because their cost was unresolvable under the chosen basis.
    // int rowsCostMissing
    test('to test the property `rowsCostMissing`', () async {
      // TODO
    });

    // DateTime to
    test('to test the property `to`', () async {
      // TODO
    });

    // int totalCost
    test('to test the property `totalCost`', () async {
      // TODO
    });

    // int totalProfit
    test('to test the property `totalProfit`', () async {
      // TODO
    });

    // Totals over the returned rows.
    // int totalSales
    test('to test the property `totalSales`', () async {
      // TODO
    });

  });
}
