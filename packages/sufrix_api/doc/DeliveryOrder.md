# sufrix_api.model.DeliveryOrder

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**addressLine** | **String** |  | [optional] 
**branchId** | **String** |  | 
**cancelReason** | **String** |  | [optional] 
**cancelRestocked** | **bool** |  | [optional] 
**cancelledAt** | [**DateTime**](DateTime.md) |  | [optional] 
**cart** | **Object** | The frozen priced line snapshot the POS renders before finalize. | 
**channel** | **String** |  | 
**confirmedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**customerLat** | **double** |  | [optional] 
**customerLng** | **double** |  | [optional] 
**customerName** | **String** |  | 
**customerPhone** | **String** |  | 
**deliveredAt** | [**DateTime**](DateTime.md) |  | [optional] 
**deliveryFee** | **int** |  | 
**deliveryNotes** | **String** |  | [optional] 
**deliveryRef** | **String** |  | [optional] 
**deliveryZoneId** | **String** |  | [optional] 
**discountAmount** | **int** |  | [optional] 
**discountId** | **String** | Frozen channel discount on the item subtotal (`total == subtotal - discount_amount + delivery_fee`). `discount_amount` is 0 when none. | [optional] 
**discountType** | **String** |  | [optional] 
**discountValue** | **int** |  | [optional] 
**extraPrepMinutes** | **int** | Extra prep minutes the teller added on top of the branch base (multiples of 5). | 
**floor** | **String** |  | [optional] 
**id** | **String** |  | 
**landmark** | **String** |  | [optional] 
**orderId** | **String** |  | [optional] 
**orgId** | **String** |  | 
**otpVerified** | **bool** |  | 
**outForDeliveryAt** | [**DateTime**](DateTime.md) |  | [optional] 
**paymentMethodHint** | **String** |  | [optional] 
**placeName** | **String** |  | [optional] 
**preparingAt** | [**DateTime**](DateTime.md) |  | [optional] 
**readyAt** | [**DateTime**](DateTime.md) |  | [optional] 
**receiptPrintedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**rejectedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**roadDistanceMeters** | **int** |  | [optional] 
**status** | **String** |  | 
**subtotal** | **int** |  | 
**total** | **int** |  | 
**unitNumber** | **String** |  | [optional] 
**updatedAt** | [**DateTime**](DateTime.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


