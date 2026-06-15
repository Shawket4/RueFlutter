# sufrix_api.model.OrderDeliveryInfo

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**addressLine** | **String** |  | [optional] 
**channel** | **String** | \"in_mall\" or \"outside\". | 
**customerPhone** | **String** |  | 
**deliveryNotes** | **String** |  | [optional] 
**deliveryRef** | **String** | Human-readable delivery reference (e.g. \"D-DT-260614-0042\"). | [optional] 
**floor** | **String** |  | [optional] 
**landmark** | **String** |  | [optional] 
**paymentMethodHint** | **String** | Payment method the customer indicated at intake (\"cash\"/\"card\"); the teller confirms the actual method at finalize. | [optional] 
**placeName** | **String** |  | [optional] 
**roadDistanceMeters** | **int** | Road distance (meters) used to price the delivery, when known. | [optional] 
**unitNumber** | **String** |  | [optional] 
**zoneName** | **String** | Name of the matched delivery zone ring, when an outside order matched one. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


