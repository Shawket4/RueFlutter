# sufrix_api.model.Shift

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**branchId** | **String** |  | 
**branchName** | **String** | Branch label — only populated by the shifts list (so the \"All branches\" view can show which branch each shift belongs to). Other shift endpoints leave it `null`. | [optional] 
**cashDiscrepancy** | **int** |  | [optional] 
**closedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**closedBy** | **String** |  | [optional] 
**closingCashDeclared** | **int** |  | [optional] 
**closingCashSystem** | **int** |  | [optional] 
**forceCloseReason** | **String** |  | [optional] 
**forceClosedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**forceClosedBy** | **String** |  | [optional] 
**id** | **String** |  | 
**notes** | **String** |  | [optional] 
**openedAt** | [**DateTime**](DateTime.md) |  | 
**openingCash** | **int** |  | 
**openingCashEditReason** | **String** |  | [optional] 
**openingCashOriginal** | **int** |  | [optional] 
**openingCashWasEdited** | **bool** |  | 
**status** | **String** |  | 
**tellerId** | **String** |  | 
**tellerName** | **String** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


