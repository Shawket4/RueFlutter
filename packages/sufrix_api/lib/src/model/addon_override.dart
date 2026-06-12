//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'addon_override.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AddonOverride {
  /// Returns a new [AddonOverride] instance.
  AddonOverride({

    required  this.addonItemId,

    required  this.addonItemName,

     this.comboAddonItemId,

     this.comboAddonItemName,

    required  this.createdAt,

    required  this.id,

    required  this.ingredientName,

    required  this.ingredientUnit,

    required  this.menuItemId,

     this.orgIngredientId,

    required  this.quantityUsed,

     this.replacesIngredientName,

     this.replacesOrgIngredientId,

     this.sizeLabel,

    required  this.updatedAt,
  });

  @JsonKey(
    
    name: r'addon_item_id',
    required: true,
    includeIfNull: false,
  )


  final String addonItemId;



  @JsonKey(
    
    name: r'addon_item_name',
    required: true,
    includeIfNull: false,
  )


  final String addonItemName;



  @JsonKey(
    
    name: r'combo_addon_item_id',
    required: false,
    includeIfNull: false,
  )


  final String? comboAddonItemId;



  @JsonKey(
    
    name: r'combo_addon_item_name',
    required: false,
    includeIfNull: false,
  )


  final String? comboAddonItemName;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



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
    
    name: r'ingredient_unit',
    required: true,
    includeIfNull: false,
  )


  final String ingredientUnit;



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
    
    name: r'replaces_ingredient_name',
    required: false,
    includeIfNull: false,
  )


  final String? replacesIngredientName;



  @JsonKey(
    
    name: r'replaces_org_ingredient_id',
    required: false,
    includeIfNull: false,
  )


  final String? replacesOrgIngredientId;



  @JsonKey(
    
    name: r'size_label',
    required: false,
    includeIfNull: false,
  )


  final String? sizeLabel;



  @JsonKey(
    
    name: r'updated_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime updatedAt;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AddonOverride &&
      other.addonItemId == addonItemId &&
      other.addonItemName == addonItemName &&
      other.comboAddonItemId == comboAddonItemId &&
      other.comboAddonItemName == comboAddonItemName &&
      other.createdAt == createdAt &&
      other.id == id &&
      other.ingredientName == ingredientName &&
      other.ingredientUnit == ingredientUnit &&
      other.menuItemId == menuItemId &&
      other.orgIngredientId == orgIngredientId &&
      other.quantityUsed == quantityUsed &&
      other.replacesIngredientName == replacesIngredientName &&
      other.replacesOrgIngredientId == replacesOrgIngredientId &&
      other.sizeLabel == sizeLabel &&
      other.updatedAt == updatedAt;

    @override
    int get hashCode =>
        addonItemId.hashCode +
        addonItemName.hashCode +
        (comboAddonItemId == null ? 0 : comboAddonItemId.hashCode) +
        (comboAddonItemName == null ? 0 : comboAddonItemName.hashCode) +
        createdAt.hashCode +
        id.hashCode +
        ingredientName.hashCode +
        ingredientUnit.hashCode +
        menuItemId.hashCode +
        (orgIngredientId == null ? 0 : orgIngredientId.hashCode) +
        quantityUsed.hashCode +
        (replacesIngredientName == null ? 0 : replacesIngredientName.hashCode) +
        (replacesOrgIngredientId == null ? 0 : replacesOrgIngredientId.hashCode) +
        (sizeLabel == null ? 0 : sizeLabel.hashCode) +
        updatedAt.hashCode;

  factory AddonOverride.fromJson(Map<String, dynamic> json) => _$AddonOverrideFromJson(json);

  Map<String, dynamic> toJson() => _$AddonOverrideToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

