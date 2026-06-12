//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item_addon.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderItemAddon {
  /// Returns a new [OrderItemAddon] instance.
  OrderItemAddon({

    required  this.addonItemId,

    required  this.addonName,

    required  this.id,

     this.lineCost,

    required  this.lineTotal,

    required  this.nameTranslations,

    required  this.orderItemId,

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
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



      /// Ingredient cost of this addon line in piastres. `null` ⟺ unknown, or a swap addon (its cost lives in the item's recipe cost).
  @JsonKey(
    
    name: r'line_cost',
    required: false,
    includeIfNull: false,
  )


  final int? lineCost;



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
    
    name: r'order_item_id',
    required: true,
    includeIfNull: false,
  )


  final String orderItemId;



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
    bool operator ==(Object other) => identical(this, other) || other is OrderItemAddon &&
      other.addonItemId == addonItemId &&
      other.addonName == addonName &&
      other.id == id &&
      other.lineCost == lineCost &&
      other.lineTotal == lineTotal &&
      other.nameTranslations == nameTranslations &&
      other.orderItemId == orderItemId &&
      other.quantity == quantity &&
      other.unitPrice == unitPrice;

    @override
    int get hashCode =>
        addonItemId.hashCode +
        addonName.hashCode +
        id.hashCode +
        (lineCost == null ? 0 : lineCost.hashCode) +
        lineTotal.hashCode +
        nameTranslations.hashCode +
        orderItemId.hashCode +
        quantity.hashCode +
        unitPrice.hashCode;

  factory OrderItemAddon.fromJson(Map<String, dynamic> json) => _$OrderItemAddonFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemAddonToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

