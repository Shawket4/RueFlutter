# sufrix_api.model.VarianceReport

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**netVarianceValue** | **int** | overage − shrinkage (net effect on inventory value). | 
**rows** | [**List&lt;VarianceRow&gt;**](VarianceRow.md) |  | 
**stocktakeId** | **String** |  | 
**totalOverageValue** | **int** | Piastres of overage (positive variances). | 
**totalShrinkageValue** | **int** | Piastres lost to shrinkage (negative variances), as a positive number. | 
**unknownCostCount** | **int** | Count of counted rows whose cost was unknown (excluded from totals). | 
**varianceThresholdPct** | **double** | Org tolerance used to compute `is_flagged`. | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


