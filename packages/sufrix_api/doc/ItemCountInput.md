# sufrix_api.model.ItemCountInput

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**countedQty** | **double** |  | 
**note** | **String** |  | [optional] 
**orgIngredientId** | **String** |  | 
**varianceReason** | **String** | Why the count differs from expected. One of: theft | spoilage | breakage | miscount | supplier_short | transfer_error | other. Required at finalize for rows whose difference exceeds the org's variance threshold. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


