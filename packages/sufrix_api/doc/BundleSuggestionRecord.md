# sufrix_api.model.BundleSuggestionRecord

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**association** | [**BundleAssociation**](BundleAssociation.md) |  | 
**bundleCm** | **int** |  | [optional] 
**bundleCost** | **int** | All cost-derived fields are `None` when any component lacks cost data. | [optional] 
**bundleDiscountPct** | **double** |  | 
**bundleItems** | [**List&lt;ItemKey&gt;**](ItemKey.md) |  | 
**bundleListPrice** | **int** |  | 
**bundleMarginPct** | **double** |  | [optional] 
**bundleSuggestedPrice** | **int** |  | 
**explanation** | **String** |  | 
**focusItem** | [**ItemKey**](ItemKey.md) |  | 
**forecast** | [**BundleForecast**](BundleForecast.md) |  | 
**guardClips** | [**List&lt;GuardClip&gt;**](GuardClip.md) |  | 
**missingCosts** | **bool** | True ⟺ at least one component is cost-missing. | 
**branchId** | **String** |  | 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**decision** | [**DecisionRecord**](DecisionRecord.md) |  | [optional] 
**id** | **String** |  | 
**promotedBundleId** | **String** |  | [optional] 
**runId** | **String** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


