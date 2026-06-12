//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_to_stock_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AddToStockRequest {
  /// Returns a new [AddToStockRequest] instance.
  AddToStockRequest({

     this.currentStock,

    required  this.orgIngredientId,

     this.reorderThreshold,
  });

  @JsonKey(
    
    name: r'current_stock',
    required: false,
    includeIfNull: false,
  )


  final double? currentStock;



  @JsonKey(
    
    name: r'org_ingredient_id',
    required: true,
    includeIfNull: false,
  )


  final String orgIngredientId;



  @JsonKey(
    
    name: r'reorder_threshold',
    required: false,
    includeIfNull: false,
  )


  final double? reorderThreshold;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AddToStockRequest &&
      other.currentStock == currentStock &&
      other.orgIngredientId == orgIngredientId &&
      other.reorderThreshold == reorderThreshold;

    @override
    int get hashCode =>
        (currentStock == null ? 0 : currentStock.hashCode) +
        orgIngredientId.hashCode +
        (reorderThreshold == null ? 0 : reorderThreshold.hashCode);

  factory AddToStockRequest.fromJson(Map<String, dynamic> json) => _$AddToStockRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddToStockRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

