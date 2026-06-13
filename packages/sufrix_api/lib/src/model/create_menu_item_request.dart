//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_menu_item_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateMenuItemRequest {
  /// Returns a new [CreateMenuItemRequest] instance.
  CreateMenuItemRequest({

    required  this.basePrice,

    required  this.categoryId,

     this.description,

     this.descriptionTranslations,

     this.imageUrl,

    required  this.name,

     this.nameTranslations,

    required  this.orgId,
  });

  @JsonKey(
    
    name: r'base_price',
    required: true,
    includeIfNull: false,
  )


  final int basePrice;



  @JsonKey(
    
    name: r'category_id',
    required: true,
    includeIfNull: false,
  )


  final String categoryId;



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
    required: false,
    includeIfNull: false,
  )


  final Object? nameTranslations;



  @JsonKey(
    
    name: r'org_id',
    required: true,
    includeIfNull: false,
  )


  final String orgId;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateMenuItemRequest &&
      other.basePrice == basePrice &&
      other.categoryId == categoryId &&
      other.description == description &&
      other.descriptionTranslations == descriptionTranslations &&
      other.imageUrl == imageUrl &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.orgId == orgId;

    @override
    int get hashCode =>
        basePrice.hashCode +
        categoryId.hashCode +
        (description == null ? 0 : description.hashCode) +
        (descriptionTranslations == null ? 0 : descriptionTranslations.hashCode) +
        (imageUrl == null ? 0 : imageUrl.hashCode) +
        name.hashCode +
        (nameTranslations == null ? 0 : nameTranslations.hashCode) +
        orgId.hashCode;

  factory CreateMenuItemRequest.fromJson(Map<String, dynamic> json) => _$CreateMenuItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateMenuItemRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

