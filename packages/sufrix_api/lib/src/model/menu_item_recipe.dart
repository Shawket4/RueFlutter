//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu_item_recipe.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MenuItemRecipe {
  /// Returns a new [MenuItemRecipe] instance.
  MenuItemRecipe({

    required  this.category,

    required  this.ingredientName,

    required  this.ingredientUnit,

     this.orgIngredientId,

    required  this.quantityUsed,

    required  this.sizeLabel,
  });

  @JsonKey(
    
    name: r'category',
    required: true,
    includeIfNull: false,
  )


  final String category;



  @JsonKey(
    
    name: r'ingredient_name',
    required: true,
    includeIfNull: false,
  )


  final String ingredientName;



  @JsonKey(
    
    name: r'ingredient_unit',
    required: true,
    includeIfNull: false,
  )


  final String ingredientUnit;



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





    @override
    bool operator ==(Object other) => identical(this, other) || other is MenuItemRecipe &&
      other.category == category &&
      other.ingredientName == ingredientName &&
      other.ingredientUnit == ingredientUnit &&
      other.orgIngredientId == orgIngredientId &&
      other.quantityUsed == quantityUsed &&
      other.sizeLabel == sizeLabel;

    @override
    int get hashCode =>
        category.hashCode +
        ingredientName.hashCode +
        ingredientUnit.hashCode +
        (orgIngredientId == null ? 0 : orgIngredientId.hashCode) +
        quantityUsed.hashCode +
        sizeLabel.hashCode;

  factory MenuItemRecipe.fromJson(Map<String, dynamic> json) => _$MenuItemRecipeFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemRecipeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

