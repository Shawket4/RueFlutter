//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'deduction_log_row.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DeductionLogRow {
  /// Returns a new [DeductionLogRow] instance.
  DeductionLogRow({

    required  this.createdAt,

    required  this.id,

    required  this.inventoryItemId,

    required  this.itemName,

     this.orderId,

     this.orderItemId,

    required  this.quantityDeducted,

    required  this.source_,

    required  this.unit,
  });

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
    
    name: r'inventory_item_id',
    required: true,
    includeIfNull: false,
  )


  final String inventoryItemId;



  @JsonKey(
    
    name: r'item_name',
    required: true,
    includeIfNull: false,
  )


  final String itemName;



  @JsonKey(
    
    name: r'order_id',
    required: false,
    includeIfNull: false,
  )


  final String? orderId;



  @JsonKey(
    
    name: r'order_item_id',
    required: false,
    includeIfNull: false,
  )


  final String? orderItemId;



  @JsonKey(
    
    name: r'quantity_deducted',
    required: true,
    includeIfNull: false,
  )


  final double quantityDeducted;



  @JsonKey(
    
    name: r'source',
    required: true,
    includeIfNull: false,
  )


  final String source_;



  @JsonKey(
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;





    @override
    bool operator ==(Object other) => identical(this, other) || other is DeductionLogRow &&
      other.createdAt == createdAt &&
      other.id == id &&
      other.inventoryItemId == inventoryItemId &&
      other.itemName == itemName &&
      other.orderId == orderId &&
      other.orderItemId == orderItemId &&
      other.quantityDeducted == quantityDeducted &&
      other.source_ == source_ &&
      other.unit == unit;

    @override
    int get hashCode =>
        createdAt.hashCode +
        id.hashCode +
        inventoryItemId.hashCode +
        itemName.hashCode +
        (orderId == null ? 0 : orderId.hashCode) +
        (orderItemId == null ? 0 : orderItemId.hashCode) +
        quantityDeducted.hashCode +
        source_.hashCode +
        unit.hashCode;

  factory DeductionLogRow.fromJson(Map<String, dynamic> json) => _$DeductionLogRowFromJson(json);

  Map<String, dynamic> toJson() => _$DeductionLogRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

