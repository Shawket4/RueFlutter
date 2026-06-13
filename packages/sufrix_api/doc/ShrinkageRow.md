# sufrix_api.model.ShrinkageRow

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**ingredientName** | **String** |  | 
**orgIngredientId** | **String** |  | 
**reason** | **String** | The variance reason captured at finalize, or `unexplained` when none. | 
**shrinkageQty** | **double** | Quantity lost (positive number) from negative stock-count differences. | 
**shrinkageValue** | **int** | Valued shrinkage in piastres; `null` when any contributing cost unknown. | [optional] 
**unit** | **String** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


