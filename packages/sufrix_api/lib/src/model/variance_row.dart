//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variance_row.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class VarianceRow {
  /// Returns a new [VarianceRow] instance.
  VarianceRow({

     this.countedQty,

    required  this.expectedQty,

    required  this.ingredientName,

    required  this.isFlagged,

    required  this.orgIngredientId,

    required  this.unit,

     this.unitCost,

     this.variance,

     this.varianceReason,

     this.varianceValue,
  });

  @JsonKey(
    
    name: r'counted_qty',
    required: false,
    includeIfNull: false,
  )


  final double? countedQty;



  @JsonKey(
    
    name: r'expected_qty',
    required: true,
    includeIfNull: false,
  )


  final double expectedQty;



  @JsonKey(
    
    name: r'ingredient_name',
    required: true,
    includeIfNull: false,
  )


  final String ingredientName;



      /// True when |difference| exceeds the org threshold (or appears/vanishes from zero).
  @JsonKey(
    
    name: r'is_flagged',
    required: true,
    includeIfNull: false,
  )


  final bool isFlagged;



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



  @JsonKey(
    
    name: r'unit_cost',
    required: false,
    includeIfNull: false,
  )


  final int? unitCost;



  @JsonKey(
    
    name: r'variance',
    required: false,
    includeIfNull: false,
  )


  final double? variance;



      /// theft | spoilage | breakage | miscount | supplier_short | transfer_error | other.
  @JsonKey(
    
    name: r'variance_reason',
    required: false,
    includeIfNull: false,
  )


  final String? varianceReason;



      /// variance × unit_cost in piastres; `null` when cost unknown.
  @JsonKey(
    
    name: r'variance_value',
    required: false,
    includeIfNull: false,
  )


  final int? varianceValue;





    @override
    bool operator ==(Object other) => identical(this, other) || other is VarianceRow &&
      other.countedQty == countedQty &&
      other.expectedQty == expectedQty &&
      other.ingredientName == ingredientName &&
      other.isFlagged == isFlagged &&
      other.orgIngredientId == orgIngredientId &&
      other.unit == unit &&
      other.unitCost == unitCost &&
      other.variance == variance &&
      other.varianceReason == varianceReason &&
      other.varianceValue == varianceValue;

    @override
    int get hashCode =>
        (countedQty == null ? 0 : countedQty.hashCode) +
        expectedQty.hashCode +
        ingredientName.hashCode +
        isFlagged.hashCode +
        orgIngredientId.hashCode +
        unit.hashCode +
        (unitCost == null ? 0 : unitCost.hashCode) +
        (variance == null ? 0 : variance.hashCode) +
        (varianceReason == null ? 0 : varianceReason.hashCode) +
        (varianceValue == null ? 0 : varianceValue.hashCode);

  factory VarianceRow.fromJson(Map<String, dynamic> json) => _$VarianceRowFromJson(json);

  Map<String, dynamic> toJson() => _$VarianceRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

