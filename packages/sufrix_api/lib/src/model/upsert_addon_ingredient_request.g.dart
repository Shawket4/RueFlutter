// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsert_addon_ingredient_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpsertAddonIngredientRequestCWProxy {
  UpsertAddonIngredientRequest ingredientName(String ingredientName);

  UpsertAddonIngredientRequest ingredientUnit(String ingredientUnit);

  UpsertAddonIngredientRequest orgIngredientId(String? orgIngredientId);

  UpsertAddonIngredientRequest quantityUsed(double quantityUsed);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpsertAddonIngredientRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpsertAddonIngredientRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpsertAddonIngredientRequest call({
    String ingredientName,
    String ingredientUnit,
    String? orgIngredientId,
    double quantityUsed,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpsertAddonIngredientRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpsertAddonIngredientRequest.copyWith.fieldName(...)`
class _$UpsertAddonIngredientRequestCWProxyImpl
    implements _$UpsertAddonIngredientRequestCWProxy {
  const _$UpsertAddonIngredientRequestCWProxyImpl(this._value);

  final UpsertAddonIngredientRequest _value;

  @override
  UpsertAddonIngredientRequest ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  UpsertAddonIngredientRequest ingredientUnit(String ingredientUnit) =>
      this(ingredientUnit: ingredientUnit);

  @override
  UpsertAddonIngredientRequest orgIngredientId(String? orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  UpsertAddonIngredientRequest quantityUsed(double quantityUsed) =>
      this(quantityUsed: quantityUsed);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpsertAddonIngredientRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpsertAddonIngredientRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpsertAddonIngredientRequest call({
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? ingredientUnit = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? quantityUsed = const $CopyWithPlaceholder(),
  }) {
    return UpsertAddonIngredientRequest(
      ingredientName: ingredientName == const $CopyWithPlaceholder()
          ? _value.ingredientName
          // ignore: cast_nullable_to_non_nullable
          : ingredientName as String,
      ingredientUnit: ingredientUnit == const $CopyWithPlaceholder()
          ? _value.ingredientUnit
          // ignore: cast_nullable_to_non_nullable
          : ingredientUnit as String,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String?,
      quantityUsed: quantityUsed == const $CopyWithPlaceholder()
          ? _value.quantityUsed
          // ignore: cast_nullable_to_non_nullable
          : quantityUsed as double,
    );
  }
}

extension $UpsertAddonIngredientRequestCopyWith
    on UpsertAddonIngredientRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpsertAddonIngredientRequest.copyWith(...)` or like so:`instanceOfUpsertAddonIngredientRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpsertAddonIngredientRequestCWProxy get copyWith =>
      _$UpsertAddonIngredientRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpsertAddonIngredientRequest _$UpsertAddonIngredientRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'UpsertAddonIngredientRequest',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'ingredient_name',
        'ingredient_unit',
        'quantity_used',
      ],
    );
    final val = UpsertAddonIngredientRequest(
      ingredientName: $checkedConvert('ingredient_name', (v) => v as String),
      ingredientUnit: $checkedConvert('ingredient_unit', (v) => v as String),
      orgIngredientId: $checkedConvert(
        'org_ingredient_id',
        (v) => v as String?,
      ),
      quantityUsed: $checkedConvert(
        'quantity_used',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'ingredientName': 'ingredient_name',
    'ingredientUnit': 'ingredient_unit',
    'orgIngredientId': 'org_ingredient_id',
    'quantityUsed': 'quantity_used',
  },
);

Map<String, dynamic> _$UpsertAddonIngredientRequestToJson(
  UpsertAddonIngredientRequest instance,
) => <String, dynamic>{
  'ingredient_name': instance.ingredientName,
  'ingredient_unit': instance.ingredientUnit,
  'org_ingredient_id': ?instance.orgIngredientId,
  'quantity_used': instance.quantityUsed,
};
