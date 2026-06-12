//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderItem {
  /// Returns a new [OrderItem] instance.
  OrderItem({

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





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrderItem &&
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
      other.unitPrice == unitPrice;

    @override
    int get hashCode =>
        (bundleId == null ? 0 : bundleId.hashCode) +
        (bundleUnitPrice == null ? 0 : bundleUnitPrice.hashCode) +
        costMissing.hashCode +
        (deductionsSnapshot == null ? 0 : deductionsSnapshot.hashCode) +
        id.hashCode +
        itemName.hashCode +
        (lineCost == null ? 0 : lineCost.hashCode) +
        lineTotal.hashCode +
        (menuItemId == null ? 0 : menuItemId.hashCode) +
        nameTranslations.hashCode +
        (notes == null ? 0 : notes.hashCode) +
        orderId.hashCode +
        quantity.hashCode +
        (sizeLabel == null ? 0 : sizeLabel.hashCode) +
        (unitCost == null ? 0 : unitCost.hashCode) +
        unitPrice.hashCode;

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

