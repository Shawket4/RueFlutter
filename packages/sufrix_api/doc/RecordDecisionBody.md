# sufrix_api.model.RecordDecisionBody

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**branchId** | **String** |  | 
**decision** | **String** | accepted | rejected | ignored — kept as a string so invalid values yield a 400 instead of a deserialization error. | 
**notes** | **String** |  | [optional] 
**suggestionId** | **String** |  | 
**suggestionKind** | [**SuggestionKind**](SuggestionKind.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


