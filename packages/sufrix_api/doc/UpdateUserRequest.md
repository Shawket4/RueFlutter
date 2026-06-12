# sufrix_api.model.UpdateUserRequest

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**email** | **String** |  | [optional] 
**isActive** | **bool** |  | [optional] 
**name** | **String** |  | [optional] 
**password** | **String** | Plain-text new password. Server-side bcrypt-hashed. | [optional] 
**phone** | **String** |  | [optional] 
**pin** | **String** |  | [optional] 
**role** | [**UserRole**](UserRole.md) | Only org-admins and above can change roles. Promoting to `super_admin` requires the caller to be a super-admin. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


