# sufrix_api.model.BranchMenuOverrideInput

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**branchId** | **String** |  | 
**isAvailable** | **bool** |  | [optional] 
**menuItemId** | **String** |  | 
**priceOverride** | **int** | Branch price in piastres; null inherits the org catalog base_price. | [optional] 
**sizes** | [**List&lt;BranchSizeOverrideInput&gt;**](BranchSizeOverrideInput.md) | Per-size branch prices. `null`/omitted → leave existing size overrides untouched; a list → REPLACE the item's size overrides with exactly that set (empty clears them). | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


