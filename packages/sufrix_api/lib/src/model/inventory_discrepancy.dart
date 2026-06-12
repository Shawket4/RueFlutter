//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inventory_discrepancy.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InventoryDiscrepancy {
  /// Returns a new [InventoryDiscrepancy] instance.
  InventoryDiscrepancy({

     this.actualCount,

    required  this.branchInventoryId,

     this.discrepancy,

    required  this.expectedStock,

    required  this.ingredientName,

     this.note,

    required  this.unit,
  });

  @JsonKey(
    
    name: r'actual_count',
    required: false,
    includeIfNull: false,
  )


  final double? actualCount;



  @JsonKey(
    
    name: r'branch_inventory_id',
    required: true,
    includeIfNull: false,
  )


  final String branchInventoryId;



  @JsonKey(
    
    name: r'discrepancy',
    required: false,
    includeIfNull: false,
  )


  final double? discrepancy;



  @JsonKey(
    
    name: r'expected_stock',
    required: true,
    includeIfNull: false,
  )


  final double expectedStock;



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
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;





    @override
    bool operator ==(Object other) => identical(this, other) || other is InventoryDiscrepancy &&
      other.actualCount == actualCount &&
      other.branchInventoryId == branchInventoryId &&
      other.discrepancy == discrepancy &&
      other.expectedStock == expectedStock &&
      other.ingredientName == ingredientName &&
      other.note == note &&
      other.unit == unit;

    @override
    int get hashCode =>
        (actualCount == null ? 0 : actualCount.hashCode) +
        branchInventoryId.hashCode +
        (discrepancy == null ? 0 : discrepancy.hashCode) +
        expectedStock.hashCode +
        ingredientName.hashCode +
        (note == null ? 0 : note.hashCode) +
        unit.hashCode;

  factory InventoryDiscrepancy.fromJson(Map<String, dynamic> json) => _$InventoryDiscrepancyFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryDiscrepancyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

