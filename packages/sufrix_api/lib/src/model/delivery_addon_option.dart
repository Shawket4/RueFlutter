//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_addon_option.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DeliveryAddonOption {
  /// Returns a new [DeliveryAddonOption] instance.
  DeliveryAddonOption({

    required  this.addonItemId,

    required  this.isAvailable,

    required  this.name,

    required  this.nameTranslations,

    required  this.price,

    required  this.type,
  });

  @JsonKey(
    
    name: r'addon_item_id',
    required: true,
    includeIfNull: false,
  )


  final String addonItemId;



  @JsonKey(
    
    name: r'is_available',
    required: true,
    includeIfNull: false,
  )


  final bool isAvailable;



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



      /// Channel-effective surcharge (piastres). Always present (resolved here).
  @JsonKey(
    
    name: r'price',
    required: true,
    includeIfNull: false,
  )


  final int price;



      /// `milk_type` | `coffee_type` | `extra` — the option's category.
  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final String type;





    @override
    bool operator ==(Object other) => identical(this, other) || other is DeliveryAddonOption &&
      other.addonItemId == addonItemId &&
      other.isAvailable == isAvailable &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.price == price &&
      other.type == type;

    @override
    int get hashCode =>
        addonItemId.hashCode +
        isAvailable.hashCode +
        name.hashCode +
        nameTranslations.hashCode +
        price.hashCode +
        type.hashCode;

  factory DeliveryAddonOption.fromJson(Map<String, dynamic> json) => _$DeliveryAddonOptionFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryAddonOptionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

