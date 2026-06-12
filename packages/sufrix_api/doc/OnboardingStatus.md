# sufrix_api.model.OnboardingStatus

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**canComplete** | **bool** | True when every `required` step is done (the Finish button enabler). | 
**completed** | **bool** | Persisted terminal flag — the dashboard routes into the wizard when this is false. | 
**completedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**orgId** | **String** |  | 
**recipeCoverage** | **double** | Recipe coverage across active menu items (0..1) — drives the cost engine; surfaced separately because it's a percentage, not a bool. | 
**steps** | [**List&lt;OnboardingStep&gt;**](OnboardingStep.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


