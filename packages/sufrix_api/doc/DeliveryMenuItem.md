# sufrix_api.model.DeliveryMenuItem

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**categoryId** | **String** |  | [optional] 
**defaultMilkAddonId** | **String** | The item's base/default milk: the `milk_type` addon whose ingredient matches the item recipe's milk ingredient. The online customizer pre-selects it (mirrors the POS default-milk selection). `None` when the item has no milk in its recipe or no matching milk addon exists. | [optional] 
**description** | **String** |  | [optional] 
**id** | **String** |  | 
**imageUrl** | **String** |  | [optional] 
**name** | **String** |  | 
**nameTranslations** | **Object** |  | 
**optionals** | [**List&lt;DeliveryOptionalField&gt;**](DeliveryOptionalField.md) |  | 
**price** | **int** |  | 
**sizes** | [**List&lt;DeliveryMenuSize&gt;**](DeliveryMenuSize.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


