# sufrix_api.model.MenuEngineeringReport

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**branchId** | **String** |  | 
**from** | [**DateTime**](DateTime.md) |  | [optional] 
**rows** | [**List&lt;MenuEngineeringRow&gt;**](MenuEngineeringRow.md) |  | 
**rowsCostMissing** | **int** | Rows excluded from profit math because cost was unresolvable. | 
**to** | [**DateTime**](DateTime.md) |  | [optional] 
**totalCost** | **int** |  | 
**totalProfit** | **int** |  | 
**totalSales** | **int** | Totals over cost-tracked rows. | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


