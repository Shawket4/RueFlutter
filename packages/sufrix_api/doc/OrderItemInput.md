# sufrix_api.model.OrderItemInput

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**addons** | [**List&lt;AddonInput&gt;**](AddonInput.md) |  | 
**bundleComponents** | [**List&lt;BundleComponentInput&gt;**](BundleComponentInput.md) |  | [optional] 
**bundleId** | **String** |  | [optional] 
**menuItemId** | **String** |  | [optional] 
**notes** | **String** |  | [optional] 
**optionalFieldIds** | **List&lt;String&gt;** |  | 
**quantity** | **int** |  | 
**sizeLabel** | **String** |  | [optional] 
**unitPrice** | **int** | Charged unit price (piastres) the POS applied for this item/bundle line. When present it is RECORDED as the line's unit_price; absent → the server's expected (catalog + branch override) price is used. Recording what the customer was actually charged keeps the DB equal to the printed receipt even when the POS's synced menu/override prices are stale or it was offline at sale time. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


