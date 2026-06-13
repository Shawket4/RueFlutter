# sufrix_api.model.PriceSuggestion

## Load the model package
```dart
import 'package:sufrix_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**action** | [**Action**](Action.md) |  | 
**anchors** | [**PriceAnchors**](PriceAnchors.md) |  | 
**classification** | [**Classification**](Classification.md) |  | 
**cmPerUnit** | **double** |  | [optional] 
**confidence** | [**Confidence**](Confidence.md) |  | 
**costMissing** | **bool** | True when cost data is unavailable for this item. Mirrors `classification` mode, exposed flat for UI badge rendering. | 
**costReductionWhatifMargin** | **double** | Only computed for CM-tracked Plowhorses. | [optional] 
**currentPrice** | **int** |  | 
**effectivePrice** | **double** |  | 
**explanation** | **String** |  | 
**foodCostPct** | **double** |  | [optional] 
**guardClips** | [**List&lt;GuardClip&gt;**](GuardClip.md) |  | 
**itemName** | **String** |  | 
**key** | [**ItemKey**](ItemKey.md) |  | 
**marginPct** | **double** |  | [optional] 
**peerComparison** | [**PeerComparison**](PeerComparison.md) |  | [optional] 
**popularityShare** | **double** |  | 
**priceChangedInWindow** | **bool** |  | 
**suggestedDeltaAbs** | **int** |  | [optional] 
**suggestedDeltaPct** | **double** |  | [optional] 
**suggestedPrice** | **int** |  | [optional] 
**unitsSoldRaw** | **double** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


