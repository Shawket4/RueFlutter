//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/item_size.dart';
import 'package:sufrix_api/src/model/menu_item_recipe.dart';
import 'package:sufrix_api/src/model/optional_field.dart';
import 'package:sufrix_api/src/model/addon_slot.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu_item_full.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MenuItemFull {
  /// Returns a new [MenuItemFull] instance.
  MenuItemFull({

    required  this.basePrice,

     this.categoryId,

    required  this.createdAt,

     this.defaultMilkAddonId,

     this.deletedAt,

     this.description,

    required  this.descriptionTranslations,

    required  this.id,

     this.imageUrl,

    required  this.isActive,

    required  this.name,

    required  this.nameTranslations,

    required  this.orgId,

    required  this.updatedAt,

    required  this.addonSlots,

    required  this.optionalFields,

    required  this.recipes,

    required  this.sizes,
  });

  @JsonKey(
    
    name: r'base_price',
    required: true,
    includeIfNull: false,
  )


  final int basePrice;



  @JsonKey(
    
    name: r'category_id',
    required: false,
    includeIfNull: false,
  )


  final String? categoryId;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'default_milk_addon_id',
    required: false,
    includeIfNull: false,
  )


  final String? defaultMilkAddonId;



  @JsonKey(
    
    name: r'deleted_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? deletedAt;



  @JsonKey(
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



  @JsonKey(
    
    name: r'description_translations',
    required: true,
    includeIfNull: false,
  )


  final Object descriptionTranslations;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'image_url',
    required: false,
    includeIfNull: false,
  )


  final String? imageUrl;



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
    
    name: r'updated_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime updatedAt;



  @JsonKey(
    
    name: r'addon_slots',
    required: true,
    includeIfNull: false,
  )


  final List<AddonSlot> addonSlots;



  @JsonKey(
    
    name: r'optional_fields',
    required: true,
    includeIfNull: false,
  )


  final List<OptionalField> optionalFields;



  @JsonKey(
    
    name: r'recipes',
    required: true,
    includeIfNull: false,
  )


  final List<MenuItemRecipe> recipes;



  @JsonKey(
    
    name: r'sizes',
    required: true,
    includeIfNull: false,
  )


  final List<ItemSize> sizes;





    @override
    bool operator ==(Object other) => identical(this, other) || other is MenuItemFull &&
      other.basePrice == basePrice &&
      other.categoryId == categoryId &&
      other.createdAt == createdAt &&
      other.defaultMilkAddonId == defaultMilkAddonId &&
      other.deletedAt == deletedAt &&
      other.description == description &&
      other.descriptionTranslations == descriptionTranslations &&
      other.id == id &&
      other.imageUrl == imageUrl &&
      other.isActive == isActive &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.orgId == orgId &&
      other.updatedAt == updatedAt &&
      other.addonSlots == addonSlots &&
      other.optionalFields == optionalFields &&
      other.recipes == recipes &&
      other.sizes == sizes;

    @override
    int get hashCode =>
        basePrice.hashCode +
        categoryId.hashCode +
        createdAt.hashCode +
        defaultMilkAddonId.hashCode +
        deletedAt.hashCode +
        description.hashCode +
        descriptionTranslations.hashCode +
        id.hashCode +
        imageUrl.hashCode +
        isActive.hashCode +
        name.hashCode +
        nameTranslations.hashCode +
        orgId.hashCode +
        updatedAt.hashCode +
        addonSlots.hashCode +
        optionalFields.hashCode +
        recipes.hashCode +
        sizes.hashCode;

  factory MenuItemFull.fromJson(Map<String, dynamic> json) => _$MenuItemFullFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemFullToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

