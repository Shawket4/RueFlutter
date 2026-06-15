# sufrix_api.model.DeliveryMenu

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**addons** | [**List&lt;DeliveryAddonOption&gt;**](DeliveryAddonOption.md) | Org-wide addon catalog (global, POS model): channel-effective, grouped by `type`, applicable to every item. Channel-unavailable options are excluded. | 
**categories** | [**List&lt;DeliveryMenuCategory&gt;**](DeliveryMenuCategory.md) |  | 
**discount** | [**DeliveryMenuDiscount**](DeliveryMenuDiscount.md) | The active discount for this channel (customer-facing) or `null`. Applies to the item subtotal only — the delivery fee is always charged in full. | [optional] 
**items** | [**List&lt;DeliveryMenuItem&gt;**](DeliveryMenuItem.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


