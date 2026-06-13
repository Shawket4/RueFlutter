//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/price_rounding_rule.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'analysis_config.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AnalysisConfig {
  /// Returns a new [AnalysisConfig] instance.
  AnalysisConfig({

     this.analysisWindowDays = 30.0,

     this.bundleDiscountPctRange = const [0.1, 0.25],

     this.bundleMaxSize = 3,

     this.bundleTopKPartners = 5,

     this.bundleTopNPerFocus = 3,

     this.haloRepeatRate = 0.15,

     this.maxPriceChangePctPerCycle = 0.15,

     this.minCooccurrencesForBundle = 8.0,

     this.minGrossMarginPct = 0.55,

     this.minLiftForBundle = 1.2,

     this.minUnitsForClassification = 20.0,

     this.priceRoundingRule,

     this.promotionLiftPrior = 1.25,

     this.recencyHalfLifeDays = 14.0,

     this.revenueModeMaxRaisePct = 0.05,

     this.targetFoodCostPct = 0.3,
  });

  @JsonKey(
    defaultValue: 30.0,
    name: r'analysis_window_days',
    required: false,
    includeIfNull: false,
  )


  final double? analysisWindowDays;



  @JsonKey(
    defaultValue: [0.1, 0.25],
    name: r'bundle_discount_pct_range',
    required: false,
    includeIfNull: false,
  )


  final List<Object>? bundleDiscountPctRange;



          // minimum: 0
  @JsonKey(
    defaultValue: 3,
    name: r'bundle_max_size',
    required: false,
    includeIfNull: false,
  )


  final int? bundleMaxSize;



          // minimum: 0
  @JsonKey(
    defaultValue: 5,
    name: r'bundle_top_k_partners',
    required: false,
    includeIfNull: false,
  )


  final int? bundleTopKPartners;



          // minimum: 0
  @JsonKey(
    defaultValue: 3,
    name: r'bundle_top_n_per_focus',
    required: false,
    includeIfNull: false,
  )


  final int? bundleTopNPerFocus;



  @JsonKey(
    defaultValue: 0.15,
    name: r'halo_repeat_rate',
    required: false,
    includeIfNull: false,
  )


  final double? haloRepeatRate;



  @JsonKey(
    defaultValue: 0.15,
    name: r'max_price_change_pct_per_cycle',
    required: false,
    includeIfNull: false,
  )


  final double? maxPriceChangePctPerCycle;



  @JsonKey(
    defaultValue: 8.0,
    name: r'min_cooccurrences_for_bundle',
    required: false,
    includeIfNull: false,
  )


  final double? minCooccurrencesForBundle;



  @JsonKey(
    defaultValue: 0.55,
    name: r'min_gross_margin_pct',
    required: false,
    includeIfNull: false,
  )


  final double? minGrossMarginPct;



  @JsonKey(
    defaultValue: 1.2,
    name: r'min_lift_for_bundle',
    required: false,
    includeIfNull: false,
  )


  final double? minLiftForBundle;



  @JsonKey(
    defaultValue: 20.0,
    name: r'min_units_for_classification',
    required: false,
    includeIfNull: false,
  )


  final double? minUnitsForClassification;



  @JsonKey(
    
    name: r'price_rounding_rule',
    required: false,
    includeIfNull: false,
  unknownEnumValue: PriceRoundingRule.unknownDefaultOpenApi,
  )


  final PriceRoundingRule? priceRoundingRule;



  @JsonKey(
    defaultValue: 1.25,
    name: r'promotion_lift_prior',
    required: false,
    includeIfNull: false,
  )


  final double? promotionLiftPrior;



  @JsonKey(
    defaultValue: 14.0,
    name: r'recency_half_life_days',
    required: false,
    includeIfNull: false,
  )


  final double? recencyHalfLifeDays;



      /// Conservative max-raise cap for revenue-only items (no margin floor to guard against).
  @JsonKey(
    defaultValue: 0.05,
    name: r'revenue_mode_max_raise_pct',
    required: false,
    includeIfNull: false,
  )


  final double? revenueModeMaxRaisePct;



  @JsonKey(
    defaultValue: 0.3,
    name: r'target_food_cost_pct',
    required: false,
    includeIfNull: false,
  )


  final double? targetFoodCostPct;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AnalysisConfig &&
      other.analysisWindowDays == analysisWindowDays &&
      other.bundleDiscountPctRange == bundleDiscountPctRange &&
      other.bundleMaxSize == bundleMaxSize &&
      other.bundleTopKPartners == bundleTopKPartners &&
      other.bundleTopNPerFocus == bundleTopNPerFocus &&
      other.haloRepeatRate == haloRepeatRate &&
      other.maxPriceChangePctPerCycle == maxPriceChangePctPerCycle &&
      other.minCooccurrencesForBundle == minCooccurrencesForBundle &&
      other.minGrossMarginPct == minGrossMarginPct &&
      other.minLiftForBundle == minLiftForBundle &&
      other.minUnitsForClassification == minUnitsForClassification &&
      other.priceRoundingRule == priceRoundingRule &&
      other.promotionLiftPrior == promotionLiftPrior &&
      other.recencyHalfLifeDays == recencyHalfLifeDays &&
      other.revenueModeMaxRaisePct == revenueModeMaxRaisePct &&
      other.targetFoodCostPct == targetFoodCostPct;

    @override
    int get hashCode =>
        analysisWindowDays.hashCode +
        bundleDiscountPctRange.hashCode +
        bundleMaxSize.hashCode +
        bundleTopKPartners.hashCode +
        bundleTopNPerFocus.hashCode +
        haloRepeatRate.hashCode +
        maxPriceChangePctPerCycle.hashCode +
        minCooccurrencesForBundle.hashCode +
        minGrossMarginPct.hashCode +
        minLiftForBundle.hashCode +
        minUnitsForClassification.hashCode +
        priceRoundingRule.hashCode +
        promotionLiftPrior.hashCode +
        recencyHalfLifeDays.hashCode +
        revenueModeMaxRaisePct.hashCode +
        targetFoodCostPct.hashCode;

  factory AnalysisConfig.fromJson(Map<String, dynamic> json) => _$AnalysisConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AnalysisConfigToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

