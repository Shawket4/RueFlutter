# sufrix_api.model.OrderFull

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
**deliveryChannel** | **String** | Delivery channel (\"in_mall\" | \"outside\") of the linked delivery order, surfaced on the list so clients can flag + segment delivery orders without a per-order detail fetch. `null` for dine-in orders. | [optional] 
**deliveryFee** | **int** | Delivery charge in piastres, shown separately from the item subtotal. Always 0 for dine-in orders; for delivery orders `total_amount == subtotal + tax_amount + delivery_fee` (minus discount). | 
**deliveryOrderId** | **String** | Links a finalized delivery order back to its `delivery_orders` row (customer, address, channel, zone). `null` for dine-in orders. | [optional] 
**discountAmount** | **int** |  | 
**discountId** | **String** |  | [optional] 
**discountType** | **String** |  | [optional] 
**discountValue** | **int** |  | 
**id** | **String** |  | 
**notes** | **String** |  | [optional] 
**orderNumber** | **int** |  | 
**orderRef** | **String** | Human-readable, org-unique reference (e.g. \"DT-260614-0042\"). Additive alongside the per-shift order_number. Optional only during the rollout window before the historical backfill runs; never null afterwards. | [optional] 
**orderType** | **String** | Order origin: \"dine_in\" (POS sale) or \"delivery\" (finalized delivery order). Defaults to \"dine_in\" for every POS sale. | 
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
**delivery** | [**OrderDeliveryInfo**](OrderDeliveryInfo.md) | Delivery context (customer phone, address, channel, zone), populated only on the single-order detail endpoint and only when the order originated from a delivery order. `null`/absent for dine-in orders. | [optional] 
**items** | [**List&lt;OrderItemFull&gt;**](OrderItemFull.md) |  | 
**warnings** | **List&lt;String&gt;** | Non-fatal warnings raised while placing the order — currently used to flag ingredients that were oversold (stock driven below zero). Empty for reads/refunds. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


