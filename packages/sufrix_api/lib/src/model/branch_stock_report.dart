//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/stock_row.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_stock_report.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BranchStockReport {
  /// Returns a new [BranchStockReport] instance.
  BranchStockReport({

    required  this.branchId,

    required  this.branchName,

    required  this.items,
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
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<StockRow> items;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BranchStockReport &&
      other.branchId == branchId &&
      other.branchName == branchName &&
      other.items == items;

    @override
    int get hashCode =>
        branchId.hashCode +
        branchName.hashCode +
        items.hashCode;

  factory BranchStockReport.fromJson(Map<String, dynamic> json) => _$BranchStockReportFromJson(json);

  Map<String, dynamic> toJson() => _$BranchStockReportToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

