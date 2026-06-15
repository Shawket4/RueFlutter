# sufrix_api.model.CreateOrderRequest

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**amountTendered** | **int** |  | [optional] 
**branchId** | **String** |  | 
**changeGiven** | **int** |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | [optional] 
**customerName** | **String** |  | [optional] 
**discountAmount** | **int** |  | [optional] 
**discountId** | **String** |  | [optional] 
**discountType** | **String** |  | [optional] 
**discountValue** | **int** |  | [optional] 
**items** | [**List&lt;OrderItemInput&gt;**](OrderItemInput.md) |  | 
**notes** | **String** |  | [optional] 
**paymentMethod** | **String** |  | 
**paymentSplits** | [**List&lt;PaymentSplitInput&gt;**](PaymentSplitInput.md) |  | [optional] 
**shiftId** | **String** |  | 
**subtotal** | **int** |  | [optional] 
**taxAmount** | **int** |  | [optional] 
**tipAmount** | **int** |  | [optional] 
**tipPaymentMethod** | **String** |  | [optional] 
**totalAmount** | **int** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


