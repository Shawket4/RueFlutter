//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_inventory_movement.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BranchInventoryMovement {
  /// Returns a new [BranchInventoryMovement] instance.
  BranchInventoryMovement({

     this.balanceAfter,

    required  this.belowZero,

    required  this.branchId,

     this.branchInventoryId,

     this.branchName,

    required  this.createdAt,

     this.createdBy,

     this.createdByName,

    required  this.id,

    required  this.ingredientName,

    required  this.movementType,

     this.note,

    required  this.orgIngredientId,

    required  this.quantity,

     this.reason,

     this.sourceId,

     this.sourceType,

    required  this.unit,

     this.unitCost,
  });

  @JsonKey(
    
    name: r'balance_after',
    required: false,
    includeIfNull: false,
  )


  final double? balanceAfter;



  @JsonKey(
    
    name: r'below_zero',
    required: true,
    includeIfNull: false,
  )


  final bool belowZero;



  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



  @JsonKey(
    
    name: r'branch_inventory_id',
    required: false,
    includeIfNull: false,
  )


  final String? branchInventoryId;



      /// Branch name; only populated by the all-branches waste roll-up (nil {branch_id}). `None` for single-branch queries that do not select it.
  @JsonKey(
    
    name: r'branch_name',
    required: false,
    includeIfNull: false,
  )


  final String? branchName;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'created_by',
    required: false,
    includeIfNull: false,
  )


  final String? createdBy;



  @JsonKey(
    
    name: r'created_by_name',
    required: false,
    includeIfNull: false,
  )


  final String? createdByName;



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



      /// inventory_movement_type: sale | void_restock | adjustment_add | adjustment_remove | waste | transfer_out | transfer_in | purchase_in | stock_count
  @JsonKey(
    
    name: r'movement_type',
    required: true,
    includeIfNull: false,
  )


  final String movementType;



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



      /// Signed delta applied to stock (consumption negative, replenishment positive).
  @JsonKey(
    
    name: r'quantity',
    required: true,
    includeIfNull: false,
  )


  final double quantity;



  @JsonKey(
    
    name: r'reason',
    required: false,
    includeIfNull: false,
  )


  final String? reason;



  @JsonKey(
    
    name: r'source_id',
    required: false,
    includeIfNull: false,
  )


  final String? sourceId;



  @JsonKey(
    
    name: r'source_type',
    required: false,
    includeIfNull: false,
  )


  final String? sourceType;



  @JsonKey(
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;



      /// Piastres per unit at movement time; `null` ⟺ unknown.
  @JsonKey(
    
    name: r'unit_cost',
    required: false,
    includeIfNull: false,
  )


  final int? unitCost;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BranchInventoryMovement &&
      other.balanceAfter == balanceAfter &&
      other.belowZero == belowZero &&
      other.branchId == branchId &&
      other.branchInventoryId == branchInventoryId &&
      other.branchName == branchName &&
      other.createdAt == createdAt &&
      other.createdBy == createdBy &&
      other.createdByName == createdByName &&
      other.id == id &&
      other.ingredientName == ingredientName &&
      other.movementType == movementType &&
      other.note == note &&
      other.orgIngredientId == orgIngredientId &&
      other.quantity == quantity &&
      other.reason == reason &&
      other.sourceId == sourceId &&
      other.sourceType == sourceType &&
      other.unit == unit &&
      other.unitCost == unitCost;

    @override
    int get hashCode =>
        (balanceAfter == null ? 0 : balanceAfter.hashCode) +
        belowZero.hashCode +
        branchId.hashCode +
        (branchInventoryId == null ? 0 : branchInventoryId.hashCode) +
        (branchName == null ? 0 : branchName.hashCode) +
        createdAt.hashCode +
        (createdBy == null ? 0 : createdBy.hashCode) +
        (createdByName == null ? 0 : createdByName.hashCode) +
        id.hashCode +
        ingredientName.hashCode +
        movementType.hashCode +
        (note == null ? 0 : note.hashCode) +
        orgIngredientId.hashCode +
        quantity.hashCode +
        (reason == null ? 0 : reason.hashCode) +
        (sourceId == null ? 0 : sourceId.hashCode) +
        (sourceType == null ? 0 : sourceType.hashCode) +
        unit.hashCode +
        (unitCost == null ? 0 : unitCost.hashCode);

  factory BranchInventoryMovement.fromJson(Map<String, dynamic> json) => _$BranchInventoryMovementFromJson(json);

  Map<String, dynamic> toJson() => _$BranchInventoryMovementToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

