# sufrix_api.model.BranchMenuOverride

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**branchId** | **String** |  | 
**isAvailable** | **bool** | False disables the item at this branch (excluded from the branch menu). | 
**menuItemId** | **String** |  | 
**priceOverride** | **int** | Branch price in piastres; null inherits the org catalog base_price. | [optional] 
**sizes** | [**List&lt;BranchSizeOverride&gt;**](BranchSizeOverride.md) | Per-size branch prices for this item (empty when none). Availability is item-level. | [optional] 
**updatedAt** | [**DateTime**](DateTime.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


