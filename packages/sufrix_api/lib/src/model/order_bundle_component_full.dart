//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/order_bundle_component_addon.dart';
import 'package:sufrix_api/src/model/order_bundle_component_optional.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_bundle_component_full.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderBundleComponentFull {
  /// Returns a new [OrderBundleComponentFull] instance.
  OrderBundleComponentFull({

    required  this.addons,

    required  this.itemId,

    required  this.itemName,

    required  this.nameTranslations,

    required  this.optionals,

    required  this.quantity,

     this.sizeLabel,
  });

  @JsonKey(
    
    name: r'addons',
    required: true,
    includeIfNull: false,
  )


  final List<OrderBundleComponentAddon> addons;



  @JsonKey(
    
    name: r'item_id',
    required: true,
    includeIfNull: false,
  )


  final String itemId;



  @JsonKey(
    
    name: r'item_name',
    required: true,
    includeIfNull: false,
  )


  final String itemName;



  @JsonKey(
    
    name: r'name_translations',
    required: true,
    includeIfNull: false,
  )


  final Object nameTranslations;



  @JsonKey(
    
    name: r'optionals',
    required: true,
    includeIfNull: false,
  )


  final List<OrderBundleComponentOptional> optionals;



  @JsonKey(
    
    name: r'quantity',
    required: true,
    includeIfNull: false,
  )


  final int quantity;



  @JsonKey(
    
    name: r'size_label',
    required: false,
    includeIfNull: false,
  )


  final String? sizeLabel;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrderBundleComponentFull &&
      other.addons == addons &&
      other.itemId == itemId &&
      other.itemName == itemName &&
      other.nameTranslations == nameTranslations &&
      other.optionals == optionals &&
      other.quantity == quantity &&
      other.sizeLabel == sizeLabel;

    @override
    int get hashCode =>
        addons.hashCode +
        itemId.hashCode +
        itemName.hashCode +
        nameTranslations.hashCode +
        optionals.hashCode +
        quantity.hashCode +
        (sizeLabel == null ? 0 : sizeLabel.hashCode);

  factory OrderBundleComponentFull.fromJson(Map<String, dynamic> json) => _$OrderBundleComponentFullFromJson(json);

  Map<String, dynamic> toJson() => _$OrderBundleComponentFullToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

