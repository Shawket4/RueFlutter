//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'purchase_order_line.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PurchaseOrderLine {
  /// Returns a new [PurchaseOrderLine] instance.
  PurchaseOrderLine({

    required  this.id,

    required  this.ingredientName,

    required  this.orgIngredientId,

    required  this.purchaseOrderId,

    required  this.purchaseUnit,

    required  this.quantityOrdered,

    required  this.quantityReceived,

    required  this.unit,

    required  this.unitCost,

    required  this.unitsPerPurchaseUnit,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'ingredient_name',
    required: true,
    includeIfNull: false,
  )


  final String ingredientName;



  @JsonKey(
    
    name: r'org_ingredient_id',
    required: true,
    includeIfNull: false,
  )


  final String orgIngredientId;



  @JsonKey(
    
    name: r'purchase_order_id',
    required: true,
    includeIfNull: false,
  )


  final String purchaseOrderId;



  @JsonKey(
    
    name: r'purchase_unit',
    required: true,
    includeIfNull: false,
  )


  final String purchaseUnit;



  @JsonKey(
    
    name: r'quantity_ordered',
    required: true,
    includeIfNull: false,
  )


  final double quantityOrdered;



  @JsonKey(
    
    name: r'quantity_received',
    required: true,
    includeIfNull: false,
  )


  final double quantityReceived;



      /// Ingredient's base stock unit.
  @JsonKey(
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;



      /// Piastres per PURCHASE unit.
  @JsonKey(
    
    name: r'unit_cost',
    required: true,
    includeIfNull: false,
  )


  final int unitCost;



  @JsonKey(
    
    name: r'units_per_purchase_unit',
    required: true,
    includeIfNull: false,
  )


  final double unitsPerPurchaseUnit;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PurchaseOrderLine &&
      other.id == id &&
      other.ingredientName == ingredientName &&
      other.orgIngredientId == orgIngredientId &&
      other.purchaseOrderId == purchaseOrderId &&
      other.purchaseUnit == purchaseUnit &&
      other.quantityOrdered == quantityOrdered &&
      other.quantityReceived == quantityReceived &&
      other.unit == unit &&
      other.unitCost == unitCost &&
      other.unitsPerPurchaseUnit == unitsPerPurchaseUnit;

    @override
    int get hashCode =>
        id.hashCode +
        ingredientName.hashCode +
        orgIngredientId.hashCode +
        purchaseOrderId.hashCode +
        purchaseUnit.hashCode +
        quantityOrdered.hashCode +
        quantityReceived.hashCode +
        unit.hashCode +
        unitCost.hashCode +
        unitsPerPurchaseUnit.hashCode;

  factory PurchaseOrderLine.fromJson(Map<String, dynamic> json) => _$PurchaseOrderLineFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseOrderLineToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

