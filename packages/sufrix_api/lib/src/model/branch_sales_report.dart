//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/category_sales.dart';
import 'package:sufrix_api/src/model/item_sales.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_sales_report.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BranchSalesReport {
  /// Returns a new [BranchSalesReport] instance.
  BranchSalesReport({

    required  this.branchId,

    required  this.branchName,

    required  this.byCategory,

     this.from,

    required  this.revenueByMethod,

    required  this.subtotal,

     this.to,

    required  this.topItems,

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
    
    name: r'by_category',
    required: true,
    includeIfNull: false,
  )


  final List<CategorySales> byCategory;



  @JsonKey(
    
    name: r'from',
    required: false,
    includeIfNull: false,
  )


  final DateTime? from;



  @JsonKey(
    
    name: r'revenue_by_method',
    required: true,
    includeIfNull: true,
  )


  final Object? revenueByMethod;



  @JsonKey(
    
    name: r'subtotal',
    required: true,
    includeIfNull: false,
  )


  final int subtotal;



  @JsonKey(
    
    name: r'to',
    required: false,
    includeIfNull: false,
  )


  final DateTime? to;



  @JsonKey(
    
    name: r'top_items',
    required: true,
    includeIfNull: false,
  )


  final List<ItemSales> topItems;



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
    bool operator ==(Object other) => identical(this, other) || other is BranchSalesReport &&
      other.branchId == branchId &&
      other.branchName == branchName &&
      other.byCategory == byCategory &&
      other.from == from &&
      other.revenueByMethod == revenueByMethod &&
      other.subtotal == subtotal &&
      other.to == to &&
      other.topItems == topItems &&
      other.totalDiscount == totalDiscount &&
      other.totalOrders == totalOrders &&
      other.totalRevenue == totalRevenue &&
      other.totalTax == totalTax &&
      other.voidedOrders == voidedOrders;

    @override
    int get hashCode =>
        branchId.hashCode +
        branchName.hashCode +
        byCategory.hashCode +
        (from == null ? 0 : from.hashCode) +
        (revenueByMethod == null ? 0 : revenueByMethod.hashCode) +
        subtotal.hashCode +
        (to == null ? 0 : to.hashCode) +
        topItems.hashCode +
        totalDiscount.hashCode +
        totalOrders.hashCode +
        totalRevenue.hashCode +
        totalTax.hashCode +
        voidedOrders.hashCode;

  factory BranchSalesReport.fromJson(Map<String, dynamic> json) => _$BranchSalesReportFromJson(json);

  Map<String, dynamic> toJson() => _$BranchSalesReportToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

