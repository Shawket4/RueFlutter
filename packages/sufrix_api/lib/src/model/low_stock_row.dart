//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'low_stock_row.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LowStockRow {
  /// Returns a new [LowStockRow] instance.
  LowStockRow({

    required  this.branchId,

    required  this.branchName,

    required  this.currentStock,

    required  this.deficit,

    required  this.ingredientName,

    required  this.orgIngredientId,

    required  this.reorderThreshold,

     this.supplierId,

     this.supplierName,

    required  this.unit,
  });

  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



  @JsonKey(
    
    name: r'branch_name',
    required: true,
    includeIfNull: false,
  )


  final String branchName;



  @JsonKey(
    
    name: r'current_stock',
    required: true,
    includeIfNull: false,
  )


  final double currentStock;



      /// reorder_threshold − current_stock: how much to order to reach par.
  @JsonKey(
    
    name: r'deficit',
    required: true,
    includeIfNull: false,
  )


  final double deficit;



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
    
    name: r'reorder_threshold',
    required: true,
    includeIfNull: false,
  )


  final double reorderThreshold;



      /// Default supplier for this ingredient (for one-click \"create PO\"); may be null.
  @JsonKey(
    
    name: r'supplier_id',
    required: false,
    includeIfNull: false,
  )


  final String? supplierId;



  @JsonKey(
    
    name: r'supplier_name',
    required: false,
    includeIfNull: false,
  )


  final String? supplierName;



  @JsonKey(
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;





    @override
    bool operator ==(Object other) => identical(this, other) || other is LowStockRow &&
      other.branchId == branchId &&
      other.branchName == branchName &&
      other.currentStock == currentStock &&
      other.deficit == deficit &&
      other.ingredientName == ingredientName &&
      other.orgIngredientId == orgIngredientId &&
      other.reorderThreshold == reorderThreshold &&
      other.supplierId == supplierId &&
      other.supplierName == supplierName &&
      other.unit == unit;

    @override
    int get hashCode =>
        branchId.hashCode +
        branchName.hashCode +
        currentStock.hashCode +
        deficit.hashCode +
        ingredientName.hashCode +
        orgIngredientId.hashCode +
        reorderThreshold.hashCode +
        (supplierId == null ? 0 : supplierId.hashCode) +
        (supplierName == null ? 0 : supplierName.hashCode) +
        unit.hashCode;

  factory LowStockRow.fromJson(Map<String, dynamic> json) => _$LowStockRowFromJson(json);

  Map<String, dynamic> toJson() => _$LowStockRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

