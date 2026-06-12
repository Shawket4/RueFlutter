//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_bundle_component_optional.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderBundleComponentOptional {
  /// Returns a new [OrderBundleComponentOptional] instance.
  OrderBundleComponentOptional({

    required  this.componentItemId,

    required  this.fieldName,

    required  this.id,

    required  this.nameTranslations,

     this.optionalFieldId,

    required  this.orderLineId,

    required  this.price,
  });

  @JsonKey(
    
    name: r'component_item_id',
    required: true,
    includeIfNull: false,
  )


  final String componentItemId;



  @JsonKey(
    
    name: r'field_name',
    required: true,
    includeIfNull: false,
  )


  final String fieldName;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'name_translations',
    required: true,
    includeIfNull: false,
  )


  final Object nameTranslations;



  @JsonKey(
    
    name: r'optional_field_id',
    required: false,
    includeIfNull: false,
  )


  final String? optionalFieldId;



  @JsonKey(
    
    name: r'order_line_id',
    required: true,
    includeIfNull: false,
  )


  final String orderLineId;



  @JsonKey(
    
    name: r'price',
    required: true,
    includeIfNull: false,
  )


  final int price;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrderBundleComponentOptional &&
      other.componentItemId == componentItemId &&
      other.fieldName == fieldName &&
      other.id == id &&
      other.nameTranslations == nameTranslations &&
      other.optionalFieldId == optionalFieldId &&
      other.orderLineId == orderLineId &&
      other.price == price;

    @override
    int get hashCode =>
        componentItemId.hashCode +
        fieldName.hashCode +
        id.hashCode +
        nameTranslations.hashCode +
        (optionalFieldId == null ? 0 : optionalFieldId.hashCode) +
        orderLineId.hashCode +
        price.hashCode;

  factory OrderBundleComponentOptional.fromJson(Map<String, dynamic> json) => _$OrderBundleComponentOptionalFromJson(json);

  Map<String, dynamic> toJson() => _$OrderBundleComponentOptionalToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

