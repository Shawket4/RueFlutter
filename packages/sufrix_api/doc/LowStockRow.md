# sufrix_api.model.LowStockRow

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**branchId** | **String** |  | 
**branchName** | **String** |  | 
**currentStock** | **double** |  | 
**deficit** | **double** | reorder_threshold − current_stock: how much to order to reach par. | 
**ingredientName** | **String** |  | 
**orgIngredientId** | **String** |  | 
**reorderThreshold** | **double** |  | 
**supplierId** | **String** | Default supplier for this ingredient (for one-click \"create PO\"); may be null. | [optional] 
**supplierName** | **String** |  | [optional] 
**unit** | **String** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


