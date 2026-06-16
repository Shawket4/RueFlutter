# sufrix_api.model.UpdateOrgRequest

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**currencyCode** | **String** |  | [optional] 
**isActive** | **bool** |  | [optional] 
**logoUrl** | **String** | `null` clears the logo; absent leaves it unchanged. To set a new logo, use `PUT /orgs/{id}/logo` (multipart) instead — JSON updates only accept the clear-to-null case here. | [optional] 
**name** | **String** |  | [optional] 
**receiptFooter** | **String** |  | [optional] 
**slug** | **String** |  | [optional] 
**taxRate** | **double** |  | [optional] 
**timezone** | **String** | IANA timezone name (e.g. `Africa/Cairo`). Validated against the PostgreSQL timezone database. Branches inherit this when their own timezone is unset. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


