//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_payment_method_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreatePaymentMethodRequest {
  /// Returns a new [CreatePaymentMethodRequest] instance.
  CreatePaymentMethodRequest({

    required  this.color,

    required  this.icon,

     this.isActive,

    required  this.isCash,

    required  this.labelTranslations,

    required  this.name,
  });

  @JsonKey(
    
    name: r'color',
    required: true,
    includeIfNull: false,
  )


  final String color;



  @JsonKey(
    
    name: r'icon',
    required: true,
    includeIfNull: false,
  )


  final String icon;



  @JsonKey(
    
    name: r'is_active',
    required: false,
    includeIfNull: false,
  )


  final bool? isActive;



  @JsonKey(
    
    name: r'is_cash',
    required: true,
    includeIfNull: false,
  )


  final bool isCash;



  @JsonKey(
    
    name: r'label_translations',
    required: true,
    includeIfNull: false,
  )


  final Map<String, String> labelTranslations;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreatePaymentMethodRequest &&
      other.color == color &&
      other.icon == icon &&
      other.isActive == isActive &&
      other.isCash == isCash &&
      other.labelTranslations == labelTranslations &&
      other.name == name;

    @override
    int get hashCode =>
        color.hashCode +
        icon.hashCode +
        (isActive == null ? 0 : isActive.hashCode) +
        isCash.hashCode +
        labelTranslations.hashCode +
        name.hashCode;

  factory CreatePaymentMethodRequest.fromJson(Map<String, dynamic> json) => _$CreatePaymentMethodRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePaymentMethodRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

