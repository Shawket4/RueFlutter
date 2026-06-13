//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'org_payment_method.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrgPaymentMethod {
  /// Returns a new [OrgPaymentMethod] instance.
  OrgPaymentMethod({

    required  this.color,

    required  this.createdAt,

    required  this.icon,

    required  this.id,

    required  this.isActive,

    required  this.isCash,

    required  this.labelTranslations,

    required  this.name,

    required  this.orgId,

    required  this.updatedAt,
  });

  @JsonKey(
    
    name: r'color',
    required: true,
    includeIfNull: false,
  )


  final String color;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'icon',
    required: true,
    includeIfNull: false,
  )


  final String icon;



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
    
    name: r'is_cash',
    required: true,
    includeIfNull: false,
  )


  final bool isCash;



  @JsonKey(
    
    name: r'label_translations',
    required: true,
    includeIfNull: true,
  )


  final Object? labelTranslations;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



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
    bool operator ==(Object other) => identical(this, other) || other is OrgPaymentMethod &&
      other.color == color &&
      other.createdAt == createdAt &&
      other.icon == icon &&
      other.id == id &&
      other.isActive == isActive &&
      other.isCash == isCash &&
      other.labelTranslations == labelTranslations &&
      other.name == name &&
      other.orgId == orgId &&
      other.updatedAt == updatedAt;

    @override
    int get hashCode =>
        color.hashCode +
        createdAt.hashCode +
        icon.hashCode +
        id.hashCode +
        isActive.hashCode +
        isCash.hashCode +
        (labelTranslations == null ? 0 : labelTranslations.hashCode) +
        name.hashCode +
        orgId.hashCode +
        updatedAt.hashCode;

  factory OrgPaymentMethod.fromJson(Map<String, dynamic> json) => _$OrgPaymentMethodFromJson(json);

  Map<String, dynamic> toJson() => _$OrgPaymentMethodToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

