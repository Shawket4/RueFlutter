//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_discount_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateDiscountRequest {
  /// Returns a new [CreateDiscountRequest] instance.
  CreateDiscountRequest({

    required  this.dtype,

     this.isActive,

    required  this.name,

     this.nameTranslations,

    required  this.orgId,

    required  this.value,
  });

  @JsonKey(
    
    name: r'dtype',
    required: true,
    includeIfNull: false,
  )


  final String dtype;



  @JsonKey(
    
    name: r'is_active',
    required: false,
    includeIfNull: false,
  )


  final bool? isActive;



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



  @JsonKey(
    
    name: r'value',
    required: true,
    includeIfNull: false,
  )


  final int value;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateDiscountRequest &&
      other.dtype == dtype &&
      other.isActive == isActive &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.orgId == orgId &&
      other.value == value;

    @override
    int get hashCode =>
        dtype.hashCode +
        (isActive == null ? 0 : isActive.hashCode) +
        name.hashCode +
        (nameTranslations == null ? 0 : nameTranslations.hashCode) +
        orgId.hashCode +
        value.hashCode;

  factory CreateDiscountRequest.fromJson(Map<String, dynamic> json) => _$CreateDiscountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateDiscountRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

