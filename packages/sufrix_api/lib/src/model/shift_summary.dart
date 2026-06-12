//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shift_summary.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ShiftSummary {
  /// Returns a new [ShiftSummary] instance.
  ShiftSummary({

    required  this.branchId,

    required  this.branchName,

     this.cashDiscrepancy,

     this.closedAt,

     this.closingCashDeclared,

     this.closingCashSystem,

    required  this.openedAt,

    required  this.openingCash,

    required  this.revenueByMethod,

    required  this.shiftId,

    required  this.status,

    required  this.tellerId,

    required  this.tellerName,

    required  this.totalDiscount,

    required  this.totalOrders,

    required  this.totalRevenue,

    required  this.totalTax,

    required  this.voidedOrders,
  });

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
    
    name: r'cash_discrepancy',
    required: false,
    includeIfNull: false,
  )


  final int? cashDiscrepancy;



  @JsonKey(
    
    name: r'closed_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? closedAt;



  @JsonKey(
    
    name: r'closing_cash_declared',
    required: false,
    includeIfNull: false,
  )


  final int? closingCashDeclared;



  @JsonKey(
    
    name: r'closing_cash_system',
    required: false,
    includeIfNull: false,
  )


  final int? closingCashSystem;



  @JsonKey(
    
    name: r'opened_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime openedAt;



  @JsonKey(
    
    name: r'opening_cash',
    required: true,
    includeIfNull: false,
  )


  final int openingCash;



  @JsonKey(
    
    name: r'revenue_by_method',
    required: true,
    includeIfNull: true,
  )


  final Object? revenueByMethod;



  @JsonKey(
    
    name: r'shift_id',
    required: true,
    includeIfNull: false,
  )


  final String shiftId;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final String status;



  @JsonKey(
    
    name: r'teller_id',
    required: true,
    includeIfNull: false,
  )


  final String tellerId;



  @JsonKey(
    
    name: r'teller_name',
    required: true,
    includeIfNull: false,
  )


  final String tellerName;



  @JsonKey(
    
    name: r'total_discount',
    required: true,
    includeIfNull: false,
  )


  final int totalDiscount;



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
    
    name: r'total_tax',
    required: true,
    includeIfNull: false,
  )


  final int totalTax;



  @JsonKey(
    
    name: r'voided_orders',
    required: true,
    includeIfNull: false,
  )


  final int voidedOrders;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ShiftSummary &&
      other.branchId == branchId &&
      other.branchName == branchName &&
      other.cashDiscrepancy == cashDiscrepancy &&
      other.closedAt == closedAt &&
      other.closingCashDeclared == closingCashDeclared &&
      other.closingCashSystem == closingCashSystem &&
      other.openedAt == openedAt &&
      other.openingCash == openingCash &&
      other.revenueByMethod == revenueByMethod &&
      other.shiftId == shiftId &&
      other.status == status &&
      other.tellerId == tellerId &&
      other.tellerName == tellerName &&
      other.totalDiscount == totalDiscount &&
      other.totalOrders == totalOrders &&
      other.totalRevenue == totalRevenue &&
      other.totalTax == totalTax &&
      other.voidedOrders == voidedOrders;

    @override
    int get hashCode =>
        branchId.hashCode +
        branchName.hashCode +
        (cashDiscrepancy == null ? 0 : cashDiscrepancy.hashCode) +
        (closedAt == null ? 0 : closedAt.hashCode) +
        (closingCashDeclared == null ? 0 : closingCashDeclared.hashCode) +
        (closingCashSystem == null ? 0 : closingCashSystem.hashCode) +
        openedAt.hashCode +
        openingCash.hashCode +
        (revenueByMethod == null ? 0 : revenueByMethod.hashCode) +
        shiftId.hashCode +
        status.hashCode +
        tellerId.hashCode +
        tellerName.hashCode +
        totalDiscount.hashCode +
        totalOrders.hashCode +
        totalRevenue.hashCode +
        totalTax.hashCode +
        voidedOrders.hashCode;

  factory ShiftSummary.fromJson(Map<String, dynamic> json) => _$ShiftSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftSummaryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

