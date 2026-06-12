# sufrix_api.model.SkuCost

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**categoryId** | **String** |  | [optional] 
**cost** | **int** | Recipe cost rollup in piastres. `null` ⟺ unknown (no recipe, or any ingredient unlinked / missing a cost). | [optional] 
**costMissing** | **bool** |  | 
**foodCostPct** | **double** | `cost / price` when both known and price > 0. | [optional] 
**itemName** | **String** |  | 
**marginPct** | **double** | `(price - cost) / price` when both known and price > 0. | [optional] 
**menuItemId** | **String** |  | 
**price** | **int** | Current price in piastres for this SKU. | 
**sizeLabel** | **String** | `\"one_size\"` when the item has no sizes. | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


