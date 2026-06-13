//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'valuation_row.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ValuationRow {
  /// Returns a new [ValuationRow] instance.
  ValuationRow({

     this.costPerUnit,

    required  this.currentStock,

    required  this.ingredientName,

    required  this.orgIngredientId,

    required  this.unit,

     this.value,
  });

      /// Piastres per unit; `null` ⟺ unknown.
  @JsonKey(
    
    name: r'cost_per_unit',
    required: false,
    includeIfNull: false,
  )


  final int? costPerUnit;



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
    
    name: r'org_ingredient_id',
    required: true,
    includeIfNull: false,
  )


  final String orgIngredientId;



  @JsonKey(
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;



      /// current_stock × cost_per_unit in piastres; `null` when cost unknown.
  @JsonKey(
    
    name: r'value',
    required: false,
    includeIfNull: false,
  )


  final int? value;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ValuationRow &&
      other.costPerUnit == costPerUnit &&
      other.currentStock == currentStock &&
      other.ingredientName == ingredientName &&
      other.orgIngredientId == orgIngredientId &&
      other.unit == unit &&
      other.value == value;

    @override
    int get hashCode =>
        (costPerUnit == null ? 0 : costPerUnit.hashCode) +
        currentStock.hashCode +
        ingredientName.hashCode +
        orgIngredientId.hashCode +
        unit.hashCode +
        (value == null ? 0 : value.hashCode);

  factory ValuationRow.fromJson(Map<String, dynamic> json) => _$ValuationRowFromJson(json);

  Map<String, dynamic> toJson() => _$ValuationRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

