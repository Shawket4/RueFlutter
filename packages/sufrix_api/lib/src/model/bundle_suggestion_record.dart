//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/decision_record.dart';
import 'package:sufrix_api/src/model/item_key.dart';
import 'package:sufrix_api/src/model/bundle_association.dart';
import 'package:sufrix_api/src/model/bundle_forecast.dart';
import 'package:sufrix_api/src/model/guard_clip.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bundle_suggestion_record.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BundleSuggestionRecord {
  /// Returns a new [BundleSuggestionRecord] instance.
  BundleSuggestionRecord({

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

    required  this.branchId,

    required  this.createdAt,

     this.decision,

    required  this.id,

     this.promotedBundleId,

    required  this.runId,
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



  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'decision',
    required: false,
    includeIfNull: false,
  )


  final DecisionRecord? decision;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'promoted_bundle_id',
    required: false,
    includeIfNull: false,
  )


  final String? promotedBundleId;



  @JsonKey(
    
    name: r'run_id',
    required: true,
    includeIfNull: false,
  )


  final String runId;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BundleSuggestionRecord &&
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
      other.missingCosts == missingCosts &&
      other.branchId == branchId &&
      other.createdAt == createdAt &&
      other.decision == decision &&
      other.id == id &&
      other.promotedBundleId == promotedBundleId &&
      other.runId == runId;

    @override
    int get hashCode =>
        association.hashCode +
        bundleCm.hashCode +
        bundleCost.hashCode +
        bundleDiscountPct.hashCode +
        bundleItems.hashCode +
        bundleListPrice.hashCode +
        bundleMarginPct.hashCode +
        bundleSuggestedPrice.hashCode +
        explanation.hashCode +
        focusItem.hashCode +
        forecast.hashCode +
        guardClips.hashCode +
        missingCosts.hashCode +
        branchId.hashCode +
        createdAt.hashCode +
        (decision == null ? 0 : decision.hashCode) +
        id.hashCode +
        (promotedBundleId == null ? 0 : promotedBundleId.hashCode) +
        runId.hashCode;

  factory BundleSuggestionRecord.fromJson(Map<String, dynamic> json) => _$BundleSuggestionRecordFromJson(json);

  Map<String, dynamic> toJson() => _$BundleSuggestionRecordToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

