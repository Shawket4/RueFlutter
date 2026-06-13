//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shrinkage_row.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ShrinkageRow {
  /// Returns a new [ShrinkageRow] instance.
  ShrinkageRow({

    required  this.ingredientName,

    required  this.orgIngredientId,

    required  this.reason,

    required  this.shrinkageQty,

     this.shrinkageValue,

    required  this.unit,
  });

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



      /// The variance reason captured at finalize, or `unexplained` when none.
  @JsonKey(
    
    name: r'reason',
    required: true,
    includeIfNull: false,
  )


  final String reason;



      /// Quantity lost (positive number) from negative stock-count differences.
  @JsonKey(
    
    name: r'shrinkage_qty',
    required: true,
    includeIfNull: false,
  )


  final double shrinkageQty;



      /// Valued shrinkage in piastres; `null` when any contributing cost unknown.
  @JsonKey(
    
    name: r'shrinkage_value',
    required: false,
    includeIfNull: false,
  )


  final int? shrinkageValue;



  @JsonKey(
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ShrinkageRow &&
      other.ingredientName == ingredientName &&
      other.orgIngredientId == orgIngredientId &&
      other.reason == reason &&
      other.shrinkageQty == shrinkageQty &&
      other.shrinkageValue == shrinkageValue &&
      other.unit == unit;

    @override
    int get hashCode =>
        ingredientName.hashCode +
        orgIngredientId.hashCode +
        reason.hashCode +
        shrinkageQty.hashCode +
        (shrinkageValue == null ? 0 : shrinkageValue.hashCode) +
        unit.hashCode;

  factory ShrinkageRow.fromJson(Map<String, dynamic> json) => _$ShrinkageRowFromJson(json);

  Map<String, dynamic> toJson() => _$ShrinkageRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

