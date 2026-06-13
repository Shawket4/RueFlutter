//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'po_line_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class POLineInput {
  /// Returns a new [POLineInput] instance.
  POLineInput({

    required  this.orgIngredientId,

    required  this.purchaseUnit,

    required  this.quantityOrdered,

    required  this.unitCost,

     this.unitsPerPurchaseUnit,
  });

  @JsonKey(
    
    name: r'org_ingredient_id',
    required: true,
    includeIfNull: false,
  )


  final String orgIngredientId;



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



      /// Piastres per purchase unit.
  @JsonKey(
    
    name: r'unit_cost',
    required: true,
    includeIfNull: false,
  )


  final int unitCost;



      /// Stock units per purchase unit. Ignored when `purchase_unit` is a known inventory unit (the factor is derived from the ingredient's base unit).
  @JsonKey(
    
    name: r'units_per_purchase_unit',
    required: false,
    includeIfNull: false,
  )


  final double? unitsPerPurchaseUnit;





    @override
    bool operator ==(Object other) => identical(this, other) || other is POLineInput &&
      other.orgIngredientId == orgIngredientId &&
      other.purchaseUnit == purchaseUnit &&
      other.quantityOrdered == quantityOrdered &&
      other.unitCost == unitCost &&
      other.unitsPerPurchaseUnit == unitsPerPurchaseUnit;

    @override
    int get hashCode =>
        orgIngredientId.hashCode +
        purchaseUnit.hashCode +
        quantityOrdered.hashCode +
        unitCost.hashCode +
        (unitsPerPurchaseUnit == null ? 0 : unitsPerPurchaseUnit.hashCode);

  factory POLineInput.fromJson(Map<String, dynamic> json) => _$POLineInputFromJson(json);

  Map<String, dynamic> toJson() => _$POLineInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

