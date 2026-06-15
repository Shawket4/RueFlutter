//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_optional_field.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DeliveryOptionalField {
  /// Returns a new [DeliveryOptionalField] instance.
  DeliveryOptionalField({

    required  this.id,

    required  this.name,

    required  this.nameTranslations,

    required  this.price,

     this.sizeLabel,
  });

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



  @JsonKey(
    
    name: r'price',
    required: true,
    includeIfNull: false,
  )


  final int price;



  @JsonKey(
    
    name: r'size_label',
    required: false,
    includeIfNull: false,
  )


  final String? sizeLabel;





    @override
    bool operator ==(Object other) => identical(this, other) || other is DeliveryOptionalField &&
      other.id == id &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.price == price &&
      other.sizeLabel == sizeLabel;

    @override
    int get hashCode =>
        id.hashCode +
        name.hashCode +
        nameTranslations.hashCode +
        price.hashCode +
        (sizeLabel == null ? 0 : sizeLabel.hashCode);

  factory DeliveryOptionalField.fromJson(Map<String, dynamic> json) => _$DeliveryOptionalFieldFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryOptionalFieldToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

