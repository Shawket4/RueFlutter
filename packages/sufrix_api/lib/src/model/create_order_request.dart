//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/payment_split_input.dart';
import 'package:sufrix_api/src/model/order_item_input.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_order_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateOrderRequest {
  /// Returns a new [CreateOrderRequest] instance.
  CreateOrderRequest({

     this.amountTendered,

    required  this.branchId,

     this.changeGiven,

     this.createdAt,

     this.customerName,

     this.discountAmount,

     this.discountId,

     this.discountType,

     this.discountValue,

    required  this.items,

     this.notes,

    required  this.paymentMethod,

     this.paymentSplits,

    required  this.shiftId,

     this.subtotal,

     this.taxAmount,

     this.tipAmount,

     this.tipPaymentMethod,

     this.totalAmount,
  });

  @JsonKey(
    
    name: r'amount_tendered',
    required: false,
    includeIfNull: false,
  )


  final int? amountTendered;



  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



  @JsonKey(
    
    name: r'change_given',
    required: false,
    includeIfNull: false,
  )


  final int? changeGiven;



  @JsonKey(
    
    name: r'created_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? createdAt;



  @JsonKey(
    
    name: r'customer_name',
    required: false,
    includeIfNull: false,
  )


  final String? customerName;



  @JsonKey(
    
    name: r'discount_amount',
    required: false,
    includeIfNull: false,
  )


  final int? discountAmount;



  @JsonKey(
    
    name: r'discount_id',
    required: false,
    includeIfNull: false,
  )


  final String? discountId;



  @JsonKey(
    
    name: r'discount_type',
    required: false,
    includeIfNull: false,
  )


  final String? discountType;



  @JsonKey(
    
    name: r'discount_value',
    required: false,
    includeIfNull: false,
  )


  final int? discountValue;



  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<OrderItemInput> items;



  @JsonKey(
    
    name: r'notes',
    required: false,
    includeIfNull: false,
  )


  final String? notes;



  @JsonKey(
    
    name: r'payment_method',
    required: true,
    includeIfNull: false,
  )


  final String paymentMethod;



  @JsonKey(
    
    name: r'payment_splits',
    required: false,
    includeIfNull: false,
  )


  final List<PaymentSplitInput>? paymentSplits;



  @JsonKey(
    
    name: r'shift_id',
    required: true,
    includeIfNull: false,
  )


  final String shiftId;



  @JsonKey(
    
    name: r'subtotal',
    required: false,
    includeIfNull: false,
  )


  final int? subtotal;



  @JsonKey(
    
    name: r'tax_amount',
    required: false,
    includeIfNull: false,
  )


  final int? taxAmount;



  @JsonKey(
    
    name: r'tip_amount',
    required: false,
    includeIfNull: false,
  )


  final int? tipAmount;



  @JsonKey(
    
    name: r'tip_payment_method',
    required: false,
    includeIfNull: false,
  )


  final String? tipPaymentMethod;



  @JsonKey(
    
    name: r'total_amount',
    required: false,
    includeIfNull: false,
  )


  final int? totalAmount;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateOrderRequest &&
      other.amountTendered == amountTendered &&
      other.branchId == branchId &&
      other.changeGiven == changeGiven &&
      other.createdAt == createdAt &&
      other.customerName == customerName &&
      other.discountAmount == discountAmount &&
      other.discountId == discountId &&
      other.discountType == discountType &&
      other.discountValue == discountValue &&
      other.items == items &&
      other.notes == notes &&
      other.paymentMethod == paymentMethod &&
      other.paymentSplits == paymentSplits &&
      other.shiftId == shiftId &&
      other.subtotal == subtotal &&
      other.taxAmount == taxAmount &&
      other.tipAmount == tipAmount &&
      other.tipPaymentMethod == tipPaymentMethod &&
      other.totalAmount == totalAmount;

    @override
    int get hashCode =>
        (amountTendered == null ? 0 : amountTendered.hashCode) +
        branchId.hashCode +
        (changeGiven == null ? 0 : changeGiven.hashCode) +
        (createdAt == null ? 0 : createdAt.hashCode) +
        (customerName == null ? 0 : customerName.hashCode) +
        (discountAmount == null ? 0 : discountAmount.hashCode) +
        (discountId == null ? 0 : discountId.hashCode) +
        (discountType == null ? 0 : discountType.hashCode) +
        (discountValue == null ? 0 : discountValue.hashCode) +
        items.hashCode +
        (notes == null ? 0 : notes.hashCode) +
        paymentMethod.hashCode +
        (paymentSplits == null ? 0 : paymentSplits.hashCode) +
        shiftId.hashCode +
        (subtotal == null ? 0 : subtotal.hashCode) +
        (taxAmount == null ? 0 : taxAmount.hashCode) +
        (tipAmount == null ? 0 : tipAmount.hashCode) +
        (tipPaymentMethod == null ? 0 : tipPaymentMethod.hashCode) +
        (totalAmount == null ? 0 : totalAmount.hashCode);

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) => _$CreateOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

