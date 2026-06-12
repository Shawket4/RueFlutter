//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_inventory_adjustment.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BranchInventoryAdjustment {
  /// Returns a new [BranchInventoryAdjustment] instance.
  BranchInventoryAdjustment({

    required  this.adjustedBy,

    required  this.adjustedByName,

    required  this.adjustmentType,

    required  this.branchId,

    required  this.branchInventoryId,

    required  this.createdAt,

    required  this.id,

    required  this.ingredientName,

    required  this.note,

    required  this.quantity,

     this.transferId,

    required  this.unit,
  });

  @JsonKey(
    
    name: r'adjusted_by',
    required: true,
    includeIfNull: false,
  )


  final String adjustedBy;



  @JsonKey(
    
    name: r'adjusted_by_name',
    required: true,
    includeIfNull: false,
  )


  final String adjustedByName;



  @JsonKey(
    
    name: r'adjustment_type',
    required: true,
    includeIfNull: false,
  )


  final String adjustmentType;



  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



  @JsonKey(
    
    name: r'branch_inventory_id',
    required: true,
    includeIfNull: false,
  )


  final String branchInventoryId;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



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
    required: true,
    includeIfNull: false,
  )


  final String note;



  @JsonKey(
    
    name: r'quantity',
    required: true,
    includeIfNull: false,
  )


  final double quantity;



  @JsonKey(
    
    name: r'transfer_id',
    required: false,
    includeIfNull: false,
  )


  final String? transferId;



  @JsonKey(
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BranchInventoryAdjustment &&
      other.adjustedBy == adjustedBy &&
      other.adjustedByName == adjustedByName &&
      other.adjustmentType == adjustmentType &&
      other.branchId == branchId &&
      other.branchInventoryId == branchInventoryId &&
      other.createdAt == createdAt &&
      other.id == id &&
      other.ingredientName == ingredientName &&
      other.note == note &&
      other.quantity == quantity &&
      other.transferId == transferId &&
      other.unit == unit;

    @override
    int get hashCode =>
        adjustedBy.hashCode +
        adjustedByName.hashCode +
        adjustmentType.hashCode +
        branchId.hashCode +
        branchInventoryId.hashCode +
        createdAt.hashCode +
        id.hashCode +
        ingredientName.hashCode +
        note.hashCode +
        quantity.hashCode +
        (transferId == null ? 0 : transferId.hashCode) +
        unit.hashCode;

  factory BranchInventoryAdjustment.fromJson(Map<String, dynamic> json) => _$BranchInventoryAdjustmentFromJson(json);

  Map<String, dynamic> toJson() => _$BranchInventoryAdjustmentToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

