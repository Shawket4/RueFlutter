//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/menu_engineering_row.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu_engineering_report.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MenuEngineeringReport {
  /// Returns a new [MenuEngineeringReport] instance.
  MenuEngineeringReport({

    required  this.branchId,

     this.from,

    required  this.rows,

    required  this.rowsCostMissing,

     this.to,

    required  this.totalCost,

    required  this.totalProfit,

    required  this.totalSales,
  });

  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



  @JsonKey(
    
    name: r'from',
    required: false,
    includeIfNull: false,
  )


  final DateTime? from;



  @JsonKey(
    
    name: r'rows',
    required: true,
    includeIfNull: false,
  )


  final List<MenuEngineeringRow> rows;



      /// Rows excluded from profit math because cost was unresolvable.
  @JsonKey(
    
    name: r'rows_cost_missing',
    required: true,
    includeIfNull: false,
  )


  final int rowsCostMissing;



  @JsonKey(
    
    name: r'to',
    required: false,
    includeIfNull: false,
  )


  final DateTime? to;



  @JsonKey(
    
    name: r'total_cost',
    required: true,
    includeIfNull: false,
  )


  final int totalCost;



  @JsonKey(
    
    name: r'total_profit',
    required: true,
    includeIfNull: false,
  )


  final int totalProfit;



      /// Totals over cost-tracked rows.
  @JsonKey(
    
    name: r'total_sales',
    required: true,
    includeIfNull: false,
  )


  final int totalSales;





    @override
    bool operator ==(Object other) => identical(this, other) || other is MenuEngineeringReport &&
      other.branchId == branchId &&
      other.from == from &&
      other.rows == rows &&
      other.rowsCostMissing == rowsCostMissing &&
      other.to == to &&
      other.totalCost == totalCost &&
      other.totalProfit == totalProfit &&
      other.totalSales == totalSales;

    @override
    int get hashCode =>
        branchId.hashCode +
        (from == null ? 0 : from.hashCode) +
        rows.hashCode +
        rowsCostMissing.hashCode +
        (to == null ? 0 : to.hashCode) +
        totalCost.hashCode +
        totalProfit.hashCode +
        totalSales.hashCode;

  factory MenuEngineeringReport.fromJson(Map<String, dynamic> json) => _$MenuEngineeringReportFromJson(json);

  Map<String, dynamic> toJson() => _$MenuEngineeringReportToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

