# sufrix_api.model.BranchInventoryItem

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**belowReorder** | **bool** |  | 
**branchId** | **String** |  | 
**costPerUnit** | **double** | Piastres per unit; `null` ⟺ cost never entered. | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**currentStock** | **double** |  | 
**description** | **String** |  | [optional] 
**id** | **String** |  | 
**ingredientName** | **String** |  | 
**lastCountedAt** | [**DateTime**](DateTime.md) | When this item was last reconciled by a finalized stock count; `null` = never counted. Drives the \"count due\" signal on the inventory home. | [optional] 
**orgIngredientId** | **String** |  | 
**reorderThreshold** | **double** |  | 
**unit** | **String** |  | 
**updatedAt** | [**DateTime**](DateTime.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


