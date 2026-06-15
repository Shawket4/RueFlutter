//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/delivery_menu_category.dart';
import 'package:sufrix_api/src/model/delivery_addon_option.dart';
import 'package:sufrix_api/src/model/delivery_menu_discount.dart';
import 'package:sufrix_api/src/model/delivery_menu_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_menu.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DeliveryMenu {
  /// Returns a new [DeliveryMenu] instance.
  DeliveryMenu({

    required  this.addons,

    required  this.categories,

     this.discount,

    required  this.items,
  });

      /// Org-wide addon catalog (global, POS model): channel-effective, grouped by `type`, applicable to every item. Channel-unavailable options are excluded.
  @JsonKey(
    
    name: r'addons',
    required: true,
    includeIfNull: false,
  )


  final List<DeliveryAddonOption> addons;



  @JsonKey(
    
    name: r'categories',
    required: true,
    includeIfNull: false,
  )


  final List<DeliveryMenuCategory> categories;



      /// The active discount for this channel (customer-facing) or `null`. Applies to the item subtotal only — the delivery fee is always charged in full.
  @JsonKey(
    
    name: r'discount',
    required: false,
    includeIfNull: false,
  )


  final DeliveryMenuDiscount? discount;



  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<DeliveryMenuItem> items;





    @override
    bool operator ==(Object other) => identical(this, other) || other is DeliveryMenu &&
      other.addons == addons &&
      other.categories == categories &&
      other.discount == discount &&
      other.items == items;

    @override
    int get hashCode =>
        addons.hashCode +
        categories.hashCode +
        (discount == null ? 0 : discount.hashCode) +
        items.hashCode;

  factory DeliveryMenu.fromJson(Map<String, dynamic> json) => _$DeliveryMenuFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryMenuToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

