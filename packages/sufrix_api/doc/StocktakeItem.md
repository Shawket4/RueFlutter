# sufrix_api.model.StocktakeItem

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**branchInventoryId** | **String** |  | [optional] 
**countedBy** | **String** |  | [optional] 
**countedQty** | **double** |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**expectedQty** | **double** |  | 
**id** | **String** |  | 
**ingredientName** | **String** |  | 
**note** | **String** |  | [optional] 
**orgIngredientId** | **String** |  | 
**stocktakeId** | **String** |  | 
**unit** | **String** |  | 
**unitCost** | **int** | Piastres per unit snapshot; `null` ⟺ unknown. | [optional] 
**variance** | **double** |  | [optional] 
**varianceReason** | **String** | theft | spoilage | breakage | miscount | supplier_short | transfer_error | other. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


