# sufrix_api.model.OrgIngredient

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**category** | **String** |  | 
**costPerUnit** | **double** | Piastres per unit. `null` ⟺ never entered (unknown, NOT free) — recipes using this ingredient are cost-missing everywhere. | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**description** | **String** |  | [optional] 
**id** | **String** |  | 
**isActive** | **bool** |  | 
**name** | **String** |  | 
**orgId** | **String** |  | 
**supplierId** | **String** | Default supplier for reordering this ingredient; `null` = none set. | [optional] 
**supplierName** | **String** |  | [optional] 
**unit** | **String** |  | 
**updatedAt** | [**DateTime**](DateTime.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


