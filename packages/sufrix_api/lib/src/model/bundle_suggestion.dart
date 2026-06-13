//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/item_key.dart';
import 'package:sufrix_api/src/model/bundle_association.dart';
import 'package:sufrix_api/src/model/bundle_forecast.dart';
import 'package:sufrix_api/src/model/guard_clip.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bundle_suggestion.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BundleSuggestion {
  /// Returns a new [BundleSuggestion] instance.
  BundleSuggestion({

    required  this.association,

     this.bundleCm,

     this.bundleCost,

    required  this.bundleDiscountPct,

    required  this.bundleItems,

    required  this.bundleListPrice,

     this.bundleMarginPct,

    required  this.bundleSuggestedPrice,

    required  this.explanation,

    required  this.focusItem,

    required  this.forecast,

    required  this.guardClips,

    required  this.missingCosts,
  });

  @JsonKey(
    
    name: r'association',
    required: true,
    includeIfNull: false,
  )


  final BundleAssociation association;



  @JsonKey(
    
    name: r'bundle_cm',
    required: false,
    includeIfNull: false,
  )


  final int? bundleCm;



      /// All cost-derived fields are `None` when any component lacks cost data.
  @JsonKey(
    
    name: r'bundle_cost',
    required: false,
    includeIfNull: false,
  )


  final int? bundleCost;



  @JsonKey(
    
    name: r'bundle_discount_pct',
    required: true,
    includeIfNull: false,
  )


  final double bundleDiscountPct;



  @JsonKey(
    
    name: r'bundle_items',
    required: true,
    includeIfNull: false,
  )


  final List<ItemKey> bundleItems;



  @JsonKey(
    
    name: r'bundle_list_price',
    required: true,
    includeIfNull: false,
  )


  final int bundleListPrice;



  @JsonKey(
    
    name: r'bundle_margin_pct',
    required: false,
    includeIfNull: false,
  )


  final double? bundleMarginPct;



  @JsonKey(
    
    name: r'bundle_suggested_price',
    required: true,
    includeIfNull: false,
  )


  final int bundleSuggestedPrice;



  @JsonKey(
    
    name: r'explanation',
    required: true,
    includeIfNull: false,
  )


  final String explanation;



  @JsonKey(
    
    name: r'focus_item',
    required: true,
    includeIfNull: false,
  )


  final ItemKey focusItem;



  @JsonKey(
    
    name: r'forecast',
    required: true,
    includeIfNull: false,
  )


  final BundleForecast forecast;



  @JsonKey(
    
    name: r'guard_clips',
    required: true,
    includeIfNull: false,
  )


  final List<GuardClip> guardClips;



      /// True ⟺ at least one component is cost-missing.
  @JsonKey(
    
    name: r'missing_costs',
    required: true,
    includeIfNull: false,
  )


  final bool missingCosts;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BundleSuggestion &&
      other.association == association &&
      other.bundleCm == bundleCm &&
      other.bundleCost == bundleCost &&
      other.bundleDiscountPct == bundleDiscountPct &&
      other.bundleItems == bundleItems &&
      other.bundleListPrice == bundleListPrice &&
      other.bundleMarginPct == bundleMarginPct &&
      other.bundleSuggestedPrice == bundleSuggestedPrice &&
      other.explanation == explanation &&
      other.focusItem == focusItem &&
      other.forecast == forecast &&
      other.guardClips == guardClips &&
      other.missingCosts == missingCosts;

    @override
    int get hashCode =>
        association.hashCode +
        (bundleCm == null ? 0 : bundleCm.hashCode) +
        (bundleCost == null ? 0 : bundleCost.hashCode) +
        bundleDiscountPct.hashCode +
        bundleItems.hashCode +
        bundleListPrice.hashCode +
        (bundleMarginPct == null ? 0 : bundleMarginPct.hashCode) +
        bundleSuggestedPrice.hashCode +
        explanation.hashCode +
        focusItem.hashCode +
        forecast.hashCode +
        guardClips.hashCode +
        missingCosts.hashCode;

  factory BundleSuggestion.fromJson(Map<String, dynamic> json) => _$BundleSuggestionFromJson(json);

  Map<String, dynamic> toJson() => _$BundleSuggestionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

