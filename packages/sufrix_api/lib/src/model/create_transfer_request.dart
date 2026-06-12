//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_transfer_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateTransferRequest {
  /// Returns a new [CreateTransferRequest] instance.
  CreateTransferRequest({

    required  this.destinationBranchId,

     this.note,

    required  this.orgIngredientId,

    required  this.quantity,

    required  this.sourceBranchId,
  });

  @JsonKey(
    
    name: r'destination_branch_id',
    required: true,
    includeIfNull: false,
  )


  final String destinationBranchId;



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





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateTransferRequest &&
      other.destinationBranchId == destinationBranchId &&
      other.note == note &&
      other.orgIngredientId == orgIngredientId &&
      other.quantity == quantity &&
      other.sourceBranchId == sourceBranchId;

    @override
    int get hashCode =>
        destinationBranchId.hashCode +
        (note == null ? 0 : note.hashCode) +
        orgIngredientId.hashCode +
        quantity.hashCode +
        sourceBranchId.hashCode;

  factory CreateTransferRequest.fromJson(Map<String, dynamic> json) => _$CreateTransferRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTransferRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

