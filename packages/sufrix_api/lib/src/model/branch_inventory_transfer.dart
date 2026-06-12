//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_inventory_transfer.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BranchInventoryTransfer {
  /// Returns a new [BranchInventoryTransfer] instance.
  BranchInventoryTransfer({

    required  this.destinationBranchId,

    required  this.destinationBranchName,

    required  this.id,

    required  this.ingredientName,

    required  this.initiatedAt,

    required  this.initiatedBy,

    required  this.initiatedByName,

     this.note,

    required  this.orgId,

    required  this.orgIngredientId,

    required  this.quantity,

    required  this.sourceBranchId,

    required  this.sourceBranchName,

    required  this.unit,
  });

  @JsonKey(
    
    name: r'destination_branch_id',
    required: true,
    includeIfNull: false,
  )


  final String destinationBranchId;



  @JsonKey(
    
    name: r'destination_branch_name',
    required: true,
    includeIfNull: false,
  )


  final String destinationBranchName;



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
    
    name: r'initiated_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime initiatedAt;



  @JsonKey(
    
    name: r'initiated_by',
    required: true,
    includeIfNull: false,
  )


  final String initiatedBy;



  @JsonKey(
    
    name: r'initiated_by_name',
    required: true,
    includeIfNull: false,
  )


  final String initiatedByName;



  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;



  @JsonKey(
    
    name: r'org_id',
    required: true,
    includeIfNull: false,
  )


  final String orgId;



  @JsonKey(
    
    name: r'org_ingredient_id',
    required: true,
    includeIfNull: false,
  )


  final String orgIngredientId;



  @JsonKey(
    
    name: r'quantity',
    required: true,
    includeIfNull: false,
  )


  final double quantity;



  @JsonKey(
    
    name: r'source_branch_id',
    required: true,
    includeIfNull: false,
  )


  final String sourceBranchId;



  @JsonKey(
    
    name: r'source_branch_name',
    required: true,
    includeIfNull: false,
  )


  final String sourceBranchName;



  @JsonKey(
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BranchInventoryTransfer &&
      other.destinationBranchId == destinationBranchId &&
      other.destinationBranchName == destinationBranchName &&
      other.id == id &&
      other.ingredientName == ingredientName &&
      other.initiatedAt == initiatedAt &&
      other.initiatedBy == initiatedBy &&
      other.initiatedByName == initiatedByName &&
      other.note == note &&
      other.orgId == orgId &&
      other.orgIngredientId == orgIngredientId &&
      other.quantity == quantity &&
      other.sourceBranchId == sourceBranchId &&
      other.sourceBranchName == sourceBranchName &&
      other.unit == unit;

    @override
    int get hashCode =>
        destinationBranchId.hashCode +
        destinationBranchName.hashCode +
        id.hashCode +
        ingredientName.hashCode +
        initiatedAt.hashCode +
        initiatedBy.hashCode +
        initiatedByName.hashCode +
        (note == null ? 0 : note.hashCode) +
        orgId.hashCode +
        orgIngredientId.hashCode +
        quantity.hashCode +
        sourceBranchId.hashCode +
        sourceBranchName.hashCode +
        unit.hashCode;

  factory BranchInventoryTransfer.fromJson(Map<String, dynamic> json) => _$BranchInventoryTransferFromJson(json);

  Map<String, dynamic> toJson() => _$BranchInventoryTransferToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

