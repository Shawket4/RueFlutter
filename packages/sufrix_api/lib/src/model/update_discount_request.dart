//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_discount_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateDiscountRequest {
  /// Returns a new [UpdateDiscountRequest] instance.
  UpdateDiscountRequest({

     this.dtype,

     this.isActive,

     this.name,

     this.nameTranslations,

     this.value,
  });

  @JsonKey(
    
    name: r'dtype',
    required: false,
    includeIfNull: false,
  )


  final String? dtype;



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



  @JsonKey(
    
    name: r'value',
    required: false,
    includeIfNull: false,
  )


  final int? value;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpdateDiscountRequest &&
      other.dtype == dtype &&
      other.isActive == isActive &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.value == value;

    @override
    int get hashCode =>
        (dtype == null ? 0 : dtype.hashCode) +
        (isActive == null ? 0 : isActive.hashCode) +
        (name == null ? 0 : name.hashCode) +
        (nameTranslations == null ? 0 : nameTranslations.hashCode) +
        (value == null ? 0 : value.hashCode);

  factory UpdateDiscountRequest.fromJson(Map<String, dynamic> json) => _$UpdateDiscountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDiscountRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

