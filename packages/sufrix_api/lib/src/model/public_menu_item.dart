//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/public_item_size.dart';
import 'package:sufrix_api/src/model/public_addon_slot.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_menu_item.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PublicMenuItem {
  /// Returns a new [PublicMenuItem] instance.
  PublicMenuItem({

    required  this.addonSlots,

    required  this.basePrice,

     this.description,

    required  this.descriptionTranslations,

    required  this.displayOrder,

    required  this.id,

     this.imageUrl,

    required  this.name,

    required  this.nameTranslations,

    required  this.sizes,
  });

  @JsonKey(
    
    name: r'addon_slots',
    required: true,
    includeIfNull: false,
  )


  final List<PublicAddonSlot> addonSlots;



  @JsonKey(
    
    name: r'base_price',
    required: true,
    includeIfNull: false,
  )


  final int basePrice;



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
    
    name: r'sizes',
    required: true,
    includeIfNull: false,
  )


  final List<PublicItemSize> sizes;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PublicMenuItem &&
      other.addonSlots == addonSlots &&
      other.basePrice == basePrice &&
      other.description == description &&
      other.descriptionTranslations == descriptionTranslations &&
      other.displayOrder == displayOrder &&
      other.id == id &&
      other.imageUrl == imageUrl &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.sizes == sizes;

    @override
    int get hashCode =>
        addonSlots.hashCode +
        basePrice.hashCode +
        (description == null ? 0 : description.hashCode) +
        descriptionTranslations.hashCode +
        displayOrder.hashCode +
        id.hashCode +
        (imageUrl == null ? 0 : imageUrl.hashCode) +
        name.hashCode +
        nameTranslations.hashCode +
        sizes.hashCode;

  factory PublicMenuItem.fromJson(Map<String, dynamic> json) => _$PublicMenuItemFromJson(json);

  Map<String, dynamic> toJson() => _$PublicMenuItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

