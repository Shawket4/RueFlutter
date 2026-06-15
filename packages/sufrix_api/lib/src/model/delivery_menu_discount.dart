//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_menu_discount.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DeliveryMenuDiscount {
  /// Returns a new [DeliveryMenuDiscount] instance.
  DeliveryMenuDiscount({

    required  this.dtype,

    required  this.id,

    required  this.name,

    required  this.nameTranslations,

    required  this.value,
  });

      /// \"percentage\" | \"fixed\".
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



      /// Percentage points (0-100) for `percentage`; piastres for `fixed`.
  @JsonKey(
    
    name: r'value',
    required: true,
    includeIfNull: false,
  )


  final int value;





    @override
    bool operator ==(Object other) => identical(this, other) || other is DeliveryMenuDiscount &&
      other.dtype == dtype &&
      other.id == id &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.value == value;

    @override
    int get hashCode =>
        dtype.hashCode +
        id.hashCode +
        name.hashCode +
        nameTranslations.hashCode +
        value.hashCode;

  factory DeliveryMenuDiscount.fromJson(Map<String, dynamic> json) => _$DeliveryMenuDiscountFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryMenuDiscountToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

