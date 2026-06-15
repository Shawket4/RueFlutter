// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_menu_size.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DeliveryMenuSizeCWProxy {
  DeliveryMenuSize label(String label);

  DeliveryMenuSize price(int price);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryMenuSize(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryMenuSize(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryMenuSize call({String label, int price});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDeliveryMenuSize.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDeliveryMenuSize.copyWith.fieldName(...)`
class _$DeliveryMenuSizeCWProxyImpl implements _$DeliveryMenuSizeCWProxy {
  const _$DeliveryMenuSizeCWProxyImpl(this._value);

  final DeliveryMenuSize _value;

  @override
  DeliveryMenuSize label(String label) => this(label: label);

  @override
  DeliveryMenuSize price(int price) => this(price: price);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryMenuSize(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryMenuSize(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryMenuSize call({
    Object? label = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
  }) {
    return DeliveryMenuSize(
      label: label == const $CopyWithPlaceholder()
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String,
      price: price == const $CopyWithPlaceholder()
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as int,
    );
  }
}

extension $DeliveryMenuSizeCopyWith on DeliveryMenuSize {
  /// Returns a callable class that can be used as follows: `instanceOfDeliveryMenuSize.copyWith(...)` or like so:`instanceOfDeliveryMenuSize.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DeliveryMenuSizeCWProxy get copyWith => _$DeliveryMenuSizeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryMenuSize _$DeliveryMenuSizeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DeliveryMenuSize', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['label', 'price']);
      final val = DeliveryMenuSize(
        label: $checkedConvert('label', (v) => v as String),
        price: $checkedConvert('price', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$DeliveryMenuSizeToJson(DeliveryMenuSize instance) =>
    <String, dynamic>{'label': instance.label, 'price': instance.price};
