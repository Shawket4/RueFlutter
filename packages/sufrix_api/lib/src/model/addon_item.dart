//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/addon_item_ingredient.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'addon_item.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AddonItem {
  /// Returns a new [AddonItem] instance.
  AddonItem({

    required  this.addonType,

    required  this.createdAt,

    required  this.defaultPrice,

    required  this.displayOrder,

    required  this.id,

     this.ingredients,

    required  this.isActive,

    required  this.name,

    required  this.nameTranslations,

    required  this.orgId,

     this.primaryIngredientId,

    required  this.updatedAt,
  });

  @JsonKey(
    
    name: r'addon_type',
    required: true,
    includeIfNull: false,
  )


  final String addonType;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'default_price',
    required: true,
    includeIfNull: false,
  )


  final int defaultPrice;



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
    
    name: r'ingredients',
    required: false,
    includeIfNull: false,
  )


  final List<AddonItemIngredient>? ingredients;



  @JsonKey(
    
    name: r'is_active',
    required: true,
    includeIfNull: false,
  )


  final bool isActive;



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
    
    name: r'org_id',
    required: true,
    includeIfNull: false,
  )


  final String orgId;



  @JsonKey(
    
    name: r'primary_ingredient_id',
    required: false,
    includeIfNull: false,
  )


  final String? primaryIngredientId;



  @JsonKey(
    
    name: r'updated_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime updatedAt;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AddonItem &&
      other.addonType == addonType &&
      other.createdAt == createdAt &&
      other.defaultPrice == defaultPrice &&
      other.displayOrder == displayOrder &&
      other.id == id &&
      other.ingredients == ingredients &&
      other.isActive == isActive &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.orgId == orgId &&
      other.primaryIngredientId == primaryIngredientId &&
      other.updatedAt == updatedAt;

    @override
    int get hashCode =>
        addonType.hashCode +
        createdAt.hashCode +
        defaultPrice.hashCode +
        displayOrder.hashCode +
        id.hashCode +
        ingredients.hashCode +
        isActive.hashCode +
        name.hashCode +
        nameTranslations.hashCode +
        orgId.hashCode +
        (primaryIngredientId == null ? 0 : primaryIngredientId.hashCode) +
        updatedAt.hashCode;

  factory AddonItem.fromJson(Map<String, dynamic> json) => _$AddonItemFromJson(json);

  Map<String, dynamic> toJson() => _$AddonItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

