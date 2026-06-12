# sufrix_api.model.OrderItem

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**bundleId** | **String** |  | [optional] 
**bundleUnitPrice** | **int** |  | [optional] 
**costMissing** | **bool** | True when any cost component could not be resolved. | 
**deductionsSnapshot** | **Object** |  | 
**id** | **String** |  | 
**itemName** | **String** |  | 
**lineCost** | **int** | Full line COGS in piastres (recipe + addons + optionals + components). `null` ⟺ unknown. | [optional] 
**lineTotal** | **int** |  | 
**menuItemId** | **String** |  | [optional] 
**nameTranslations** | **Object** |  | 
**notes** | **String** |  | [optional] 
**orderId** | **String** |  | 
**quantity** | **int** |  | 
**sizeLabel** | **String** |  | [optional] 
**unitCost** | **int** | Recipe-only cost per unit in piastres (incl. swaps). `null` ⟺ unknown or bundle line. | [optional] 
**unitPrice** | **int** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


