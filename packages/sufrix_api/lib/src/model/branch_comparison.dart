//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_comparison.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BranchComparison {
  /// Returns a new [BranchComparison] instance.
  BranchComparison({

    required  this.avgOrderValue,

    required  this.branchId,

    required  this.branchName,

    required  this.revenueByMethod,

    required  this.totalOrders,

    required  this.totalRevenue,

    required  this.voidRatePct,

    required  this.voidedOrders,
  });

  @JsonKey(
    
    name: r'avg_order_value',
    required: true,
    includeIfNull: false,
  )


  final int avgOrderValue;



  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



  @JsonKey(
    
    name: r'branch_name',
    required: true,
    includeIfNull: false,
  )


  final String branchName;



  @JsonKey(
    
    name: r'revenue_by_method',
    required: true,
    includeIfNull: true,
  )


  final Object? revenueByMethod;



  @JsonKey(
    
    name: r'total_orders',
    required: true,
    includeIfNull: false,
  )


  final int totalOrders;



  @JsonKey(
    
    name: r'total_revenue',
    required: true,
    includeIfNull: false,
  )


  final int totalRevenue;



  @JsonKey(
    
    name: r'void_rate_pct',
    required: true,
    includeIfNull: false,
  )


  final double voidRatePct;



  @JsonKey(
    
    name: r'voided_orders',
    required: true,
    includeIfNull: false,
  )


  final int voidedOrders;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BranchComparison &&
      other.avgOrderValue == avgOrderValue &&
      other.branchId == branchId &&
      other.branchName == branchName &&
      other.revenueByMethod == revenueByMethod &&
      other.totalOrders == totalOrders &&
      other.totalRevenue == totalRevenue &&
      other.voidRatePct == voidRatePct &&
      other.voidedOrders == voidedOrders;

    @override
    int get hashCode =>
        avgOrderValue.hashCode +
        branchId.hashCode +
        branchName.hashCode +
        (revenueByMethod == null ? 0 : revenueByMethod.hashCode) +
        totalOrders.hashCode +
        totalRevenue.hashCode +
        voidRatePct.hashCode +
        voidedOrders.hashCode;

  factory BranchComparison.fromJson(Map<String, dynamic> json) => _$BranchComparisonFromJson(json);

  Map<String, dynamic> toJson() => _$BranchComparisonToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

