# sufrix_api.model.Branch

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**address** | **String** |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**geoRadiusMeters** | **int** | Radius in meters within which this branch is considered a match. Defaults to 200. | [optional] 
**id** | **String** |  | 
**isActive** | **bool** |  | 
**latitude** | **double** | WGS-84 latitude for geofenced branch resolution. | [optional] 
**longitude** | **double** | WGS-84 longitude for geofenced branch resolution. | [optional] 
**name** | **String** |  | 
**orgId** | **String** |  | 
**orgLogoUrl** | **String** | Convenience field — populated from the parent org's `logo_url`. | [optional] 
**phone** | **String** |  | [optional] 
**printerBrand** | [**PrinterBrand**](PrinterBrand.md) |  | [optional] 
**printerIp** | **String** |  | [optional] 
**printerPort** | **int** |  | [optional] 
**timezone** | **String** | Effective IANA timezone name for this branch, resolved as `branch.timezone → org.timezone → Africa/Cairo`. Always present; clients should format all of this branch's timestamps in this zone. | 
**updatedAt** | [**DateTime**](DateTime.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


