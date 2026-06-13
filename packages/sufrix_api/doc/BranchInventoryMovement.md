# sufrix_api.model.BranchInventoryMovement

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**balanceAfter** | **double** |  | [optional] 
**belowZero** | **bool** |  | 
**branchId** | **String** |  | 
**branchInventoryId** | **String** |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**createdBy** | **String** |  | [optional] 
**createdByName** | **String** |  | [optional] 
**id** | **String** |  | 
**ingredientName** | **String** |  | 
**movementType** | **String** | inventory_movement_type: sale | void_restock | adjustment_add | adjustment_remove | waste | transfer_out | transfer_in | purchase_in | stock_count | 
**note** | **String** |  | [optional] 
**orgIngredientId** | **String** |  | 
**quantity** | **double** | Signed delta applied to stock (consumption negative, replenishment positive). | 
**reason** | **String** |  | [optional] 
**sourceId** | **String** |  | [optional] 
**sourceType** | **String** |  | [optional] 
**unit** | **String** |  | 
**unitCost** | **int** | Piastres per unit at movement time; `null` ⟺ unknown. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


