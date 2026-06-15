//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/delivery_menu_size.dart';
import 'package:sufrix_api/src/model/delivery_optional_field.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_menu_item.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DeliveryMenuItem {
  /// Returns a new [DeliveryMenuItem] instance.
  DeliveryMenuItem({

     this.categoryId,

     this.defaultMilkAddonId,

     this.description,

    required  this.id,

     this.imageUrl,

    required  this.name,

    required  this.nameTranslations,

    required  this.optionals,

    required  this.price,

    required  this.sizes,
  });

  @JsonKey(
    
    name: r'category_id',
    required: false,
    includeIfNull: false,
  )


  final String? categoryId;



      /// The item's base/default milk: the `milk_type` addon whose ingredient matches the item recipe's milk ingredient. The online customizer pre-selects it (mirrors the POS default-milk selection). `None` when the item has no milk in its recipe or no matching milk addon exists.
  @JsonKey(
    
    name: r'default_milk_addon_id',
    required: false,
    includeIfNull: false,
  )


  final String? defaultMilkAddonId;



  @JsonKey(
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



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
    
    name: r'optionals',
    required: true,
    includeIfNull: false,
  )


  final List<DeliveryOptionalField> optionals;



  @JsonKey(
    
    name: r'price',
    required: true,
    includeIfNull: false,
  )


  final int price;



  @JsonKey(
    
    name: r'sizes',
    required: true,
    includeIfNull: false,
  )


  final List<DeliveryMenuSize> sizes;





    @override
    bool operator ==(Object other) => identical(this, other) || other is DeliveryMenuItem &&
      other.categoryId == categoryId &&
      other.defaultMilkAddonId == defaultMilkAddonId &&
      other.description == description &&
      other.id == id &&
      other.imageUrl == imageUrl &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.optionals == optionals &&
      other.price == price &&
      other.sizes == sizes;

    @override
    int get hashCode =>
        (categoryId == null ? 0 : categoryId.hashCode) +
        (defaultMilkAddonId == null ? 0 : defaultMilkAddonId.hashCode) +
        (description == null ? 0 : description.hashCode) +
        id.hashCode +
        (imageUrl == null ? 0 : imageUrl.hashCode) +
        name.hashCode +
        nameTranslations.hashCode +
        optionals.hashCode +
        price.hashCode +
        sizes.hashCode;

  factory DeliveryMenuItem.fromJson(Map<String, dynamic> json) => _$DeliveryMenuItemFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryMenuItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

