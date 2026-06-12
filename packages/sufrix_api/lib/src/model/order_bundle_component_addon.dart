//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_bundle_component_addon.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderBundleComponentAddon {
  /// Returns a new [OrderBundleComponentAddon] instance.
  OrderBundleComponentAddon({

    required  this.addonItemId,

    required  this.addonName,

    required  this.componentItemId,

    required  this.id,

    required  this.lineTotal,

    required  this.nameTranslations,

    required  this.orderLineId,

    required  this.quantity,

    required  this.unitPrice,
  });

  @JsonKey(
    
    name: r'addon_item_id',
    required: true,
    includeIfNull: false,
  )


  final String addonItemId;



  @JsonKey(
    
    name: r'addon_name',
    required: true,
    includeIfNull: false,
  )


  final String addonName;



  @JsonKey(
    
    name: r'component_item_id',
    required: true,
    includeIfNull: false,
  )


  final String componentItemId;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'line_total',
    required: true,
    includeIfNull: false,
  )


  final int lineTotal;



  @JsonKey(
    
    name: r'name_translations',
    required: true,
    includeIfNull: false,
  )


  final Object nameTranslations;



  @JsonKey(
    
    name: r'order_line_id',
    required: true,
    includeIfNull: false,
  )


  final String orderLineId;



  @JsonKey(
    
    name: r'quantity',
    required: true,
    includeIfNull: false,
  )


  final int quantity;



  @JsonKey(
    
    name: r'unit_price',
    required: true,
    includeIfNull: false,
  )


  final int unitPrice;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrderBundleComponentAddon &&
      other.addonItemId == addonItemId &&
      other.addonName == addonName &&
      other.componentItemId == componentItemId &&
      other.id == id &&
      other.lineTotal == lineTotal &&
      other.nameTranslations == nameTranslations &&
      other.orderLineId == orderLineId &&
      other.quantity == quantity &&
      other.unitPrice == unitPrice;

    @override
    int get hashCode =>
        addonItemId.hashCode +
        addonName.hashCode +
        componentItemId.hashCode +
        id.hashCode +
        lineTotal.hashCode +
        nameTranslations.hashCode +
        orderLineId.hashCode +
        quantity.hashCode +
        unitPrice.hashCode;

  factory OrderBundleComponentAddon.fromJson(Map<String, dynamic> json) => _$OrderBundleComponentAddonFromJson(json);

  Map<String, dynamic> toJson() => _$OrderBundleComponentAddonToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

