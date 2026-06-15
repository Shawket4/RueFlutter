//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_delivery_info.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderDeliveryInfo {
  /// Returns a new [OrderDeliveryInfo] instance.
  OrderDeliveryInfo({

     this.addressLine,

    required  this.channel,

    required  this.customerPhone,

     this.deliveryNotes,

     this.deliveryRef,

     this.floor,

     this.landmark,

     this.paymentMethodHint,

     this.placeName,

     this.roadDistanceMeters,

     this.unitNumber,

     this.zoneName,
  });

  @JsonKey(
    
    name: r'address_line',
    required: false,
    includeIfNull: false,
  )


  final String? addressLine;



      /// \"in_mall\" or \"outside\".
  @JsonKey(
    
    name: r'channel',
    required: true,
    includeIfNull: false,
  )


  final String channel;



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



      /// Human-readable delivery reference (e.g. \"D-DT-260614-0042\").
  @JsonKey(
    
    name: r'delivery_ref',
    required: false,
    includeIfNull: false,
  )


  final String? deliveryRef;



  @JsonKey(
    
    name: r'floor',
    required: false,
    includeIfNull: false,
  )


  final String? floor;



  @JsonKey(
    
    name: r'landmark',
    required: false,
    includeIfNull: false,
  )


  final String? landmark;



      /// Payment method the customer indicated at intake (\"cash\"/\"card\"); the teller confirms the actual method at finalize.
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



      /// Road distance (meters) used to price the delivery, when known.
  @JsonKey(
    
    name: r'road_distance_meters',
    required: false,
    includeIfNull: false,
  )


  final int? roadDistanceMeters;



  @JsonKey(
    
    name: r'unit_number',
    required: false,
    includeIfNull: false,
  )


  final String? unitNumber;



      /// Name of the matched delivery zone ring, when an outside order matched one.
  @JsonKey(
    
    name: r'zone_name',
    required: false,
    includeIfNull: false,
  )


  final String? zoneName;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrderDeliveryInfo &&
      other.addressLine == addressLine &&
      other.channel == channel &&
      other.customerPhone == customerPhone &&
      other.deliveryNotes == deliveryNotes &&
      other.deliveryRef == deliveryRef &&
      other.floor == floor &&
      other.landmark == landmark &&
      other.paymentMethodHint == paymentMethodHint &&
      other.placeName == placeName &&
      other.roadDistanceMeters == roadDistanceMeters &&
      other.unitNumber == unitNumber &&
      other.zoneName == zoneName;

    @override
    int get hashCode =>
        (addressLine == null ? 0 : addressLine.hashCode) +
        channel.hashCode +
        customerPhone.hashCode +
        (deliveryNotes == null ? 0 : deliveryNotes.hashCode) +
        (deliveryRef == null ? 0 : deliveryRef.hashCode) +
        (floor == null ? 0 : floor.hashCode) +
        (landmark == null ? 0 : landmark.hashCode) +
        (paymentMethodHint == null ? 0 : paymentMethodHint.hashCode) +
        (placeName == null ? 0 : placeName.hashCode) +
        (roadDistanceMeters == null ? 0 : roadDistanceMeters.hashCode) +
        (unitNumber == null ? 0 : unitNumber.hashCode) +
        (zoneName == null ? 0 : zoneName.hashCode);

  factory OrderDeliveryInfo.fromJson(Map<String, dynamic> json) => _$OrderDeliveryInfoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDeliveryInfoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

