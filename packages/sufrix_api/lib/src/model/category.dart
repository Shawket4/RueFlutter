//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Category {
  /// Returns a new [Category] instance.
  Category({

    required  this.createdAt,

     this.deletedAt,

    required  this.displayOrder,

    required  this.id,

     this.imageUrl,

    required  this.isActive,

    required  this.name,

    required  this.nameTranslations,

    required  this.orgId,

    required  this.updatedAt,
  });

  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'deleted_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? deletedAt;



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





    @override
    bool operator ==(Object other) => identical(this, other) || other is Category &&
      other.createdAt == createdAt &&
      other.deletedAt == deletedAt &&
      other.displayOrder == displayOrder &&
      other.id == id &&
      other.imageUrl == imageUrl &&
      other.isActive == isActive &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.orgId == orgId &&
      other.updatedAt == updatedAt;

    @override
    int get hashCode =>
        createdAt.hashCode +
        (deletedAt == null ? 0 : deletedAt.hashCode) +
        displayOrder.hashCode +
        id.hashCode +
        (imageUrl == null ? 0 : imageUrl.hashCode) +
        isActive.hashCode +
        name.hashCode +
        nameTranslations.hashCode +
        orgId.hashCode +
        updatedAt.hashCode;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

