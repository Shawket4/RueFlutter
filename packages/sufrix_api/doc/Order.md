# sufrix_api.model.Order

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
**createdAt** | [**DateTime**](DateTime.md) |  | 
**customerName** | **String** |  | [optional] 
**discountAmount** | **int** |  | 
**discountId** | **String** |  | [optional] 
**discountType** | **String** |  | [optional] 
**discountValue** | **int** |  | 
**id** | **String** |  | 
**notes** | **String** |  | [optional] 
**orderNumber** | **int** |  | 
**orderRef** | **String** | Human-readable, org-unique reference (e.g. \"DT-260614-0042\"). Additive alongside the per-shift order_number. Optional only during the rollout window before the historical backfill runs; never null afterwards. | [optional] 
**paymentMethod** | **String** |  | 
**shiftId** | **String** |  | 
**status** | **String** |  | 
**subtotal** | **int** |  | 
**taxAmount** | **int** |  | 
**tellerId** | **String** |  | 
**tellerName** | **String** |  | 
**tipAmount** | **int** |  | [optional] 
**tipPaymentMethod** | **String** |  | [optional] 
**totalAmount** | **int** |  | 
**voidNote** | **String** |  | [optional] 
**voidReason** | **String** |  | [optional] 
**voidedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**voidedBy** | **String** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


