// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_bundle_component_optional.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderBundleComponentOptionalCWProxy {
  OrderBundleComponentOptional componentItemId(String componentItemId);

  OrderBundleComponentOptional fieldName(String fieldName);

  OrderBundleComponentOptional id(String id);

  OrderBundleComponentOptional nameTranslations(Object nameTranslations);

  OrderBundleComponentOptional optionalFieldId(String? optionalFieldId);

  OrderBundleComponentOptional orderLineId(String orderLineId);

  OrderBundleComponentOptional price(int price);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderBundleComponentOptional(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderBundleComponentOptional(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderBundleComponentOptional call({
    String componentItemId,
    String fieldName,
    String id,
    Object nameTranslations,
    String? optionalFieldId,
    String orderLineId,
    int price,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderBundleComponentOptional.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderBundleComponentOptional.copyWith.fieldName(...)`
class _$OrderBundleComponentOptionalCWProxyImpl
    implements _$OrderBundleComponentOptionalCWProxy {
  const _$OrderBundleComponentOptionalCWProxyImpl(this._value);

  final OrderBundleComponentOptional _value;

  @override
  OrderBundleComponentOptional componentItemId(String componentItemId) =>
      this(componentItemId: componentItemId);

  @override
  OrderBundleComponentOptional fieldName(String fieldName) =>
      this(fieldName: fieldName);

  @override
  OrderBundleComponentOptional id(String id) => this(id: id);

  @override
  OrderBundleComponentOptional nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  OrderBundleComponentOptional optionalFieldId(String? optionalFieldId) =>
      this(optionalFieldId: optionalFieldId);

  @override
  OrderBundleComponentOptional orderLineId(String orderLineId) =>
      this(orderLineId: orderLineId);

  @override
  OrderBundleComponentOptional price(int price) => this(price: price);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderBundleComponentOptional(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderBundleComponentOptional(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderBundleComponentOptional call({
    Object? componentItemId = const $CopyWithPlaceholder(),
    Object? fieldName = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? optionalFieldId = const $CopyWithPlaceholder(),
    Object? orderLineId = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
  }) {
    return OrderBundleComponentOptional(
      componentItemId: componentItemId == const $CopyWithPlaceholder()
          ? _value.componentItemId
          // ignore: cast_nullable_to_non_nullable
          : componentItemId as String,
      fieldName: fieldName == const $CopyWithPlaceholder()
          ? _value.fieldName
          // ignore: cast_nullable_to_non_nullable
          : fieldName as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      nameTranslations: nameTranslations == const $CopyWithPlaceholder()
          ? _value.nameTranslations
          // ignore: cast_nullable_to_non_nullable
          : nameTranslations as Object,
      optionalFieldId: optionalFieldId == const $CopyWithPlaceholder()
          ? _value.optionalFieldId
          // ignore: cast_nullable_to_non_nullable
          : optionalFieldId as String?,
      orderLineId: orderLineId == const $CopyWithPlaceholder()
          ? _value.orderLineId
          // ignore: cast_nullable_to_non_nullable
          : orderLineId as String,
      price: price == const $CopyWithPlaceholder()
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as int,
    );
  }
}

extension $OrderBundleComponentOptionalCopyWith
    on OrderBundleComponentOptional {
  /// Returns a callable class that can be used as follows: `instanceOfOrderBundleComponentOptional.copyWith(...)` or like so:`instanceOfOrderBundleComponentOptional.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderBundleComponentOptionalCWProxy get copyWith =>
      _$OrderBundleComponentOptionalCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderBundleComponentOptional _$OrderBundleComponentOptionalFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'OrderBundleComponentOptional',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'component_item_id',
        'field_name',
        'id',
        'name_translations',
        'order_line_id',
        'price',
      ],
    );
    final val = OrderBundleComponentOptional(
      componentItemId: $checkedConvert('component_item_id', (v) => v as String),
      fieldName: $checkedConvert('field_name', (v) => v as String),
      id: $checkedConvert('id', (v) => v as String),
      nameTranslations: $checkedConvert(
        'name_translations',
        (v) => v as Object,
      ),
      optionalFieldId: $checkedConvert(
        'optional_field_id',
        (v) => v as String?,
      ),
      orderLineId: $checkedConvert('order_line_id', (v) => v as String),
      price: $checkedConvert('price', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'componentItemId': 'component_item_id',
    'fieldName': 'field_name',
    'nameTranslations': 'name_translations',
    'optionalFieldId': 'optional_field_id',
    'orderLineId': 'order_line_id',
  },
);

Map<String, dynamic> _$OrderBundleComponentOptionalToJson(
  OrderBundleComponentOptional instance,
) => <String, dynamic>{
  'component_item_id': instance.componentItemId,
  'field_name': instance.fieldName,
  'id': instance.id,
  'name_translations': instance.nameTranslations,
  'optional_field_id': ?instance.optionalFieldId,
  'order_line_id': instance.orderLineId,
  'price': instance.price,
};
