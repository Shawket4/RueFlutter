# sufrix_api.model.CreateBranchRequest

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**address** | **String** |  | [optional] 
**geoRadiusMeters** | **int** | Geofence radius in meters. Defaults to 200. | [optional] 
**latitude** | **double** |  | [optional] 
**longitude** | **double** |  | [optional] 
**name** | **String** |  | 
**orgId** | **String** |  | 
**phone** | **String** |  | [optional] 
**printerBrand** | [**PrinterBrand**](PrinterBrand.md) |  | [optional] 
**printerIp** | **String** |  | [optional] 
**printerPort** | **int** | TCP port for the receipt printer. Defaults to `9100` if absent. | [optional] 
**timezone** | **String** | IANA timezone name. If absent, the branch inherits the org's timezone. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


