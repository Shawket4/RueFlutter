# sufrix_api.model.StocktakeFull

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**branchId** | **String** |  | 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**finalizedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**finalizedBy** | **String** |  | [optional] 
**id** | **String** |  | 
**note** | **String** |  | [optional] 
**orgId** | **String** |  | 
**startedAt** | [**DateTime**](DateTime.md) |  | 
**startedBy** | **String** |  | 
**startedByName** | **String** |  | [optional] 
**status** | **String** |  | 
**items** | [**List&lt;StocktakeItem&gt;**](StocktakeItem.md) |  | 
**varianceThresholdPct** | **double** | Org tolerance: a counted row whose |difference| is >= this percent of the expected quantity (or that appears-from / vanishes-to zero) is flagged and requires a `variance_reason` before the count can be finalized. | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


