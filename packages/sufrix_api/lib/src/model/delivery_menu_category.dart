//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_menu_category.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DeliveryMenuCategory {
  /// Returns a new [DeliveryMenuCategory] instance.
  DeliveryMenuCategory({

    required  this.id,

     this.imageUrl,

    required  this.name,

    required  this.nameTranslations,
  });

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





    @override
    bool operator ==(Object other) => identical(this, other) || other is DeliveryMenuCategory &&
      other.id == id &&
      other.imageUrl == imageUrl &&
      other.name == name &&
      other.nameTranslations == nameTranslations;

    @override
    int get hashCode =>
        id.hashCode +
        (imageUrl == null ? 0 : imageUrl.hashCode) +
        name.hashCode +
        nameTranslations.hashCode;

  factory DeliveryMenuCategory.fromJson(Map<String, dynamic> json) => _$DeliveryMenuCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryMenuCategoryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

