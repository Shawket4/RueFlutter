//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_row.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StockRow {
  /// Returns a new [StockRow] instance.
  StockRow({

    required  this.belowReorder,

    required  this.branchInventoryId,

    required  this.costPerUnit,

    required  this.currentStock,

    required  this.ingredientName,

    required  this.reorderThreshold,

    required  this.unit,
  });

  @JsonKey(
    
    name: r'below_reorder',
    required: true,
    includeIfNull: false,
  )


  final bool belowReorder;



  @JsonKey(
    
    name: r'branch_inventory_id',
    required: true,
    includeIfNull: false,
  )


  final String branchInventoryId;



  @JsonKey(
    
    name: r'cost_per_unit',
    required: true,
    includeIfNull: false,
  )


  final double costPerUnit;



  @JsonKey(
    
    name: r'current_stock',
    required: true,
    includeIfNull: false,
  )


  final double currentStock;



  @JsonKey(
    
    name: r'ingredient_name',
    required: true,
    includeIfNull: false,
  )


  final String ingredientName;



  @JsonKey(
    
    name: r'reorder_threshold',
    required: true,
    includeIfNull: false,
  )


  final double reorderThreshold;



  @JsonKey(
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;





    @override
    bool operator ==(Object other) => identical(this, other) || other is StockRow &&
      other.belowReorder == belowReorder &&
      other.branchInventoryId == branchInventoryId &&
      other.costPerUnit == costPerUnit &&
      other.currentStock == currentStock &&
      other.ingredientName == ingredientName &&
      other.reorderThreshold == reorderThreshold &&
      other.unit == unit;

    @override
    int get hashCode =>
        belowReorder.hashCode +
        branchInventoryId.hashCode +
        costPerUnit.hashCode +
        currentStock.hashCode +
        ingredientName.hashCode +
        reorderThreshold.hashCode +
        unit.hashCode;

  factory StockRow.fromJson(Map<String, dynamic> json) => _$StockRowFromJson(json);

  Map<String, dynamic> toJson() => _$StockRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

