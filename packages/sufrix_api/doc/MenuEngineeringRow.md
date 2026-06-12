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
**class_** | **String** | star | workhorse | challenge | dog (Foodics names) — only for cost-tracked rows; `null` when cost is unknown. | [optional] 
**costMissingLines** | **int** | Lines in the window whose cost could not be resolved. | 
**itemName** | **String** |  | 
**itemProfit** | **int** | Average profit per unit, piastres (`(sales - cost) / qty`). | [optional] 
**menuItemId** | **String** |  | 
**popularityCategory** | **String** | \"high\" | \"low\" — Kasavana-Smith 70% rule (0.70 / n). | 
**popularityPct** | **double** | Share of units among rows in this report. | 
**profitCategory** | **String** | \"high\" | \"low\" — vs weighted-average per-unit profit (cost-tracked rows only). | [optional] 
**quantitySold** | **int** | Units sold (standalone lines only — bundle lines are excluded so the per-unit economics stay clean; bundle performance has its own report). | 
**sales** | **int** | Revenue from those lines, piastres. | 
**sizeLabel** | **String** | `\"one_size\"` for items without sizes. | 
**totalCost** | **int** | COGS from sale-time snapshots, piastres. `null` ⟺ at least one line in the window had unresolved cost. | [optional] 
**totalProfit** | **int** | `sales - total_cost`, piastres. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


