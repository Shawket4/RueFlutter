//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inventory_count_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InventoryCountInput {
  /// Returns a new [InventoryCountInput] instance.
  InventoryCountInput({

    required  this.actualStock,

    required  this.branchInventoryId,

     this.note,
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
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;





    @override
    bool operator ==(Object other) => identical(this, other) || other is InventoryCountInput &&
      other.actualStock == actualStock &&
      other.branchInventoryId == branchInventoryId &&
      other.note == note;

    @override
    int get hashCode =>
        actualStock.hashCode +
        branchInventoryId.hashCode +
        (note == null ? 0 : note.hashCode);

  factory InventoryCountInput.fromJson(Map<String, dynamic> json) => _$InventoryCountInputFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryCountInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

