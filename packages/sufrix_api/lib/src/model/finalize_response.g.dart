// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finalize_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FinalizeResponseCWProxy {
  FinalizeResponse deliveryOrder(DeliveryOrder deliveryOrder);

  FinalizeResponse orderId(String orderId);

  FinalizeResponse orderRef(String? orderRef);

  FinalizeResponse warnings(List<String> warnings);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FinalizeResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FinalizeResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  FinalizeResponse call({
    DeliveryOrder deliveryOrder,
    String orderId,
    String? orderRef,
    List<String> warnings,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFinalizeResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFinalizeResponse.copyWith.fieldName(...)`
class _$FinalizeResponseCWProxyImpl implements _$FinalizeResponseCWProxy {
  const _$FinalizeResponseCWProxyImpl(this._value);

  final FinalizeResponse _value;

  @override
  FinalizeResponse deliveryOrder(DeliveryOrder deliveryOrder) =>
      this(deliveryOrder: deliveryOrder);

  @override
  FinalizeResponse orderId(String orderId) => this(orderId: orderId);

  @override
  FinalizeResponse orderRef(String? orderRef) => this(orderRef: orderRef);

  @override
  FinalizeResponse warnings(List<String> warnings) => this(warnings: warnings);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FinalizeResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FinalizeResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  FinalizeResponse call({
    Object? deliveryOrder = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? orderRef = const $CopyWithPlaceholder(),
    Object? warnings = const $CopyWithPlaceholder(),
  }) {
    return FinalizeResponse(
      deliveryOrder: deliveryOrder == const $CopyWithPlaceholder()
          ? _value.deliveryOrder
          // ignore: cast_nullable_to_non_nullable
          : deliveryOrder as DeliveryOrder,
      orderId: orderId == const $CopyWithPlaceholder()
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as String,
      orderRef: orderRef == const $CopyWithPlaceholder()
          ? _value.orderRef
          // ignore: cast_nullable_to_non_nullable
          : orderRef as String?,
      warnings: warnings == const $CopyWithPlaceholder()
          ? _value.warnings
          // ignore: cast_nullable_to_non_nullable
          : warnings as List<String>,
    );
  }
}

extension $FinalizeResponseCopyWith on FinalizeResponse {
  /// Returns a callable class that can be used as follows: `instanceOfFinalizeResponse.copyWith(...)` or like so:`instanceOfFinalizeResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FinalizeResponseCWProxy get copyWith => _$FinalizeResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinalizeResponse _$FinalizeResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FinalizeResponse',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['delivery_order', 'order_id', 'warnings'],
        );
        final val = FinalizeResponse(
          deliveryOrder: $checkedConvert(
            'delivery_order',
            (v) => DeliveryOrder.fromJson(v as Map<String, dynamic>),
          ),
          orderId: $checkedConvert('order_id', (v) => v as String),
          orderRef: $checkedConvert('order_ref', (v) => v as String?),
          warnings: $checkedConvert(
            'warnings',
            (v) => (v as List<dynamic>).map((e) => e as String).toList(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'deliveryOrder': 'delivery_order',
        'orderId': 'order_id',
        'orderRef': 'order_ref',
      },
    );

Map<String, dynamic> _$FinalizeResponseToJson(FinalizeResponse instance) =>
    <String, dynamic>{
      'delivery_order': instance.deliveryOrder.toJson(),
      'order_id': instance.orderId,
      'order_ref': ?instance.orderRef,
      'warnings': instance.warnings,
    };
