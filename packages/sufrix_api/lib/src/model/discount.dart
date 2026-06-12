//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'discount.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Discount {
  /// Returns a new [Discount] instance.
  Discount({

    required  this.createdAt,

    required  this.dtype,

    required  this.id,

    required  this.isActive,

    required  this.name,

    required  this.nameTranslations,

    required  this.orgId,

    required  this.updatedAt,

    required  this.value,
  });

  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'dtype',
    required: true,
    includeIfNull: false,
  )


  final String dtype;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



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
    
    name: r'value',
    required: true,
    includeIfNull: false,
  )


  final int value;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Discount &&
      other.createdAt == createdAt &&
      other.dtype == dtype &&
      other.id == id &&
      other.isActive == isActive &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.orgId == orgId &&
      other.updatedAt == updatedAt &&
      other.value == value;

    @override
    int get hashCode =>
        createdAt.hashCode +
        dtype.hashCode +
        id.hashCode +
        isActive.hashCode +
        name.hashCode +
        nameTranslations.hashCode +
        orgId.hashCode +
        updatedAt.hashCode +
        value.hashCode;

  factory Discount.fromJson(Map<String, dynamic> json) => _$DiscountFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

