# sufrix_api.model.MenuEngineeringReport

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**branchId** | **String** |  | 
**costBasis** | **String** | Cost basis the report was computed with: \"snapshot\" | \"current\". | 
**excludedSales** | **int** | Realized revenue (piastres) carried by the excluded SKUs — explains why `total_sales` differs between cost bases: each basis excludes a different set of un-costable rows. | 
**from** | [**DateTime**](DateTime.md) |  | [optional] 
**rows** | [**List&lt;MenuEngineeringRow&gt;**](MenuEngineeringRow.md) |  | 
**rowsCostMissing** | **int** | SKUs sold in the window but EXCLUDED from this report because their cost was unresolvable under the chosen basis. | 
**to** | [**DateTime**](DateTime.md) |  | [optional] 
**totalCost** | **int** |  | 
**totalProfit** | **int** |  | 
**totalSales** | **int** | Totals over the returned rows. | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


