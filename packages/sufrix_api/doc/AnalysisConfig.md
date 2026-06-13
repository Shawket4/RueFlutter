# sufrix_api.model.AnalysisConfig

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**analysisWindowDays** | **double** |  | [optional] [default to 30.0]
**bundleDiscountPctRange** | **List&lt;Object&gt;** |  | [optional] [default to [0.1, 0.25]]
**bundleMaxSize** | **int** |  | [optional] [default to 3]
**bundleTopKPartners** | **int** |  | [optional] [default to 5]
**bundleTopNPerFocus** | **int** |  | [optional] [default to 3]
**haloRepeatRate** | **double** |  | [optional] [default to 0.15]
**maxPriceChangePctPerCycle** | **double** |  | [optional] [default to 0.15]
**minCooccurrencesForBundle** | **double** |  | [optional] [default to 8.0]
**minGrossMarginPct** | **double** |  | [optional] [default to 0.55]
**minLiftForBundle** | **double** |  | [optional] [default to 1.2]
**minUnitsForClassification** | **double** |  | [optional] [default to 20.0]
**priceRoundingRule** | [**PriceRoundingRule**](PriceRoundingRule.md) |  | [optional] 
**promotionLiftPrior** | **double** |  | [optional] [default to 1.25]
**recencyHalfLifeDays** | **double** |  | [optional] [default to 14.0]
**revenueModeMaxRaisePct** | **double** | Conservative max-raise cap for revenue-only items (no margin floor to guard against). | [optional] [default to 0.05]
**targetFoodCostPct** | **double** |  | [optional] [default to 0.3]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


