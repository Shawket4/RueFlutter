//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/order_bundle_component_full.dart';
import 'package:sufrix_api/src/model/order_item_addon.dart';
import 'package:sufrix_api/src/model/order_item_optional.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item_full.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderItemFull {
  /// Returns a new [OrderItemFull] instance.
  OrderItemFull({

     this.bundleId,

     this.bundleUnitPrice,

    required  this.costMissing,

    required  this.deductionsSnapshot,

    required  this.id,

    required  this.itemName,

     this.lineCost,

    required  this.lineTotal,

     this.menuItemId,

    required  this.nameTranslations,

     this.notes,

    required  this.orderId,

    required  this.quantity,

     this.sizeLabel,

     this.unitCost,

    required  this.unitPrice,

    required  this.addons,

     this.bundleComponents,

    required  this.optionals,
  });

  @JsonKey(
    
    name: r'bundle_id',
    required: false,
    includeIfNull: false,
  )


  final String? bundleId;



  @JsonKey(
    
    name: r'bundle_unit_price',
    required: false,
    includeIfNull: false,
  )


  final int? bundleUnitPrice;



      /// True when any cost component could not be resolved.
  @JsonKey(
    
    name: r'cost_missing',
    required: true,
    includeIfNull: false,
  )


  final bool costMissing;



  @JsonKey(
    
    name: r'deductions_snapshot',
    required: true,
    includeIfNull: true,
  )


  final Object? deductionsSnapshot;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'item_name',
    required: true,
    includeIfNull: false,
  )


  final String itemName;



      /// Full line COGS in piastres (recipe + addons + optionals + components). `null` ⟺ unknown.
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
    
    name: r'menu_item_id',
    required: false,
    includeIfNull: false,
  )


  final String? menuItemId;



  @JsonKey(
    
    name: r'name_translations',
    required: true,
    includeIfNull: false,
  )


  final Object nameTranslations;



  @JsonKey(
    
    name: r'notes',
    required: false,
    includeIfNull: false,
  )


  final String? notes;



  @JsonKey(
    
    name: r'order_id',
    required: true,
    includeIfNull: false,
  )


  final String orderId;



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



      /// Recipe-only cost per unit in piastres (incl. swaps). `null` ⟺ unknown or bundle line.
  @JsonKey(
    
    name: r'unit_cost',
    required: false,
    includeIfNull: false,
  )


  final int? unitCost;



  @JsonKey(
    
    name: r'unit_price',
    required: true,
    includeIfNull: false,
  )


  final int unitPrice;



  @JsonKey(
    
    name: r'addons',
    required: true,
    includeIfNull: false,
  )


  final List<OrderItemAddon> addons;



  @JsonKey(
    
    name: r'bundle_components',
    required: false,
    includeIfNull: false,
  )


  final List<OrderBundleComponentFull>? bundleComponents;



  @JsonKey(
    
    name: r'optionals',
    required: true,
    includeIfNull: false,
  )


  final List<OrderItemOptional> optionals;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrderItemFull &&
      other.bundleId == bundleId &&
      other.bundleUnitPrice == bundleUnitPrice &&
      other.costMissing == costMissing &&
      other.deductionsSnapshot == deductionsSnapshot &&
      other.id == id &&
      other.itemName == itemName &&
      other.lineCost == lineCost &&
      other.lineTotal == lineTotal &&
      other.menuItemId == menuItemId &&
      other.nameTranslations == nameTranslations &&
      other.notes == notes &&
      other.orderId == orderId &&
      other.quantity == quantity &&
      other.sizeLabel == sizeLabel &&
      other.unitCost == unitCost &&
      other.unitPrice == unitPrice &&
      other.addons == addons &&
      other.bundleComponents == bundleComponents &&
      other.optionals == optionals;

    @override
    int get hashCode =>
        bundleId.hashCode +
        bundleUnitPrice.hashCode +
        costMissing.hashCode +
        (deductionsSnapshot == null ? 0 : deductionsSnapshot.hashCode) +
        id.hashCode +
        itemName.hashCode +
        lineCost.hashCode +
        lineTotal.hashCode +
        menuItemId.hashCode +
        nameTranslations.hashCode +
        notes.hashCode +
        orderId.hashCode +
        quantity.hashCode +
        sizeLabel.hashCode +
        unitCost.hashCode +
        unitPrice.hashCode +
        addons.hashCode +
        bundleComponents.hashCode +
        optionals.hashCode;

  factory OrderItemFull.fromJson(Map<String, dynamic> json) => _$OrderItemFullFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemFullToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

