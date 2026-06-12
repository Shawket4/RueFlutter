//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_category_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateCategoryRequest {
  /// Returns a new [UpdateCategoryRequest] instance.
  UpdateCategoryRequest({

     this.displayOrder,

     this.imageUrl,

     this.isActive,

     this.name,

     this.nameTranslations,
  });

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
    bool operator ==(Object other) => identical(this, other) || other is UpdateCategoryRequest &&
      other.displayOrder == displayOrder &&
      other.imageUrl == imageUrl &&
      other.isActive == isActive &&
      other.name == name &&
      other.nameTranslations == nameTranslations;

    @override
    int get hashCode =>
        (displayOrder == null ? 0 : displayOrder.hashCode) +
        (imageUrl == null ? 0 : imageUrl.hashCode) +
        (isActive == null ? 0 : isActive.hashCode) +
        (name == null ? 0 : name.hashCode) +
        (nameTranslations == null ? 0 : nameTranslations.hashCode);

  factory UpdateCategoryRequest.fromJson(Map<String, dynamic> json) => _$UpdateCategoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCategoryRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

