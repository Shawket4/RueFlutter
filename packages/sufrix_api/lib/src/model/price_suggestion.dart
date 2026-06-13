//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/action.dart';
import 'package:sufrix_api/src/model/confidence.dart';
import 'package:sufrix_api/src/model/item_key.dart';
import 'package:sufrix_api/src/model/peer_comparison.dart';
import 'package:sufrix_api/src/model/classification.dart';
import 'package:sufrix_api/src/model/guard_clip.dart';
import 'package:sufrix_api/src/model/price_anchors.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price_suggestion.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PriceSuggestion {
  /// Returns a new [PriceSuggestion] instance.
  PriceSuggestion({

    required  this.action,

    required  this.anchors,

    required  this.classification,

     this.cmPerUnit,

    required  this.confidence,

    required  this.costMissing,

     this.costReductionWhatifMargin,

    required  this.currentPrice,

    required  this.effectivePrice,

    required  this.explanation,

     this.foodCostPct,

    required  this.guardClips,

    required  this.itemName,

    required  this.key,

     this.marginPct,

     this.peerComparison,

    required  this.popularityShare,

    required  this.priceChangedInWindow,

     this.suggestedDeltaAbs,

     this.suggestedDeltaPct,

     this.suggestedPrice,

    required  this.unitsSoldRaw,
  });

  @JsonKey(
    
    name: r'action',
    required: true,
    includeIfNull: false,
  unknownEnumValue: Action.unknownDefaultOpenApi,
  )


  final Action action;



  @JsonKey(
    
    name: r'anchors',
    required: true,
    includeIfNull: false,
  )


  final PriceAnchors anchors;



  @JsonKey(
    
    name: r'classification',
    required: true,
    includeIfNull: false,
  )


  final Classification classification;



  @JsonKey(
    
    name: r'cm_per_unit',
    required: false,
    includeIfNull: false,
  )


  final double? cmPerUnit;



  @JsonKey(
    
    name: r'confidence',
    required: true,
    includeIfNull: false,
  unknownEnumValue: Confidence.unknownDefaultOpenApi,
  )


  final Confidence confidence;



      /// True when cost data is unavailable for this item. Mirrors `classification` mode, exposed flat for UI badge rendering.
  @JsonKey(
    
    name: r'cost_missing',
    required: true,
    includeIfNull: false,
  )


  final bool costMissing;



      /// Only computed for CM-tracked Plowhorses.
  @JsonKey(
    
    name: r'cost_reduction_whatif_margin',
    required: false,
    includeIfNull: false,
  )


  final double? costReductionWhatifMargin;



  @JsonKey(
    
    name: r'current_price',
    required: true,
    includeIfNull: false,
  )


  final int currentPrice;



  @JsonKey(
    
    name: r'effective_price',
    required: true,
    includeIfNull: false,
  )


  final double effectivePrice;



  @JsonKey(
    
    name: r'explanation',
    required: true,
    includeIfNull: false,
  )


  final String explanation;



  @JsonKey(
    
    name: r'food_cost_pct',
    required: false,
    includeIfNull: false,
  )


  final double? foodCostPct;



  @JsonKey(
    
    name: r'guard_clips',
    required: true,
    includeIfNull: false,
  )


  final List<GuardClip> guardClips;



  @JsonKey(
    
    name: r'item_name',
    required: true,
    includeIfNull: false,
  )


  final String itemName;



  @JsonKey(
    
    name: r'key',
    required: true,
    includeIfNull: false,
  )


  final ItemKey key;



  @JsonKey(
    
    name: r'margin_pct',
    required: false,
    includeIfNull: false,
  )


  final double? marginPct;



  @JsonKey(
    
    name: r'peer_comparison',
    required: false,
    includeIfNull: false,
  )


  final PeerComparison? peerComparison;



  @JsonKey(
    
    name: r'popularity_share',
    required: true,
    includeIfNull: false,
  )


  final double popularityShare;



  @JsonKey(
    
    name: r'price_changed_in_window',
    required: true,
    includeIfNull: false,
  )


  final bool priceChangedInWindow;



  @JsonKey(
    
    name: r'suggested_delta_abs',
    required: false,
    includeIfNull: false,
  )


  final int? suggestedDeltaAbs;



  @JsonKey(
    
    name: r'suggested_delta_pct',
    required: false,
    includeIfNull: false,
  )


  final double? suggestedDeltaPct;



  @JsonKey(
    
    name: r'suggested_price',
    required: false,
    includeIfNull: false,
  )


  final int? suggestedPrice;



  @JsonKey(
    
    name: r'units_sold_raw',
    required: true,
    includeIfNull: false,
  )


  final double unitsSoldRaw;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PriceSuggestion &&
      other.action == action &&
      other.anchors == anchors &&
      other.classification == classification &&
      other.cmPerUnit == cmPerUnit &&
      other.confidence == confidence &&
      other.costMissing == costMissing &&
      other.costReductionWhatifMargin == costReductionWhatifMargin &&
      other.currentPrice == currentPrice &&
      other.effectivePrice == effectivePrice &&
      other.explanation == explanation &&
      other.foodCostPct == foodCostPct &&
      other.guardClips == guardClips &&
      other.itemName == itemName &&
      other.key == key &&
      other.marginPct == marginPct &&
      other.peerComparison == peerComparison &&
      other.popularityShare == popularityShare &&
      other.priceChangedInWindow == priceChangedInWindow &&
      other.suggestedDeltaAbs == suggestedDeltaAbs &&
      other.suggestedDeltaPct == suggestedDeltaPct &&
      other.suggestedPrice == suggestedPrice &&
      other.unitsSoldRaw == unitsSoldRaw;

    @override
    int get hashCode =>
        action.hashCode +
        anchors.hashCode +
        classification.hashCode +
        (cmPerUnit == null ? 0 : cmPerUnit.hashCode) +
        confidence.hashCode +
        costMissing.hashCode +
        (costReductionWhatifMargin == null ? 0 : costReductionWhatifMargin.hashCode) +
        currentPrice.hashCode +
        effectivePrice.hashCode +
        explanation.hashCode +
        (foodCostPct == null ? 0 : foodCostPct.hashCode) +
        guardClips.hashCode +
        itemName.hashCode +
        key.hashCode +
        (marginPct == null ? 0 : marginPct.hashCode) +
        (peerComparison == null ? 0 : peerComparison.hashCode) +
        popularityShare.hashCode +
        priceChangedInWindow.hashCode +
        (suggestedDeltaAbs == null ? 0 : suggestedDeltaAbs.hashCode) +
        (suggestedDeltaPct == null ? 0 : suggestedDeltaPct.hashCode) +
        (suggestedPrice == null ? 0 : suggestedPrice.hashCode) +
        unitsSoldRaw.hashCode;

  factory PriceSuggestion.fromJson(Map<String, dynamic> json) => _$PriceSuggestionFromJson(json);

  Map<String, dynamic> toJson() => _$PriceSuggestionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

