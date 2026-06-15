// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_delivery_info.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderDeliveryInfoCWProxy {
  OrderDeliveryInfo addressLine(String? addressLine);

  OrderDeliveryInfo channel(String channel);

  OrderDeliveryInfo customerPhone(String customerPhone);

  OrderDeliveryInfo deliveryNotes(String? deliveryNotes);

  OrderDeliveryInfo deliveryRef(String? deliveryRef);

  OrderDeliveryInfo floor(String? floor);

  OrderDeliveryInfo landmark(String? landmark);

  OrderDeliveryInfo paymentMethodHint(String? paymentMethodHint);

  OrderDeliveryInfo placeName(String? placeName);

  OrderDeliveryInfo roadDistanceMeters(int? roadDistanceMeters);

  OrderDeliveryInfo unitNumber(String? unitNumber);

  OrderDeliveryInfo zoneName(String? zoneName);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderDeliveryInfo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderDeliveryInfo(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderDeliveryInfo call({
    String? addressLine,
    String channel,
    String customerPhone,
    String? deliveryNotes,
    String? deliveryRef,
    String? floor,
    String? landmark,
    String? paymentMethodHint,
    String? placeName,
    int? roadDistanceMeters,
    String? unitNumber,
    String? zoneName,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderDeliveryInfo.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderDeliveryInfo.copyWith.fieldName(...)`
class _$OrderDeliveryInfoCWProxyImpl implements _$OrderDeliveryInfoCWProxy {
  const _$OrderDeliveryInfoCWProxyImpl(this._value);

  final OrderDeliveryInfo _value;

  @override
  OrderDeliveryInfo addressLine(String? addressLine) =>
      this(addressLine: addressLine);

  @override
  OrderDeliveryInfo channel(String channel) => this(channel: channel);

  @override
  OrderDeliveryInfo customerPhone(String customerPhone) =>
      this(customerPhone: customerPhone);

  @override
  OrderDeliveryInfo deliveryNotes(String? deliveryNotes) =>
      this(deliveryNotes: deliveryNotes);

  @override
  OrderDeliveryInfo deliveryRef(String? deliveryRef) =>
      this(deliveryRef: deliveryRef);

  @override
  OrderDeliveryInfo floor(String? floor) => this(floor: floor);

  @override
  OrderDeliveryInfo landmark(String? landmark) => this(landmark: landmark);

  @override
  OrderDeliveryInfo paymentMethodHint(String? paymentMethodHint) =>
      this(paymentMethodHint: paymentMethodHint);

  @override
  OrderDeliveryInfo placeName(String? placeName) => this(placeName: placeName);

  @override
  OrderDeliveryInfo roadDistanceMeters(int? roadDistanceMeters) =>
      this(roadDistanceMeters: roadDistanceMeters);

  @override
  OrderDeliveryInfo unitNumber(String? unitNumber) =>
      this(unitNumber: unitNumber);

  @override
  OrderDeliveryInfo zoneName(String? zoneName) => this(zoneName: zoneName);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderDeliveryInfo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderDeliveryInfo(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderDeliveryInfo call({
    Object? addressLine = const $CopyWithPlaceholder(),
    Object? channel = const $CopyWithPlaceholder(),
    Object? customerPhone = const $CopyWithPlaceholder(),
    Object? deliveryNotes = const $CopyWithPlaceholder(),
    Object? deliveryRef = const $CopyWithPlaceholder(),
    Object? floor = const $CopyWithPlaceholder(),
    Object? landmark = const $CopyWithPlaceholder(),
    Object? paymentMethodHint = const $CopyWithPlaceholder(),
    Object? placeName = const $CopyWithPlaceholder(),
    Object? roadDistanceMeters = const $CopyWithPlaceholder(),
    Object? unitNumber = const $CopyWithPlaceholder(),
    Object? zoneName = const $CopyWithPlaceholder(),
  }) {
    return OrderDeliveryInfo(
      addressLine: addressLine == const $CopyWithPlaceholder()
          ? _value.addressLine
          // ignore: cast_nullable_to_non_nullable
          : addressLine as String?,
      channel: channel == const $CopyWithPlaceholder()
          ? _value.channel
          // ignore: cast_nullable_to_non_nullable
          : channel as String,
      customerPhone: customerPhone == const $CopyWithPlaceholder()
          ? _value.customerPhone
          // ignore: cast_nullable_to_non_nullable
          : customerPhone as String,
      deliveryNotes: deliveryNotes == const $CopyWithPlaceholder()
          ? _value.deliveryNotes
          // ignore: cast_nullable_to_non_nullable
          : deliveryNotes as String?,
      deliveryRef: deliveryRef == const $CopyWithPlaceholder()
          ? _value.deliveryRef
          // ignore: cast_nullable_to_non_nullable
          : deliveryRef as String?,
      floor: floor == const $CopyWithPlaceholder()
          ? _value.floor
          // ignore: cast_nullable_to_non_nullable
          : floor as String?,
      landmark: landmark == const $CopyWithPlaceholder()
          ? _value.landmark
          // ignore: cast_nullable_to_non_nullable
          : landmark as String?,
      paymentMethodHint: paymentMethodHint == const $CopyWithPlaceholder()
          ? _value.paymentMethodHint
          // ignore: cast_nullable_to_non_nullable
          : paymentMethodHint as String?,
      placeName: placeName == const $CopyWithPlaceholder()
          ? _value.placeName
          // ignore: cast_nullable_to_non_nullable
          : placeName as String?,
      roadDistanceMeters: roadDistanceMeters == const $CopyWithPlaceholder()
          ? _value.roadDistanceMeters
          // ignore: cast_nullable_to_non_nullable
          : roadDistanceMeters as int?,
      unitNumber: unitNumber == const $CopyWithPlaceholder()
          ? _value.unitNumber
          // ignore: cast_nullable_to_non_nullable
          : unitNumber as String?,
      zoneName: zoneName == const $CopyWithPlaceholder()
          ? _value.zoneName
          // ignore: cast_nullable_to_non_nullable
          : zoneName as String?,
    );
  }
}

extension $OrderDeliveryInfoCopyWith on OrderDeliveryInfo {
  /// Returns a callable class that can be used as follows: `instanceOfOrderDeliveryInfo.copyWith(...)` or like so:`instanceOfOrderDeliveryInfo.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderDeliveryInfoCWProxy get copyWith =>
      _$OrderDeliveryInfoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDeliveryInfo _$OrderDeliveryInfoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'OrderDeliveryInfo',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['channel', 'customer_phone']);
        final val = OrderDeliveryInfo(
          addressLine: $checkedConvert('address_line', (v) => v as String?),
          channel: $checkedConvert('channel', (v) => v as String),
          customerPhone: $checkedConvert('customer_phone', (v) => v as String),
          deliveryNotes: $checkedConvert('delivery_notes', (v) => v as String?),
          deliveryRef: $checkedConvert('delivery_ref', (v) => v as String?),
          floor: $checkedConvert('floor', (v) => v as String?),
          landmark: $checkedConvert('landmark', (v) => v as String?),
          paymentMethodHint: $checkedConvert(
            'payment_method_hint',
            (v) => v as String?,
          ),
          placeName: $checkedConvert('place_name', (v) => v as String?),
          roadDistanceMeters: $checkedConvert(
            'road_distance_meters',
            (v) => (v as num?)?.toInt(),
          ),
          unitNumber: $checkedConvert('unit_number', (v) => v as String?),
          zoneName: $checkedConvert('zone_name', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'addressLine': 'address_line',
        'customerPhone': 'customer_phone',
        'deliveryNotes': 'delivery_notes',
        'deliveryRef': 'delivery_ref',
        'paymentMethodHint': 'payment_method_hint',
        'placeName': 'place_name',
        'roadDistanceMeters': 'road_distance_meters',
        'unitNumber': 'unit_number',
        'zoneName': 'zone_name',
      },
    );

Map<String, dynamic> _$OrderDeliveryInfoToJson(OrderDeliveryInfo instance) =>
    <String, dynamic>{
      'address_line': ?instance.addressLine,
      'channel': instance.channel,
      'customer_phone': instance.customerPhone,
      'delivery_notes': ?instance.deliveryNotes,
      'delivery_ref': ?instance.deliveryRef,
      'floor': ?instance.floor,
      'landmark': ?instance.landmark,
      'payment_method_hint': ?instance.paymentMethodHint,
      'place_name': ?instance.placeName,
      'road_distance_meters': ?instance.roadDistanceMeters,
      'unit_number': ?instance.unitNumber,
      'zone_name': ?instance.zoneName,
    };
