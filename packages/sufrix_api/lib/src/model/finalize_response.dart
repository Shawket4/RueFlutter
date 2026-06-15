//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/delivery_order.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'finalize_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FinalizeResponse {
  /// Returns a new [FinalizeResponse] instance.
  FinalizeResponse({

    required  this.deliveryOrder,

    required  this.orderId,

     this.orderRef,

    required  this.warnings,
  });

  @JsonKey(
    
    name: r'delivery_order',
    required: true,
    includeIfNull: false,
  )


  final DeliveryOrder deliveryOrder;



  @JsonKey(
    
    name: r'order_id',
    required: true,
    includeIfNull: false,
  )


  final String orderId;



  @JsonKey(
    
    name: r'order_ref',
    required: false,
    includeIfNull: false,
  )


  final String? orderRef;



  @JsonKey(
    
    name: r'warnings',
    required: true,
    includeIfNull: false,
  )


  final List<String> warnings;





    @override
    bool operator ==(Object other) => identical(this, other) || other is FinalizeResponse &&
      other.deliveryOrder == deliveryOrder &&
      other.orderId == orderId &&
      other.orderRef == orderRef &&
      other.warnings == warnings;

    @override
    int get hashCode =>
        deliveryOrder.hashCode +
        orderId.hashCode +
        (orderRef == null ? 0 : orderRef.hashCode) +
        warnings.hashCode;

  factory FinalizeResponse.fromJson(Map<String, dynamic> json) => _$FinalizeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FinalizeResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

