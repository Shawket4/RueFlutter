//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_adjustment_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateAdjustmentRequest {
  /// Returns a new [CreateAdjustmentRequest] instance.
  CreateAdjustmentRequest({

    required  this.adjustmentType,

    required  this.branchInventoryId,

    required  this.note,

    required  this.quantity,
  });

  @JsonKey(
    
    name: r'adjustment_type',
    required: true,
    includeIfNull: false,
  )


  final String adjustmentType;



  @JsonKey(
    
    name: r'branch_inventory_id',
    required: true,
    includeIfNull: false,
  )


  final String branchInventoryId;



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





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateAdjustmentRequest &&
      other.adjustmentType == adjustmentType &&
      other.branchInventoryId == branchInventoryId &&
      other.note == note &&
      other.quantity == quantity;

    @override
    int get hashCode =>
        adjustmentType.hashCode +
        branchInventoryId.hashCode +
        note.hashCode +
        quantity.hashCode;

  factory CreateAdjustmentRequest.fromJson(Map<String, dynamic> json) => _$CreateAdjustmentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAdjustmentRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

