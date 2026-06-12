# sufrix_api.model.CreateUserRequest

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**branchIds** | **List&lt;String&gt;** | Branches to assign the new user to immediately. Branch managers can only assign to branches they themselves are assigned to. | [optional] 
**email** | **String** | Required for admins and managers; ignored for tellers. | [optional] 
**name** | **String** |  | 
**orgId** | **String** |  | 
**password** | **String** | Required when `role` is anything other than `teller`. Plain text; hashed server-side with bcrypt before storage. | [optional] 
**phone** | **String** |  | [optional] 
**pin** | **String** | Required when `role = teller`. 4–6 ASCII digits. | [optional] 
**role** | [**UserRole**](UserRole.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


