# sufrix_api.model.CalibrationSummary

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**branchId** | **String** |  | 
**cmInRangePct** | **double** | Fraction of accepted CM suggestions whose realized price landed within ±2% of the suggested price. `None` below 10 samples. | [optional] 
**pointsCm** | [**List&lt;CalibrationPoint&gt;**](CalibrationPoint.md) |  | 
**pointsRevenue** | [**List&lt;CalibrationPoint&gt;**](CalibrationPoint.md) |  | 
**revenueInRangePct** | **double** |  | [optional] 
**since** | [**DateTime**](DateTime.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


