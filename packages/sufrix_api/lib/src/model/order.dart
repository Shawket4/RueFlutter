//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Order {
  /// Returns a new [Order] instance.
  Order({

     this.amountTendered,

    required  this.branchId,

     this.changeGiven,

    required  this.createdAt,

     this.customerName,

     this.deliveryChannel,

    required  this.deliveryFee,

     this.deliveryOrderId,

    required  this.discountAmount,

     this.discountId,

     this.discountType,

    required  this.discountValue,

    required  this.id,

     this.notes,

    required  this.orderNumber,

     this.orderRef,

    required  this.orderType,

    required  this.paymentMethod,

    required  this.shiftId,

    required  this.status,

    required  this.subtotal,

    required  this.taxAmount,

    required  this.tellerId,

    required  this.tellerName,

     this.tipAmount,

     this.tipPaymentMethod,

    required  this.totalAmount,

     this.voidNote,

     this.voidReason,

     this.voidedAt,

     this.voidedBy,
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
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'customer_name',
    required: false,
    includeIfNull: false,
  )


  final String? customerName;



      /// Delivery channel (\"in_mall\" | \"outside\") of the linked delivery order, surfaced on the list so clients can flag + segment delivery orders without a per-order detail fetch. `null` for dine-in orders.
  @JsonKey(
    
    name: r'delivery_channel',
    required: false,
    includeIfNull: false,
  )


  final String? deliveryChannel;



      /// Delivery charge in piastres, shown separately from the item subtotal. Always 0 for dine-in orders; for delivery orders `total_amount == subtotal + tax_amount + delivery_fee` (minus discount).
  @JsonKey(
    
    name: r'delivery_fee',
    required: true,
    includeIfNull: false,
  )


  final int deliveryFee;



      /// Links a finalized delivery order back to its `delivery_orders` row (customer, address, channel, zone). `null` for dine-in orders.
  @JsonKey(
    
    name: r'delivery_order_id',
    required: false,
    includeIfNull: false,
  )


  final String? deliveryOrderId;



  @JsonKey(
    
    name: r'discount_amount',
    required: true,
    includeIfNull: false,
  )


  final int discountAmount;



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
    required: true,
    includeIfNull: false,
  )


  final int discountValue;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'notes',
    required: false,
    includeIfNull: false,
  )


  final String? notes;



  @JsonKey(
    
    name: r'order_number',
    required: true,
    includeIfNull: false,
  )


  final int orderNumber;



      /// Human-readable, org-unique reference (e.g. \"DT-260614-0042\"). Additive alongside the per-shift order_number. Optional only during the rollout window before the historical backfill runs; never null afterwards.
  @JsonKey(
    
    name: r'order_ref',
    required: false,
    includeIfNull: false,
  )


  final String? orderRef;



      /// Order origin: \"dine_in\" (POS sale) or \"delivery\" (finalized delivery order). Defaults to \"dine_in\" for every POS sale.
  @JsonKey(
    
    name: r'order_type',
    required: true,
    includeIfNull: false,
  )


  final String orderType;



  @JsonKey(
    
    name: r'payment_method',
    required: true,
    includeIfNull: false,
  )


  final String paymentMethod;



  @JsonKey(
    
    name: r'shift_id',
    required: true,
    includeIfNull: false,
  )


  final String shiftId;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final String status;



  @JsonKey(
    
    name: r'subtotal',
    required: true,
    includeIfNull: false,
  )


  final int subtotal;



  @JsonKey(
    
    name: r'tax_amount',
    required: true,
    includeIfNull: false,
  )


  final int taxAmount;



  @JsonKey(
    
    name: r'teller_id',
    required: true,
    includeIfNull: false,
  )


  final String tellerId;



  @JsonKey(
    
    name: r'teller_name',
    required: true,
    includeIfNull: false,
  )


  final String tellerName;



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
    required: true,
    includeIfNull: false,
  )


  final int totalAmount;



  @JsonKey(
    
    name: r'void_note',
    required: false,
    includeIfNull: false,
  )


  final String? voidNote;



  @JsonKey(
    
    name: r'void_reason',
    required: false,
    includeIfNull: false,
  )


  final String? voidReason;



  @JsonKey(
    
    name: r'voided_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? voidedAt;



  @JsonKey(
    
    name: r'voided_by',
    required: false,
    includeIfNull: false,
  )


  final String? voidedBy;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Order &&
      other.amountTendered == amountTendered &&
      other.branchId == branchId &&
      other.changeGiven == changeGiven &&
      other.createdAt == createdAt &&
      other.customerName == customerName &&
      other.deliveryChannel == deliveryChannel &&
      other.deliveryFee == deliveryFee &&
      other.deliveryOrderId == deliveryOrderId &&
      other.discountAmount == discountAmount &&
      other.discountId == discountId &&
      other.discountType == discountType &&
      other.discountValue == discountValue &&
      other.id == id &&
      other.notes == notes &&
      other.orderNumber == orderNumber &&
      other.orderRef == orderRef &&
      other.orderType == orderType &&
      other.paymentMethod == paymentMethod &&
      other.shiftId == shiftId &&
      other.status == status &&
      other.subtotal == subtotal &&
      other.taxAmount == taxAmount &&
      other.tellerId == tellerId &&
      other.tellerName == tellerName &&
      other.tipAmount == tipAmount &&
      other.tipPaymentMethod == tipPaymentMethod &&
      other.totalAmount == totalAmount &&
      other.voidNote == voidNote &&
      other.voidReason == voidReason &&
      other.voidedAt == voidedAt &&
      other.voidedBy == voidedBy;

    @override
    int get hashCode =>
        (amountTendered == null ? 0 : amountTendered.hashCode) +
        branchId.hashCode +
        (changeGiven == null ? 0 : changeGiven.hashCode) +
        createdAt.hashCode +
        (customerName == null ? 0 : customerName.hashCode) +
        (deliveryChannel == null ? 0 : deliveryChannel.hashCode) +
        deliveryFee.hashCode +
        (deliveryOrderId == null ? 0 : deliveryOrderId.hashCode) +
        discountAmount.hashCode +
        (discountId == null ? 0 : discountId.hashCode) +
        (discountType == null ? 0 : discountType.hashCode) +
        discountValue.hashCode +
        id.hashCode +
        (notes == null ? 0 : notes.hashCode) +
        orderNumber.hashCode +
        (orderRef == null ? 0 : orderRef.hashCode) +
        orderType.hashCode +
        paymentMethod.hashCode +
        shiftId.hashCode +
        status.hashCode +
        subtotal.hashCode +
        taxAmount.hashCode +
        tellerId.hashCode +
        tellerName.hashCode +
        (tipAmount == null ? 0 : tipAmount.hashCode) +
        (tipPaymentMethod == null ? 0 : tipPaymentMethod.hashCode) +
        totalAmount.hashCode +
        (voidNote == null ? 0 : voidNote.hashCode) +
        (voidReason == null ? 0 : voidReason.hashCode) +
        (voidedAt == null ? 0 : voidedAt.hashCode) +
        (voidedBy == null ? 0 : voidedBy.hashCode);

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

