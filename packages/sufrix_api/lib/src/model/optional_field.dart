//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'optional_field.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OptionalField {
  /// Returns a new [OptionalField] instance.
  OptionalField({

    required  this.createdAt,

    required  this.displayOrder,

    required  this.id,

     this.ingredientName,

     this.ingredientUnit,

    required  this.isActive,

    required  this.menuItemId,

    required  this.name,

    required  this.nameTranslations,

     this.orgIngredientId,

    required  this.price,

     this.quantityUsed,

     this.sizeLabel,

    required  this.updatedAt,
  });

  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'display_order',
    required: true,
    includeIfNull: false,
  )


  final int displayOrder;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'ingredient_name',
    required: false,
    includeIfNull: false,
  )


  final String? ingredientName;



  @JsonKey(
    
    name: r'ingredient_unit',
    required: false,
    includeIfNull: false,
  )


  final String? ingredientUnit;



  @JsonKey(
    
    name: r'is_active',
    required: true,
    includeIfNull: false,
  )


  final bool isActive;



  @JsonKey(
    
    name: r'menu_item_id',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'name_translations',
    required: true,
    includeIfNull: false,
  )


  final Object nameTranslations;



  @JsonKey(
    
    name: r'org_ingredient_id',
    required: false,
    includeIfNull: false,
  )


  final String? orgIngredientId;



  @JsonKey(
    
    name: r'price',
    required: true,
    includeIfNull: false,
  )


  final int price;



  @JsonKey(
    
    name: r'quantity_used',
    required: false,
    includeIfNull: false,
  )


  final double? quantityUsed;



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
    bool operator ==(Object other) => identical(this, other) || other is OptionalField &&
      other.createdAt == createdAt &&
      other.displayOrder == displayOrder &&
      other.id == id &&
      other.ingredientName == ingredientName &&
      other.ingredientUnit == ingredientUnit &&
      other.isActive == isActive &&
      other.menuItemId == menuItemId &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.orgIngredientId == orgIngredientId &&
      other.price == price &&
      other.quantityUsed == quantityUsed &&
      other.sizeLabel == sizeLabel &&
      other.updatedAt == updatedAt;

    @override
    int get hashCode =>
        createdAt.hashCode +
        displayOrder.hashCode +
        id.hashCode +
        (ingredientName == null ? 0 : ingredientName.hashCode) +
        (ingredientUnit == null ? 0 : ingredientUnit.hashCode) +
        isActive.hashCode +
        menuItemId.hashCode +
        name.hashCode +
        nameTranslations.hashCode +
        (orgIngredientId == null ? 0 : orgIngredientId.hashCode) +
        price.hashCode +
        (quantityUsed == null ? 0 : quantityUsed.hashCode) +
        (sizeLabel == null ? 0 : sizeLabel.hashCode) +
        updatedAt.hashCode;

  factory OptionalField.fromJson(Map<String, dynamic> json) => _$OptionalFieldFromJson(json);

  Map<String, dynamic> toJson() => _$OptionalFieldToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

