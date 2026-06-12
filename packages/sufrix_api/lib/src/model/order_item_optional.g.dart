// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_optional.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrderItemOptionalCWProxy {
  OrderItemOptional cost(int? cost);

  OrderItemOptional fieldName(String fieldName);

  OrderItemOptional id(String id);

  OrderItemOptional ingredientName(String? ingredientName);

  OrderItemOptional ingredientUnit(String? ingredientUnit);

  OrderItemOptional nameTranslations(Object nameTranslations);

  OrderItemOptional optionalFieldId(String? optionalFieldId);

  OrderItemOptional orderItemId(String orderItemId);

  OrderItemOptional orgIngredientId(String? orgIngredientId);

  OrderItemOptional price(int price);

  OrderItemOptional quantityDeducted(double? quantityDeducted);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderItemOptional(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderItemOptional(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderItemOptional call({
    int? cost,
    String fieldName,
    String id,
    String? ingredientName,
    String? ingredientUnit,
    Object nameTranslations,
    String? optionalFieldId,
    String orderItemId,
    String? orgIngredientId,
    int price,
    double? quantityDeducted,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrderItemOptional.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrderItemOptional.copyWith.fieldName(...)`
class _$OrderItemOptionalCWProxyImpl implements _$OrderItemOptionalCWProxy {
  const _$OrderItemOptionalCWProxyImpl(this._value);

  final OrderItemOptional _value;

  @override
  OrderItemOptional cost(int? cost) => this(cost: cost);

  @override
  OrderItemOptional fieldName(String fieldName) => this(fieldName: fieldName);

  @override
  OrderItemOptional id(String id) => this(id: id);

  @override
  OrderItemOptional ingredientName(String? ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  OrderItemOptional ingredientUnit(String? ingredientUnit) =>
      this(ingredientUnit: ingredientUnit);

  @override
  OrderItemOptional nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  OrderItemOptional optionalFieldId(String? optionalFieldId) =>
      this(optionalFieldId: optionalFieldId);

  @override
  OrderItemOptional orderItemId(String orderItemId) =>
      this(orderItemId: orderItemId);

  @override
  OrderItemOptional orgIngredientId(String? orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  OrderItemOptional price(int price) => this(price: price);

  @override
  OrderItemOptional quantityDeducted(double? quantityDeducted) =>
      this(quantityDeducted: quantityDeducted);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrderItemOptional(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrderItemOptional(...).copyWith(id: 12, name: "My name")
  /// ````
  OrderItemOptional call({
    Object? cost = const $CopyWithPlaceholder(),
    Object? fieldName = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? ingredientUnit = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? optionalFieldId = const $CopyWithPlaceholder(),
    Object? orderItemId = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? quantityDeducted = const $CopyWithPlaceholder(),
  }) {
    return OrderItemOptional(
      cost: cost == const $CopyWithPlaceholder()
          ? _value.cost
          // ignore: cast_nullable_to_non_nullable
          : cost as int?,
      fieldName: fieldName == const $CopyWithPlaceholder()
          ? _value.fieldName
          // ignore: cast_nullable_to_non_nullable
          : fieldName as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      ingredientName: ingredientName == const $CopyWithPlaceholder()
          ? _value.ingredientName
          // ignore: cast_nullable_to_non_nullable
          : ingredientName as String?,
      ingredientUnit: ingredientUnit == const $CopyWithPlaceholder()
          ? _value.ingredientUnit
          // ignore: cast_nullable_to_non_nullable
          : ingredientUnit as String?,
      nameTranslations: nameTranslations == const $CopyWithPlaceholder()
          ? _value.nameTranslations
          // ignore: cast_nullable_to_non_nullable
          : nameTranslations as Object,
      optionalFieldId: optionalFieldId == const $CopyWithPlaceholder()
          ? _value.optionalFieldId
          // ignore: cast_nullable_to_non_nullable
          : optionalFieldId as String?,
      orderItemId: orderItemId == const $CopyWithPlaceholder()
          ? _value.orderItemId
          // ignore: cast_nullable_to_non_nullable
          : orderItemId as String,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String?,
      price: price == const $CopyWithPlaceholder()
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as int,
      quantityDeducted: quantityDeducted == const $CopyWithPlaceholder()
          ? _value.quantityDeducted
          // ignore: cast_nullable_to_non_nullable
          : quantityDeducted as double?,
    );
  }
}

extension $OrderItemOptionalCopyWith on OrderItemOptional {
  /// Returns a callable class that can be used as follows: `instanceOfOrderItemOptional.copyWith(...)` or like so:`instanceOfOrderItemOptional.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrderItemOptionalCWProxy get copyWith =>
      _$OrderItemOptionalCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemOptional _$OrderItemOptionalFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'OrderItemOptional',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'field_name',
        'id',
        'name_translations',
        'order_item_id',
        'price',
      ],
    );
    final val = OrderItemOptional(
      cost: $checkedConvert('cost', (v) => (v as num?)?.toInt()),
      fieldName: $checkedConvert('field_name', (v) => v as String),
      id: $checkedConvert('id', (v) => v as String),
      ingredientName: $checkedConvert('ingredient_name', (v) => v as String?),
      ingredientUnit: $checkedConvert('ingredient_unit', (v) => v as String?),
      nameTranslations: $checkedConvert(
        'name_translations',
        (v) => v as Object,
      ),
      optionalFieldId: $checkedConvert(
        'optional_field_id',
        (v) => v as String?,
      ),
      orderItemId: $checkedConvert('order_item_id', (v) => v as String),
      orgIngredientId: $checkedConvert(
        'org_ingredient_id',
        (v) => v as String?,
      ),
      price: $checkedConvert('price', (v) => (v as num).toInt()),
      quantityDeducted: $checkedConvert(
        'quantity_deducted',
        (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'fieldName': 'field_name',
    'ingredientName': 'ingredient_name',
    'ingredientUnit': 'ingredient_unit',
    'nameTranslations': 'name_translations',
    'optionalFieldId': 'optional_field_id',
    'orderItemId': 'order_item_id',
    'orgIngredientId': 'org_ingredient_id',
    'quantityDeducted': 'quantity_deducted',
  },
);

Map<String, dynamic> _$OrderItemOptionalToJson(OrderItemOptional instance) =>
    <String, dynamic>{
      'cost': ?instance.cost,
      'field_name': instance.fieldName,
      'id': instance.id,
      'ingredient_name': ?instance.ingredientName,
      'ingredient_unit': ?instance.ingredientUnit,
      'name_translations': instance.nameTranslations,
      'optional_field_id': ?instance.optionalFieldId,
      'order_item_id': instance.orderItemId,
      'org_ingredient_id': ?instance.orgIngredientId,
      'price': instance.price,
      'quantity_deducted': ?instance.quantityDeducted,
    };
