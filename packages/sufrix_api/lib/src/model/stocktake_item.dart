//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stocktake_item.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StocktakeItem {
  /// Returns a new [StocktakeItem] instance.
  StocktakeItem({

     this.branchInventoryId,

     this.countedBy,

     this.countedQty,

    required  this.createdAt,

    required  this.expectedQty,

    required  this.id,

    required  this.ingredientName,

     this.note,

    required  this.orgIngredientId,

    required  this.stocktakeId,

    required  this.unit,

     this.unitCost,

     this.variance,

     this.varianceReason,
  });

  @JsonKey(
    
    name: r'branch_inventory_id',
    required: false,
    includeIfNull: false,
  )


  final String? branchInventoryId;



  @JsonKey(
    
    name: r'counted_by',
    required: false,
    includeIfNull: false,
  )


  final String? countedBy;



  @JsonKey(
    
    name: r'counted_qty',
    required: false,
    includeIfNull: false,
  )


  final double? countedQty;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'expected_qty',
    required: true,
    includeIfNull: false,
  )


  final double expectedQty;



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
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;



  @JsonKey(
    
    name: r'org_ingredient_id',
    required: true,
    includeIfNull: false,
  )


  final String orgIngredientId;



  @JsonKey(
    
    name: r'stocktake_id',
    required: true,
    includeIfNull: false,
  )


  final String stocktakeId;



  @JsonKey(
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;



      /// Piastres per unit snapshot; `null` ⟺ unknown.
  @JsonKey(
    
    name: r'unit_cost',
    required: false,
    includeIfNull: false,
  )


  final int? unitCost;



  @JsonKey(
    
    name: r'variance',
    required: false,
    includeIfNull: false,
  )


  final double? variance;



      /// theft | spoilage | breakage | miscount | supplier_short | transfer_error | other.
  @JsonKey(
    
    name: r'variance_reason',
    required: false,
    includeIfNull: false,
  )


  final String? varianceReason;





    @override
    bool operator ==(Object other) => identical(this, other) || other is StocktakeItem &&
      other.branchInventoryId == branchInventoryId &&
      other.countedBy == countedBy &&
      other.countedQty == countedQty &&
      other.createdAt == createdAt &&
      other.expectedQty == expectedQty &&
      other.id == id &&
      other.ingredientName == ingredientName &&
      other.note == note &&
      other.orgIngredientId == orgIngredientId &&
      other.stocktakeId == stocktakeId &&
      other.unit == unit &&
      other.unitCost == unitCost &&
      other.variance == variance &&
      other.varianceReason == varianceReason;

    @override
    int get hashCode =>
        (branchInventoryId == null ? 0 : branchInventoryId.hashCode) +
        (countedBy == null ? 0 : countedBy.hashCode) +
        (countedQty == null ? 0 : countedQty.hashCode) +
        createdAt.hashCode +
        expectedQty.hashCode +
        id.hashCode +
        ingredientName.hashCode +
        (note == null ? 0 : note.hashCode) +
        orgIngredientId.hashCode +
        stocktakeId.hashCode +
        unit.hashCode +
        (unitCost == null ? 0 : unitCost.hashCode) +
        (variance == null ? 0 : variance.hashCode) +
        (varianceReason == null ? 0 : varianceReason.hashCode);

  factory StocktakeItem.fromJson(Map<String, dynamic> json) => _$StocktakeItemFromJson(json);

  Map<String, dynamic> toJson() => _$StocktakeItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

