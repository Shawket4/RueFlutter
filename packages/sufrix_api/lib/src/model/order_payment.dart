//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_payment.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderPayment {
  /// Returns a new [OrderPayment] instance.
  OrderPayment({

    required  this.amount,

    required  this.id,

    required  this.method,

    required  this.orderId,

     this.reference,
  });

  @JsonKey(
    
    name: r'amount',
    required: true,
    includeIfNull: false,
  )


  final int amount;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'method',
    required: true,
    includeIfNull: false,
  )


  final String method;



  @JsonKey(
    
    name: r'order_id',
    required: true,
    includeIfNull: false,
  )


  final String orderId;



  @JsonKey(
    
    name: r'reference',
    required: false,
    includeIfNull: false,
  )


  final String? reference;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrderPayment &&
      other.amount == amount &&
      other.id == id &&
      other.method == method &&
      other.orderId == orderId &&
      other.reference == reference;

    @override
    int get hashCode =>
        amount.hashCode +
        id.hashCode +
        method.hashCode +
        orderId.hashCode +
        (reference == null ? 0 : reference.hashCode);

  factory OrderPayment.fromJson(Map<String, dynamic> json) => _$OrderPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$OrderPaymentToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

