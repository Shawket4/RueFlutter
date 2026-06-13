//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'consumption_row.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ConsumptionRow {
  /// Returns a new [ConsumptionRow] instance.
  ConsumptionRow({

    required  this.consumedQty,

     this.consumedValue,

    required  this.ingredientName,

    required  this.orgIngredientId,

    required  this.unit,
  });

  @JsonKey(
    
    name: r'consumed_qty',
    required: true,
    includeIfNull: false,
  )


  final double consumedQty;



      /// Consumption valued in piastres; `null` if any contributing cost unknown.
  @JsonKey(
    
    name: r'consumed_value',
    required: false,
    includeIfNull: false,
  )


  final int? consumedValue;



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





    @override
    bool operator ==(Object other) => identical(this, other) || other is ConsumptionRow &&
      other.consumedQty == consumedQty &&
      other.consumedValue == consumedValue &&
      other.ingredientName == ingredientName &&
      other.orgIngredientId == orgIngredientId &&
      other.unit == unit;

    @override
    int get hashCode =>
        consumedQty.hashCode +
        (consumedValue == null ? 0 : consumedValue.hashCode) +
        ingredientName.hashCode +
        orgIngredientId.hashCode +
        unit.hashCode;

  factory ConsumptionRow.fromJson(Map<String, dynamic> json) => _$ConsumptionRowFromJson(json);

  Map<String, dynamic> toJson() => _$ConsumptionRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

