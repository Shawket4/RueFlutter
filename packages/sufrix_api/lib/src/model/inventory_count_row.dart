//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inventory_count_row.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InventoryCountRow {
  /// Returns a new [InventoryCountRow] instance.
  InventoryCountRow({

    required  this.actualStock,

    required  this.branchInventoryId,

    required  this.discrepancy,

    required  this.expectedStock,

    required  this.ingredientName,

    required  this.isSuspicious,

     this.note,

    required  this.unit,
  });

  @JsonKey(
    
    name: r'actual_stock',
    required: true,
    includeIfNull: false,
  )


  final double actualStock;



  @JsonKey(
    
    name: r'branch_inventory_id',
    required: true,
    includeIfNull: false,
  )


  final String branchInventoryId;



  @JsonKey(
    
    name: r'discrepancy',
    required: true,
    includeIfNull: false,
  )


  final double discrepancy;



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
    
    name: r'is_suspicious',
    required: true,
    includeIfNull: false,
  )


  final bool isSuspicious;



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
    bool operator ==(Object other) => identical(this, other) || other is InventoryCountRow &&
      other.actualStock == actualStock &&
      other.branchInventoryId == branchInventoryId &&
      other.discrepancy == discrepancy &&
      other.expectedStock == expectedStock &&
      other.ingredientName == ingredientName &&
      other.isSuspicious == isSuspicious &&
      other.note == note &&
      other.unit == unit;

    @override
    int get hashCode =>
        actualStock.hashCode +
        branchInventoryId.hashCode +
        discrepancy.hashCode +
        expectedStock.hashCode +
        ingredientName.hashCode +
        isSuspicious.hashCode +
        (note == null ? 0 : note.hashCode) +
        unit.hashCode;

  factory InventoryCountRow.fromJson(Map<String, dynamic> json) => _$InventoryCountRowFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryCountRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

