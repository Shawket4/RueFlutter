//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_menu_item_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateMenuItemRequest {
  /// Returns a new [UpdateMenuItemRequest] instance.
  UpdateMenuItemRequest({

     this.basePrice,

     this.categoryId,

     this.description,

     this.descriptionTranslations,

     this.displayOrder,

     this.imageUrl,

     this.isActive,

     this.name,

     this.nameTranslations,
  });

  @JsonKey(
    
    name: r'base_price',
    required: false,
    includeIfNull: false,
  )


  final int? basePrice;



  @JsonKey(
    
    name: r'category_id',
    required: false,
    includeIfNull: false,
  )


  final String? categoryId;



  @JsonKey(
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



  @JsonKey(
    
    name: r'description_translations',
    required: false,
    includeIfNull: false,
  )


  final Object? descriptionTranslations;



  @JsonKey(
    
    name: r'display_order',
    required: false,
    includeIfNull: false,
  )


  final int? displayOrder;



  @JsonKey(
    
    name: r'image_url',
    required: false,
    includeIfNull: false,
  )


  final String? imageUrl;



  @JsonKey(
    
    name: r'is_active',
    required: false,
    includeIfNull: false,
  )


  final bool? isActive;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'name_translations',
    required: false,
    includeIfNull: false,
  )


  final Object? nameTranslations;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpdateMenuItemRequest &&
      other.basePrice == basePrice &&
      other.categoryId == categoryId &&
      other.description == description &&
      other.descriptionTranslations == descriptionTranslations &&
      other.displayOrder == displayOrder &&
      other.imageUrl == imageUrl &&
      other.isActive == isActive &&
      other.name == name &&
      other.nameTranslations == nameTranslations;

    @override
    int get hashCode =>
        (basePrice == null ? 0 : basePrice.hashCode) +
        (categoryId == null ? 0 : categoryId.hashCode) +
        (description == null ? 0 : description.hashCode) +
        (descriptionTranslations == null ? 0 : descriptionTranslations.hashCode) +
        (displayOrder == null ? 0 : displayOrder.hashCode) +
        (imageUrl == null ? 0 : imageUrl.hashCode) +
        (isActive == null ? 0 : isActive.hashCode) +
        (name == null ? 0 : name.hashCode) +
        (nameTranslations == null ? 0 : nameTranslations.hashCode);

  factory UpdateMenuItemRequest.fromJson(Map<String, dynamic> json) => _$UpdateMenuItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateMenuItemRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

