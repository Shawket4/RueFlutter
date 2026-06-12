//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drink_recipe.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DrinkRecipe {
  /// Returns a new [DrinkRecipe] instance.
  DrinkRecipe({

    required  this.id,

    required  this.ingredientName,

    required  this.menuItemId,

     this.orgIngredientId,

    required  this.quantityUsed,

    required  this.sizeLabel,

    required  this.unit,
  });

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
    
    name: r'menu_item_id',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;



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
    
    name: r'size_label',
    required: true,
    includeIfNull: false,
  )


  final String sizeLabel;



  @JsonKey(
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;





    @override
    bool operator ==(Object other) => identical(this, other) || other is DrinkRecipe &&
      other.id == id &&
      other.ingredientName == ingredientName &&
      other.menuItemId == menuItemId &&
      other.orgIngredientId == orgIngredientId &&
      other.quantityUsed == quantityUsed &&
      other.sizeLabel == sizeLabel &&
      other.unit == unit;

    @override
    int get hashCode =>
        id.hashCode +
        ingredientName.hashCode +
        menuItemId.hashCode +
        (orgIngredientId == null ? 0 : orgIngredientId.hashCode) +
        quantityUsed.hashCode +
        sizeLabel.hashCode +
        unit.hashCode;

  factory DrinkRecipe.fromJson(Map<String, dynamic> json) => _$DrinkRecipeFromJson(json);

  Map<String, dynamic> toJson() => _$DrinkRecipeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

