# sufrix_api.model.MenuEngineeringRow

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**categoryId** | **String** |  | [optional] 
**categoryName** | **String** |  | [optional] 
**class_** | **String** | star | workhorse | challenge | dog (Foodics names). | 
**costMissingLines** | **int** | Lines in the window whose sale-time cost could not be resolved. Always reports snapshot data quality, regardless of `cost_basis` — under `current`, an included row can still carry snapshot gaps. | 
**itemName** | **String** |  | 
**itemProfit** | **int** | Average profit per unit, piastres (`(sales - cost) / qty`). | 
**menuItemId** | **String** |  | 
**popularityCategory** | **String** | \"high\" | \"low\" — Kasavana-Smith 70% rule (0.70 / n). | 
**popularityPct** | **double** | Share of units among the rows in this report (cost-tracked only). | 
**profitCategory** | **String** | \"high\" | \"low\" — vs weighted-average per-unit profit. | 
**quantitySold** | **int** | Units sold (standalone lines only — bundle lines are excluded so the per-unit economics stay clean; bundle performance has its own report). | 
**sales** | **int** | Revenue from those lines, piastres. | 
**sizeLabel** | **String** | `\"one_size\"` for items without sizes. | 
**totalCost** | **int** | Recipe-scope COGS in piastres (additive addons excluded — they have their own revenue and their own report). Snapshot basis: `SUM(unit_cost × quantity)`; current basis: today's recipe rollup × quantity. Rows where this is unresolvable are excluded from the report, so it is always present. | 
**totalProfit** | **int** | `sales - total_cost`, piastres. | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


