//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/variance_row.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variance_report.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class VarianceReport {
  /// Returns a new [VarianceReport] instance.
  VarianceReport({

    required  this.netVarianceValue,

    required  this.rows,

    required  this.stocktakeId,

    required  this.totalOverageValue,

    required  this.totalShrinkageValue,

    required  this.unknownCostCount,

    required  this.varianceThresholdPct,
  });

      /// overage − shrinkage (net effect on inventory value).
  @JsonKey(
    
    name: r'net_variance_value',
    required: true,
    includeIfNull: false,
  )


  final int netVarianceValue;



  @JsonKey(
    
    name: r'rows',
    required: true,
    includeIfNull: false,
  )


  final List<VarianceRow> rows;



  @JsonKey(
    
    name: r'stocktake_id',
    required: true,
    includeIfNull: false,
  )


  final String stocktakeId;



      /// Piastres of overage (positive variances).
  @JsonKey(
    
    name: r'total_overage_value',
    required: true,
    includeIfNull: false,
  )


  final int totalOverageValue;



      /// Piastres lost to shrinkage (negative variances), as a positive number.
  @JsonKey(
    
    name: r'total_shrinkage_value',
    required: true,
    includeIfNull: false,
  )


  final int totalShrinkageValue;



      /// Count of counted rows whose cost was unknown (excluded from totals).
  @JsonKey(
    
    name: r'unknown_cost_count',
    required: true,
    includeIfNull: false,
  )


  final int unknownCostCount;



      /// Org tolerance used to compute `is_flagged`.
  @JsonKey(
    
    name: r'variance_threshold_pct',
    required: true,
    includeIfNull: false,
  )


  final double varianceThresholdPct;





    @override
    bool operator ==(Object other) => identical(this, other) || other is VarianceReport &&
      other.netVarianceValue == netVarianceValue &&
      other.rows == rows &&
      other.stocktakeId == stocktakeId &&
      other.totalOverageValue == totalOverageValue &&
      other.totalShrinkageValue == totalShrinkageValue &&
      other.unknownCostCount == unknownCostCount &&
      other.varianceThresholdPct == varianceThresholdPct;

    @override
    int get hashCode =>
        netVarianceValue.hashCode +
        rows.hashCode +
        stocktakeId.hashCode +
        totalOverageValue.hashCode +
        totalShrinkageValue.hashCode +
        unknownCostCount.hashCode +
        varianceThresholdPct.hashCode;

  factory VarianceReport.fromJson(Map<String, dynamic> json) => _$VarianceReportFromJson(json);

  Map<String, dynamic> toJson() => _$VarianceReportToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

