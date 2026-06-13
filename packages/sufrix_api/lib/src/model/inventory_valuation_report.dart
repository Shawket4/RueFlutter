//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/valuation_row.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inventory_valuation_report.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InventoryValuationReport {
  /// Returns a new [InventoryValuationReport] instance.
  InventoryValuationReport({

    required  this.items,

    required  this.totalValue,

    required  this.unknownCostCount,
  });

  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<ValuationRow> items;



  @JsonKey(
    
    name: r'total_value',
    required: true,
    includeIfNull: false,
  )


  final int totalValue;



  @JsonKey(
    
    name: r'unknown_cost_count',
    required: true,
    includeIfNull: false,
  )


  final int unknownCostCount;





    @override
    bool operator ==(Object other) => identical(this, other) || other is InventoryValuationReport &&
      other.items == items &&
      other.totalValue == totalValue &&
      other.unknownCostCount == unknownCostCount;

    @override
    int get hashCode =>
        items.hashCode +
        totalValue.hashCode +
        unknownCostCount.hashCode;

  factory InventoryValuationReport.fromJson(Map<String, dynamic> json) => _$InventoryValuationReportFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryValuationReportToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

