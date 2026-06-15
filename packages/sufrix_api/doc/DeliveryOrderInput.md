# sufrix_api.model.DeliveryOrderInput

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**addressLine** | **String** |  | [optional] 
**branchId** | **String** |  | 
**channel** | **String** |  | 
**customerLat** | **double** |  | [optional] 
**customerLng** | **double** |  | [optional] 
**customerName** | **String** |  | 
**customerPhone** | **String** |  | 
**deliveryNotes** | **String** |  | [optional] 
**deviceToken** | **String** | Device-trust token from OTP verify (proves the phone). | 
**floor** | **String** |  | [optional] 
**items** | [**List&lt;CartLineInput&gt;**](CartLineInput.md) |  | 
**landmark** | **String** |  | [optional] 
**paymentMethodHint** | **String** | \"cash\" | \"card\" — a hint the teller can change at finalize. | 
**placeName** | **String** |  | [optional] 
**unitNumber** | **String** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


