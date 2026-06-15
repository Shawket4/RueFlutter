// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_order_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DeliveryOrderInputCWProxy {
  DeliveryOrderInput addressLine(String? addressLine);

  DeliveryOrderInput branchId(String branchId);

  DeliveryOrderInput channel(String channel);

  DeliveryOrderInput customerLat(double? customerLat);

  DeliveryOrderInput customerLng(double? customerLng);

  DeliveryOrderInput customerName(String customerName);

  DeliveryOrderInput customerPhone(String customerPhone);

  DeliveryOrderInput deliveryNotes(String? deliveryNotes);

  DeliveryOrderInput deviceToken(String deviceToken);

  DeliveryOrderInput floor(String? floor);

  DeliveryOrderInput items(List<CartLineInput> items);

  DeliveryOrderInput landmark(String? landmark);

  DeliveryOrderInput paymentMethodHint(String paymentMethodHint);

  DeliveryOrderInput placeName(String? placeName);

  DeliveryOrderInput unitNumber(String? unitNumber);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryOrderInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryOrderInput(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryOrderInput call({
    String? addressLine,
    String branchId,
    String channel,
    double? customerLat,
    double? customerLng,
    String customerName,
    String customerPhone,
    String? deliveryNotes,
    String deviceToken,
    String? floor,
    List<CartLineInput> items,
    String? landmark,
    String paymentMethodHint,
    String? placeName,
    String? unitNumber,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDeliveryOrderInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDeliveryOrderInput.copyWith.fieldName(...)`
class _$DeliveryOrderInputCWProxyImpl implements _$DeliveryOrderInputCWProxy {
  const _$DeliveryOrderInputCWProxyImpl(this._value);

  final DeliveryOrderInput _value;

  @override
  DeliveryOrderInput addressLine(String? addressLine) =>
      this(addressLine: addressLine);

  @override
  DeliveryOrderInput branchId(String branchId) => this(branchId: branchId);

  @override
  DeliveryOrderInput channel(String channel) => this(channel: channel);

  @override
  DeliveryOrderInput customerLat(double? customerLat) =>
      this(customerLat: customerLat);

  @override
  DeliveryOrderInput customerLng(double? customerLng) =>
      this(customerLng: customerLng);

  @override
  DeliveryOrderInput customerName(String customerName) =>
      this(customerName: customerName);

  @override
  DeliveryOrderInput customerPhone(String customerPhone) =>
      this(customerPhone: customerPhone);

  @override
  DeliveryOrderInput deliveryNotes(String? deliveryNotes) =>
      this(deliveryNotes: deliveryNotes);

  @override
  DeliveryOrderInput deviceToken(String deviceToken) =>
      this(deviceToken: deviceToken);

  @override
  DeliveryOrderInput floor(String? floor) => this(floor: floor);

  @override
  DeliveryOrderInput items(List<CartLineInput> items) => this(items: items);

  @override
  DeliveryOrderInput landmark(String? landmark) => this(landmark: landmark);

  @override
  DeliveryOrderInput paymentMethodHint(String paymentMethodHint) =>
      this(paymentMethodHint: paymentMethodHint);

  @override
  DeliveryOrderInput placeName(String? placeName) => this(placeName: placeName);

  @override
  DeliveryOrderInput unitNumber(String? unitNumber) =>
      this(unitNumber: unitNumber);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryOrderInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryOrderInput(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryOrderInput call({
    Object? addressLine = const $CopyWithPlaceholder(),
    Object? branchId = const $CopyWithPlaceholder(),
    Object? channel = const $CopyWithPlaceholder(),
    Object? customerLat = const $CopyWithPlaceholder(),
    Object? customerLng = const $CopyWithPlaceholder(),
    Object? customerName = const $CopyWithPlaceholder(),
    Object? customerPhone = const $CopyWithPlaceholder(),
    Object? deliveryNotes = const $CopyWithPlaceholder(),
    Object? deviceToken = const $CopyWithPlaceholder(),
    Object? floor = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? landmark = const $CopyWithPlaceholder(),
    Object? paymentMethodHint = const $CopyWithPlaceholder(),
    Object? placeName = const $CopyWithPlaceholder(),
    Object? unitNumber = const $CopyWithPlaceholder(),
  }) {
    return DeliveryOrderInput(
      addressLine: addressLine == const $CopyWithPlaceholder()
          ? _value.addressLine
          // ignore: cast_nullable_to_non_nullable
          : addressLine as String?,
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      channel: channel == const $CopyWithPlaceholder()
          ? _value.channel
          // ignore: cast_nullable_to_non_nullable
          : channel as String,
      customerLat: customerLat == const $CopyWithPlaceholder()
          ? _value.customerLat
          // ignore: cast_nullable_to_non_nullable
          : customerLat as double?,
      customerLng: customerLng == const $CopyWithPlaceholder()
          ? _value.customerLng
          // ignore: cast_nullable_to_non_nullable
          : customerLng as double?,
      customerName: customerName == const $CopyWithPlaceholder()
          ? _value.customerName
          // ignore: cast_nullable_to_non_nullable
          : customerName as String,
      customerPhone: customerPhone == const $CopyWithPlaceholder()
          ? _value.customerPhone
          // ignore: cast_nullable_to_non_nullable
          : customerPhone as String,
      deliveryNotes: deliveryNotes == const $CopyWithPlaceholder()
          ? _value.deliveryNotes
          // ignore: cast_nullable_to_non_nullable
          : deliveryNotes as String?,
      deviceToken: deviceToken == const $CopyWithPlaceholder()
          ? _value.deviceToken
          // ignore: cast_nullable_to_non_nullable
          : deviceToken as String,
      floor: floor == const $CopyWithPlaceholder()
          ? _value.floor
          // ignore: cast_nullable_to_non_nullable
          : floor as String?,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<CartLineInput>,
      landmark: landmark == const $CopyWithPlaceholder()
          ? _value.landmark
          // ignore: cast_nullable_to_non_nullable
          : landmark as String?,
      paymentMethodHint: paymentMethodHint == const $CopyWithPlaceholder()
          ? _value.paymentMethodHint
          // ignore: cast_nullable_to_non_nullable
          : paymentMethodHint as String,
      placeName: placeName == const $CopyWithPlaceholder()
          ? _value.placeName
          // ignore: cast_nullable_to_non_nullable
          : placeName as String?,
      unitNumber: unitNumber == const $CopyWithPlaceholder()
          ? _value.unitNumber
          // ignore: cast_nullable_to_non_nullable
          : unitNumber as String?,
    );
  }
}

extension $DeliveryOrderInputCopyWith on DeliveryOrderInput {
  /// Returns a callable class that can be used as follows: `instanceOfDeliveryOrderInput.copyWith(...)` or like so:`instanceOfDeliveryOrderInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DeliveryOrderInputCWProxy get copyWith =>
      _$DeliveryOrderInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryOrderInput _$DeliveryOrderInputFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DeliveryOrderInput',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'branch_id',
            'channel',
            'customer_name',
            'customer_phone',
            'device_token',
            'items',
            'payment_method_hint',
          ],
        );
        final val = DeliveryOrderInput(
          addressLine: $checkedConvert('address_line', (v) => v as String?),
          branchId: $checkedConvert('branch_id', (v) => v as String),
          channel: $checkedConvert('channel', (v) => v as String),
          customerLat: $checkedConvert(
            'customer_lat',
            (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
          ),
          customerLng: $checkedConvert(
            'customer_lng',
            (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
          ),
          customerName: $checkedConvert('customer_name', (v) => v as String),
          customerPhone: $checkedConvert('customer_phone', (v) => v as String),
          deliveryNotes: $checkedConvert('delivery_notes', (v) => v as String?),
          deviceToken: $checkedConvert('device_token', (v) => v as String),
          floor: $checkedConvert('floor', (v) => v as String?),
          items: $checkedConvert(
            'items',
            (v) => (v as List<dynamic>)
                .map((e) => CartLineInput.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          landmark: $checkedConvert('landmark', (v) => v as String?),
          paymentMethodHint: $checkedConvert(
            'payment_method_hint',
            (v) => v as String,
          ),
          placeName: $checkedConvert('place_name', (v) => v as String?),
          unitNumber: $checkedConvert('unit_number', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'addressLine': 'address_line',
        'branchId': 'branch_id',
        'customerLat': 'customer_lat',
        'customerLng': 'customer_lng',
        'customerName': 'customer_name',
        'customerPhone': 'customer_phone',
        'deliveryNotes': 'delivery_notes',
        'deviceToken': 'device_token',
        'paymentMethodHint': 'payment_method_hint',
        'placeName': 'place_name',
        'unitNumber': 'unit_number',
      },
    );

Map<String, dynamic> _$DeliveryOrderInputToJson(DeliveryOrderInput instance) =>
    <String, dynamic>{
      'address_line': ?instance.addressLine,
      'branch_id': instance.branchId,
      'channel': instance.channel,
      'customer_lat': ?instance.customerLat,
      'customer_lng': ?instance.customerLng,
      'customer_name': instance.customerName,
      'customer_phone': instance.customerPhone,
      'delivery_notes': ?instance.deliveryNotes,
      'device_token': instance.deviceToken,
      'floor': ?instance.floor,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'landmark': ?instance.landmark,
      'payment_method_hint': instance.paymentMethodHint,
      'place_name': ?instance.placeName,
      'unit_number': ?instance.unitNumber,
    };
