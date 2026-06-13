//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_inventory_item.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BranchInventoryItem {
  /// Returns a new [BranchInventoryItem] instance.
  BranchInventoryItem({

    required  this.belowReorder,

    required  this.branchId,

     this.costPerUnit,

    required  this.createdAt,

    required  this.currentStock,

     this.description,

    required  this.id,

    required  this.ingredientName,

     this.lastCountedAt,

    required  this.orgIngredientId,

    required  this.reorderThreshold,

    required  this.unit,

    required  this.updatedAt,
  });

  @JsonKey(
    
    name: r'below_reorder',
    required: true,
    includeIfNull: false,
  )


  final bool belowReorder;



  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



      /// Piastres per unit; `null` ⟺ cost never entered.
  @JsonKey(
    
    name: r'cost_per_unit',
    required: false,
    includeIfNull: false,
  )


  final double? costPerUnit;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'current_stock',
    required: true,
    includeIfNull: false,
  )


  final double currentStock;



  @JsonKey(
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



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



      /// When this item was last reconciled by a finalized stock count; `null` = never counted. Drives the \"count due\" signal on the inventory home.
  @JsonKey(
    
    name: r'last_counted_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? lastCountedAt;



  @JsonKey(
    
    name: r'org_ingredient_id',
    required: true,
    includeIfNull: false,
  )


  final String orgIngredientId;



  @JsonKey(
    
    name: r'reorder_threshold',
    required: true,
    includeIfNull: false,
  )


  final double reorderThreshold;



  @JsonKey(
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;



  @JsonKey(
    
    name: r'updated_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime updatedAt;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BranchInventoryItem &&
      other.belowReorder == belowReorder &&
      other.branchId == branchId &&
      other.costPerUnit == costPerUnit &&
      other.createdAt == createdAt &&
      other.currentStock == currentStock &&
      other.description == description &&
      other.id == id &&
      other.ingredientName == ingredientName &&
      other.lastCountedAt == lastCountedAt &&
      other.orgIngredientId == orgIngredientId &&
      other.reorderThreshold == reorderThreshold &&
      other.unit == unit &&
      other.updatedAt == updatedAt;

    @override
    int get hashCode =>
        belowReorder.hashCode +
        branchId.hashCode +
        (costPerUnit == null ? 0 : costPerUnit.hashCode) +
        createdAt.hashCode +
        currentStock.hashCode +
        (description == null ? 0 : description.hashCode) +
        id.hashCode +
        ingredientName.hashCode +
        (lastCountedAt == null ? 0 : lastCountedAt.hashCode) +
        orgIngredientId.hashCode +
        reorderThreshold.hashCode +
        unit.hashCode +
        updatedAt.hashCode;

  factory BranchInventoryItem.fromJson(Map<String, dynamic> json) => _$BranchInventoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$BranchInventoryItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

