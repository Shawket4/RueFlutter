//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_stock_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateStockRequest {
  /// Returns a new [UpdateStockRequest] instance.
  UpdateStockRequest({

     this.currentStock,

     this.reorderThreshold,
  });

  @JsonKey(
    
    name: r'current_stock',
    required: false,
    includeIfNull: false,
  )


  final double? currentStock;



  @JsonKey(
    
    name: r'reorder_threshold',
    required: false,
    includeIfNull: false,
  )


  final double? reorderThreshold;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpdateStockRequest &&
      other.currentStock == currentStock &&
      other.reorderThreshold == reorderThreshold;

    @override
    int get hashCode =>
        (currentStock == null ? 0 : currentStock.hashCode) +
        (reorderThreshold == null ? 0 : reorderThreshold.hashCode);

  factory UpdateStockRequest.fromJson(Map<String, dynamic> json) => _$UpdateStockRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateStockRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

