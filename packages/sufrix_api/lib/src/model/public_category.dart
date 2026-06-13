//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/public_menu_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_category.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PublicCategory {
  /// Returns a new [PublicCategory] instance.
  PublicCategory({

    required  this.id,

     this.imageUrl,

    required  this.items,

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
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<PublicMenuItem> items;



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
    bool operator ==(Object other) => identical(this, other) || other is PublicCategory &&
      other.id == id &&
      other.imageUrl == imageUrl &&
      other.items == items &&
      other.name == name &&
      other.nameTranslations == nameTranslations;

    @override
    int get hashCode =>
        id.hashCode +
        (imageUrl == null ? 0 : imageUrl.hashCode) +
        items.hashCode +
        name.hashCode +
        nameTranslations.hashCode;

  factory PublicCategory.fromJson(Map<String, dynamic> json) => _$PublicCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$PublicCategoryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

