//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'addon_ingredient.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AddonIngredient {
  /// Returns a new [AddonIngredient] instance.
  AddonIngredient({

    required  this.addonItemId,

    required  this.id,

    required  this.ingredientName,

     this.orgIngredientId,

    required  this.quantityUsed,

    required  this.unit,
  });

  @JsonKey(
    
    name: r'addon_item_id',
    required: true,
    includeIfNull: false,
  )


  final String addonItemId;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'ingredient_name',
    required: true,
    includeIfNull: false,
  )


  final String ingredientName;



  @JsonKey(
    
    name: r'org_ingredient_id',
    required: false,
    includeIfNull: false,
  )


  final String? orgIngredientId;



  @JsonKey(
    
    name: r'quantity_used',
    required: true,
    includeIfNull: false,
  )


  final double quantityUsed;



  @JsonKey(
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AddonIngredient &&
      other.addonItemId == addonItemId &&
      other.id == id &&
      other.ingredientName == ingredientName &&
      other.orgIngredientId == orgIngredientId &&
      other.quantityUsed == quantityUsed &&
      other.unit == unit;

    @override
    int get hashCode =>
        addonItemId.hashCode +
        id.hashCode +
        ingredientName.hashCode +
        (orgIngredientId == null ? 0 : orgIngredientId.hashCode) +
        quantityUsed.hashCode +
        unit.hashCode;

  factory AddonIngredient.fromJson(Map<String, dynamic> json) => _$AddonIngredientFromJson(json);

  Map<String, dynamic> toJson() => _$AddonIngredientToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

