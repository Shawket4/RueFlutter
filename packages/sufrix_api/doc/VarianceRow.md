# sufrix_api.model.VarianceRow

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**countedQty** | **double** |  | [optional] 
**expectedQty** | **double** |  | 
**ingredientName** | **String** |  | 
**isFlagged** | **bool** | True when |difference| exceeds the org threshold (or appears/vanishes from zero). | 
**orgIngredientId** | **String** |  | 
**unit** | **String** |  | 
**unitCost** | **int** |  | [optional] 
**variance** | **double** |  | [optional] 
**varianceReason** | **String** | theft | spoilage | breakage | miscount | supplier_short | transfer_error | other. | [optional] 
**varianceValue** | **int** | variance × unit_cost in piastres; `null` when cost unknown. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


