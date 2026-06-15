//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/cart_line_input.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_order_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DeliveryOrderInput {
  /// Returns a new [DeliveryOrderInput] instance.
  DeliveryOrderInput({

     this.addressLine,

    required  this.branchId,

    required  this.channel,

     this.customerLat,

     this.customerLng,

    required  this.customerName,

    required  this.customerPhone,

     this.deliveryNotes,

    required  this.deviceToken,

     this.floor,

    required  this.items,

     this.landmark,

    required  this.paymentMethodHint,

     this.placeName,

     this.unitNumber,
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
    
    name: r'channel',
    required: true,
    includeIfNull: false,
  )


  final String channel;



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
    
    name: r'delivery_notes',
    required: false,
    includeIfNull: false,
  )


  final String? deliveryNotes;



      /// Device-trust token from OTP verify (proves the phone).
  @JsonKey(
    
    name: r'device_token',
    required: true,
    includeIfNull: false,
  )


  final String deviceToken;



  @JsonKey(
    
    name: r'floor',
    required: false,
    includeIfNull: false,
  )


  final String? floor;



  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<CartLineInput> items;



  @JsonKey(
    
    name: r'landmark',
    required: false,
    includeIfNull: false,
  )


  final String? landmark;



      /// \"cash\" | \"card\" — a hint the teller can change at finalize.
  @JsonKey(
    
    name: r'payment_method_hint',
    required: true,
    includeIfNull: false,
  )


  final String paymentMethodHint;



  @JsonKey(
    
    name: r'place_name',
    required: false,
    includeIfNull: false,
  )


  final String? placeName;



  @JsonKey(
    
    name: r'unit_number',
    required: false,
    includeIfNull: false,
  )


  final String? unitNumber;





    @override
    bool operator ==(Object other) => identical(this, other) || other is DeliveryOrderInput &&
      other.addressLine == addressLine &&
      other.branchId == branchId &&
      other.channel == channel &&
      other.customerLat == customerLat &&
      other.customerLng == customerLng &&
      other.customerName == customerName &&
      other.customerPhone == customerPhone &&
      other.deliveryNotes == deliveryNotes &&
      other.deviceToken == deviceToken &&
      other.floor == floor &&
      other.items == items &&
      other.landmark == landmark &&
      other.paymentMethodHint == paymentMethodHint &&
      other.placeName == placeName &&
      other.unitNumber == unitNumber;

    @override
    int get hashCode =>
        (addressLine == null ? 0 : addressLine.hashCode) +
        branchId.hashCode +
        channel.hashCode +
        (customerLat == null ? 0 : customerLat.hashCode) +
        (customerLng == null ? 0 : customerLng.hashCode) +
        customerName.hashCode +
        customerPhone.hashCode +
        (deliveryNotes == null ? 0 : deliveryNotes.hashCode) +
        deviceToken.hashCode +
        (floor == null ? 0 : floor.hashCode) +
        items.hashCode +
        (landmark == null ? 0 : landmark.hashCode) +
        paymentMethodHint.hashCode +
        (placeName == null ? 0 : placeName.hashCode) +
        (unitNumber == null ? 0 : unitNumber.hashCode);

  factory DeliveryOrderInput.fromJson(Map<String, dynamic> json) => _$DeliveryOrderInputFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryOrderInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

