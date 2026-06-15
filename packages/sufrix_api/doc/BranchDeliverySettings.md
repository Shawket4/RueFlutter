# sufrix_api.model.BranchDeliverySettings

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**branchId** | **String** |  | 
**inMallCloseTime** | **String** |  | [optional] 
**inMallDiscountId** | **String** | Optional discount applied to each channel's item subtotal (reuses the org `discounts` table). Frozen onto the order at intake. `null` = none. | [optional] 
**inMallEnabled** | **bool** |  | 
**inMallFee** | **int** |  | 
**inMallOpenTime** | **String** |  | [optional] 
**inMallOverride** | **String** |  | 
**maxRoadDistanceMeters** | **int** |  | [optional] 
**outsideCloseTime** | **String** |  | [optional] 
**outsideDiscountId** | **String** |  | [optional] 
**outsideEnabled** | **bool** |  | 
**outsideOpenTime** | **String** |  | [optional] 
**outsideOverride** | **String** |  | 
**prepTimeMinutes** | **int** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


