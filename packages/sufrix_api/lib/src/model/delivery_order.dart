//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_order.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DeliveryOrder {
  /// Returns a new [DeliveryOrder] instance.
  DeliveryOrder({

     this.addressLine,

    required  this.branchId,

     this.cancelReason,

     this.cancelRestocked,

     this.cancelledAt,

    required  this.cart,

    required  this.channel,

     this.confirmedAt,

    required  this.createdAt,

     this.customerLat,

     this.customerLng,

    required  this.customerName,

    required  this.customerPhone,

     this.deliveredAt,

    required  this.deliveryFee,

     this.deliveryNotes,

     this.deliveryRef,

     this.deliveryZoneId,

     this.discountAmount,

     this.discountId,

     this.discountType,

     this.discountValue,

    required  this.extraPrepMinutes,

     this.floor,

    required  this.id,

     this.landmark,

     this.orderId,

    required  this.orgId,

    required  this.otpVerified,

     this.outForDeliveryAt,

     this.paymentMethodHint,

     this.placeName,

     this.preparingAt,

     this.readyAt,

     this.receiptPrintedAt,

     this.rejectedAt,

     this.roadDistanceMeters,

    required  this.status,

    required  this.subtotal,

    required  this.total,

     this.unitNumber,

    required  this.updatedAt,
  });

  @JsonKey(
    
    name: r'address_line',
    required: false,
    includeIfNull: false,
  )


  final String? addressLine;



  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



  @JsonKey(
    
    name: r'cancel_reason',
    required: false,
    includeIfNull: false,
  )


  final String? cancelReason;



  @JsonKey(
    
    name: r'cancel_restocked',
    required: false,
    includeIfNull: false,
  )


  final bool? cancelRestocked;



  @JsonKey(
    
    name: r'cancelled_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? cancelledAt;



      /// The frozen priced line snapshot the POS renders before finalize.
  @JsonKey(
    
    name: r'cart',
    required: true,
    includeIfNull: false,
  )


  final Object cart;



  @JsonKey(
    
    name: r'channel',
    required: true,
    includeIfNull: false,
  )


  final String channel;



  @JsonKey(
    
    name: r'confirmed_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? confirmedAt;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'customer_lat',
    required: false,
    includeIfNull: false,
  )


  final double? customerLat;



  @JsonKey(
    
    name: r'customer_lng',
    required: false,
    includeIfNull: false,
  )


  final double? customerLng;



  @JsonKey(
    
    name: r'customer_name',
    required: true,
    includeIfNull: false,
  )


  final String customerName;



  @JsonKey(
    
    name: r'customer_phone',
    required: true,
    includeIfNull: false,
  )


  final String customerPhone;



  @JsonKey(
    
    name: r'delivered_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? deliveredAt;



  @JsonKey(
    
    name: r'delivery_fee',
    required: true,
    includeIfNull: false,
  )


  final int deliveryFee;



  @JsonKey(
    
    name: r'delivery_notes',
    required: false,
    includeIfNull: false,
  )


  final String? deliveryNotes;



  @JsonKey(
    
    name: r'delivery_ref',
    required: false,
    includeIfNull: false,
  )


  final String? deliveryRef;



  @JsonKey(
    
    name: r'delivery_zone_id',
    required: false,
    includeIfNull: false,
  )


  final String? deliveryZoneId;



  @JsonKey(
    
    name: r'discount_amount',
    required: false,
    includeIfNull: false,
  )


  final int? discountAmount;



      /// Frozen channel discount on the item subtotal (`total == subtotal - discount_amount + delivery_fee`). `discount_amount` is 0 when none.
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



      /// Extra prep minutes the teller added on top of the branch base (multiples of 5).
  @JsonKey(
    
    name: r'extra_prep_minutes',
    required: true,
    includeIfNull: false,
  )


  final int extraPrepMinutes;



  @JsonKey(
    
    name: r'floor',
    required: false,
    includeIfNull: false,
  )


  final String? floor;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'landmark',
    required: false,
    includeIfNull: false,
  )


  final String? landmark;



  @JsonKey(
    
    name: r'order_id',
    required: false,
    includeIfNull: false,
  )


  final String? orderId;



  @JsonKey(
    
    name: r'org_id',
    required: true,
    includeIfNull: false,
  )


  final String orgId;



  @JsonKey(
    
    name: r'otp_verified',
    required: true,
    includeIfNull: false,
  )


  final bool otpVerified;



  @JsonKey(
    
    name: r'out_for_delivery_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? outForDeliveryAt;



  @JsonKey(
    
    name: r'payment_method_hint',
    required: false,
    includeIfNull: false,
  )


  final String? paymentMethodHint;



  @JsonKey(
    
    name: r'place_name',
    required: false,
    includeIfNull: false,
  )


  final String? placeName;



  @JsonKey(
    
    name: r'preparing_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? preparingAt;



  @JsonKey(
    
    name: r'ready_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? readyAt;



  @JsonKey(
    
    name: r'receipt_printed_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? receiptPrintedAt;



  @JsonKey(
    
    name: r'rejected_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? rejectedAt;



  @JsonKey(
    
    name: r'road_distance_meters',
    required: false,
    includeIfNull: false,
  )


  final int? roadDistanceMeters;



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
    
    name: r'total',
    required: true,
    includeIfNull: false,
  )


  final int total;



  @JsonKey(
    
    name: r'unit_number',
    required: false,
    includeIfNull: false,
  )


  final String? unitNumber;



  @JsonKey(
    
    name: r'updated_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime updatedAt;





    @override
    bool operator ==(Object other) => identical(this, other) || other is DeliveryOrder &&
      other.addressLine == addressLine &&
      other.branchId == branchId &&
      other.cancelReason == cancelReason &&
      other.cancelRestocked == cancelRestocked &&
      other.cancelledAt == cancelledAt &&
      other.cart == cart &&
      other.channel == channel &&
      other.confirmedAt == confirmedAt &&
      other.createdAt == createdAt &&
      other.customerLat == customerLat &&
      other.customerLng == customerLng &&
      other.customerName == customerName &&
      other.customerPhone == customerPhone &&
      other.deliveredAt == deliveredAt &&
      other.deliveryFee == deliveryFee &&
      other.deliveryNotes == deliveryNotes &&
      other.deliveryRef == deliveryRef &&
      other.deliveryZoneId == deliveryZoneId &&
      other.discountAmount == discountAmount &&
      other.discountId == discountId &&
      other.discountType == discountType &&
      other.discountValue == discountValue &&
      other.extraPrepMinutes == extraPrepMinutes &&
      other.floor == floor &&
      other.id == id &&
      other.landmark == landmark &&
      other.orderId == orderId &&
      other.orgId == orgId &&
      other.otpVerified == otpVerified &&
      other.outForDeliveryAt == outForDeliveryAt &&
      other.paymentMethodHint == paymentMethodHint &&
      other.placeName == placeName &&
      other.preparingAt == preparingAt &&
      other.readyAt == readyAt &&
      other.receiptPrintedAt == receiptPrintedAt &&
      other.rejectedAt == rejectedAt &&
      other.roadDistanceMeters == roadDistanceMeters &&
      other.status == status &&
      other.subtotal == subtotal &&
      other.total == total &&
      other.unitNumber == unitNumber &&
      other.updatedAt == updatedAt;

    @override
    int get hashCode =>
        (addressLine == null ? 0 : addressLine.hashCode) +
        branchId.hashCode +
        (cancelReason == null ? 0 : cancelReason.hashCode) +
        (cancelRestocked == null ? 0 : cancelRestocked.hashCode) +
        (cancelledAt == null ? 0 : cancelledAt.hashCode) +
        cart.hashCode +
        channel.hashCode +
        (confirmedAt == null ? 0 : confirmedAt.hashCode) +
        createdAt.hashCode +
        (customerLat == null ? 0 : customerLat.hashCode) +
        (customerLng == null ? 0 : customerLng.hashCode) +
        customerName.hashCode +
        customerPhone.hashCode +
        (deliveredAt == null ? 0 : deliveredAt.hashCode) +
        deliveryFee.hashCode +
        (deliveryNotes == null ? 0 : deliveryNotes.hashCode) +
        (deliveryRef == null ? 0 : deliveryRef.hashCode) +
        (deliveryZoneId == null ? 0 : deliveryZoneId.hashCode) +
        discountAmount.hashCode +
        (discountId == null ? 0 : discountId.hashCode) +
        (discountType == null ? 0 : discountType.hashCode) +
        discountValue.hashCode +
        extraPrepMinutes.hashCode +
        (floor == null ? 0 : floor.hashCode) +
        id.hashCode +
        (landmark == null ? 0 : landmark.hashCode) +
        (orderId == null ? 0 : orderId.hashCode) +
        orgId.hashCode +
        otpVerified.hashCode +
        (outForDeliveryAt == null ? 0 : outForDeliveryAt.hashCode) +
        (paymentMethodHint == null ? 0 : paymentMethodHint.hashCode) +
        (placeName == null ? 0 : placeName.hashCode) +
        (preparingAt == null ? 0 : preparingAt.hashCode) +
        (readyAt == null ? 0 : readyAt.hashCode) +
        (receiptPrintedAt == null ? 0 : receiptPrintedAt.hashCode) +
        (rejectedAt == null ? 0 : rejectedAt.hashCode) +
        (roadDistanceMeters == null ? 0 : roadDistanceMeters.hashCode) +
        status.hashCode +
        subtotal.hashCode +
        total.hashCode +
        (unitNumber == null ? 0 : unitNumber.hashCode) +
        updatedAt.hashCode;

  factory DeliveryOrder.fromJson(Map<String, dynamic> json) => _$DeliveryOrderFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryOrderToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

