// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_event.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DeliveryEventCWProxy {
  DeliveryEvent eventType(String eventType);

  DeliveryEvent order(DeliveryOrder order);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryEvent(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryEvent(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryEvent call({String eventType, DeliveryOrder order});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDeliveryEvent.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDeliveryEvent.copyWith.fieldName(...)`
class _$DeliveryEventCWProxyImpl implements _$DeliveryEventCWProxy {
  const _$DeliveryEventCWProxyImpl(this._value);

  final DeliveryEvent _value;

  @override
  DeliveryEvent eventType(String eventType) => this(eventType: eventType);

  @override
  DeliveryEvent order(DeliveryOrder order) => this(order: order);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryEvent(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryEvent(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryEvent call({
    Object? eventType = const $CopyWithPlaceholder(),
    Object? order = const $CopyWithPlaceholder(),
  }) {
    return DeliveryEvent(
      eventType: eventType == const $CopyWithPlaceholder()
          ? _value.eventType
          // ignore: cast_nullable_to_non_nullable
          : eventType as String,
      order: order == const $CopyWithPlaceholder()
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as DeliveryOrder,
    );
  }
}

extension $DeliveryEventCopyWith on DeliveryEvent {
  /// Returns a callable class that can be used as follows: `instanceOfDeliveryEvent.copyWith(...)` or like so:`instanceOfDeliveryEvent.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DeliveryEventCWProxy get copyWith => _$DeliveryEventCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryEvent _$DeliveryEventFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DeliveryEvent', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['event_type', 'order']);
      final val = DeliveryEvent(
        eventType: $checkedConvert('event_type', (v) => v as String),
        order: $checkedConvert(
          'order',
          (v) => DeliveryOrder.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'eventType': 'event_type'});

Map<String, dynamic> _$DeliveryEventToJson(DeliveryEvent instance) =>
    <String, dynamic>{
      'event_type': instance.eventType,
      'order': instance.order.toJson(),
    };
