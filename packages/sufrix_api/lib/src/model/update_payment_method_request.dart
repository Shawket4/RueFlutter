//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_payment_method_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdatePaymentMethodRequest {
  /// Returns a new [UpdatePaymentMethodRequest] instance.
  UpdatePaymentMethodRequest({

     this.color,

     this.icon,

     this.isActive,

     this.isCash,

     this.labelTranslations,

     this.name,
  });

  @JsonKey(
    
    name: r'color',
    required: false,
    includeIfNull: false,
  )


  final String? color;



  @JsonKey(
    
    name: r'icon',
    required: false,
    includeIfNull: false,
  )


  final String? icon;



  @JsonKey(
    
    name: r'is_active',
    required: false,
    includeIfNull: false,
  )


  final bool? isActive;



  @JsonKey(
    
    name: r'is_cash',
    required: false,
    includeIfNull: false,
  )


  final bool? isCash;



  @JsonKey(
    
    name: r'label_translations',
    required: false,
    includeIfNull: false,
  )


  final Map<String, String>? labelTranslations;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpdatePaymentMethodRequest &&
      other.color == color &&
      other.icon == icon &&
      other.isActive == isActive &&
      other.isCash == isCash &&
      other.labelTranslations == labelTranslations &&
      other.name == name;

    @override
    int get hashCode =>
        (color == null ? 0 : color.hashCode) +
        (icon == null ? 0 : icon.hashCode) +
        (isActive == null ? 0 : isActive.hashCode) +
        (isCash == null ? 0 : isCash.hashCode) +
        labelTranslations.hashCode +
        (name == null ? 0 : name.hashCode);

  factory UpdatePaymentMethodRequest.fromJson(Map<String, dynamic> json) => _$UpdatePaymentMethodRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePaymentMethodRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

