//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/calibration_point.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calibration_summary.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CalibrationSummary {
  /// Returns a new [CalibrationSummary] instance.
  CalibrationSummary({

    required  this.branchId,

     this.cmInRangePct,

    required  this.pointsCm,

    required  this.pointsRevenue,

     this.revenueInRangePct,

     this.since,
  });

  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



      /// Fraction of accepted CM suggestions whose realized price landed within ±2% of the suggested price. `None` below 10 samples.
  @JsonKey(
    
    name: r'cm_in_range_pct',
    required: false,
    includeIfNull: false,
  )


  final double? cmInRangePct;



  @JsonKey(
    
    name: r'points_cm',
    required: true,
    includeIfNull: false,
  )


  final List<CalibrationPoint> pointsCm;



  @JsonKey(
    
    name: r'points_revenue',
    required: true,
    includeIfNull: false,
  )


  final List<CalibrationPoint> pointsRevenue;



  @JsonKey(
    
    name: r'revenue_in_range_pct',
    required: false,
    includeIfNull: false,
  )


  final double? revenueInRangePct;



  @JsonKey(
    
    name: r'since',
    required: false,
    includeIfNull: false,
  )


  final DateTime? since;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CalibrationSummary &&
      other.branchId == branchId &&
      other.cmInRangePct == cmInRangePct &&
      other.pointsCm == pointsCm &&
      other.pointsRevenue == pointsRevenue &&
      other.revenueInRangePct == revenueInRangePct &&
      other.since == since;

    @override
    int get hashCode =>
        branchId.hashCode +
        (cmInRangePct == null ? 0 : cmInRangePct.hashCode) +
        pointsCm.hashCode +
        pointsRevenue.hashCode +
        (revenueInRangePct == null ? 0 : revenueInRangePct.hashCode) +
        (since == null ? 0 : since.hashCode);

  factory CalibrationSummary.fromJson(Map<String, dynamic> json) => _$CalibrationSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$CalibrationSummaryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

