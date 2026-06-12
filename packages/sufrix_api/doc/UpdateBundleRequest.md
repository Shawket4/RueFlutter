# sufrix_api.model.UpdateBundleRequest

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**availableFromDate** | [**DateTime**](DateTime.md) |  | [optional] 
**availableFromTime** | **String** | `null`  → clear the field (no start time restriction) omitted → keep the existing value a value → set to that time | [optional] 
**availableUntilDate** | [**DateTime**](DateTime.md) |  | [optional] 
**availableUntilTime** | **String** |  | [optional] 
**branchIds** | **List&lt;String&gt;** |  | [optional] 
**components** | [**List&lt;CreateBundleComponentInput&gt;**](CreateBundleComponentInput.md) |  | [optional] 
**description** | **String** |  | [optional] 
**descriptionTranslations** | **Object** |  | [optional] 
**displayOrder** | **int** |  | [optional] 
**imageUrl** | **String** |  | [optional] 
**name** | **String** |  | [optional] 
**nameTranslations** | **Object** |  | [optional] 
**price** | **int** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


