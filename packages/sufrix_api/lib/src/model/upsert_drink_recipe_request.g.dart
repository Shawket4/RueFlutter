// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsert_drink_recipe_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpsertDrinkRecipeRequestCWProxy {
  UpsertDrinkRecipeRequest ingredientName(String ingredientName);

  UpsertDrinkRecipeRequest ingredientUnit(String ingredientUnit);

  UpsertDrinkRecipeRequest orgIngredientId(String? orgIngredientId);

  UpsertDrinkRecipeRequest quantityUsed(double quantityUsed);

  UpsertDrinkRecipeRequest sizeLabel(String sizeLabel);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpsertDrinkRecipeRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpsertDrinkRecipeRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpsertDrinkRecipeRequest call({
    String ingredientName,
    String ingredientUnit,
    String? orgIngredientId,
    double quantityUsed,
    String sizeLabel,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpsertDrinkRecipeRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpsertDrinkRecipeRequest.copyWith.fieldName(...)`
class _$UpsertDrinkRecipeRequestCWProxyImpl
    implements _$UpsertDrinkRecipeRequestCWProxy {
  const _$UpsertDrinkRecipeRequestCWProxyImpl(this._value);

  final UpsertDrinkRecipeRequest _value;

  @override
  UpsertDrinkRecipeRequest ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  UpsertDrinkRecipeRequest ingredientUnit(String ingredientUnit) =>
      this(ingredientUnit: ingredientUnit);

  @override
  UpsertDrinkRecipeRequest orgIngredientId(String? orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  UpsertDrinkRecipeRequest quantityUsed(double quantityUsed) =>
      this(quantityUsed: quantityUsed);

  @override
  UpsertDrinkRecipeRequest sizeLabel(String sizeLabel) =>
      this(sizeLabel: sizeLabel);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpsertDrinkRecipeRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpsertDrinkRecipeRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpsertDrinkRecipeRequest call({
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? ingredientUnit = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? quantityUsed = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
  }) {
    return UpsertDrinkRecipeRequest(
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
      sizeLabel: sizeLabel == const $CopyWithPlaceholder()
          ? _value.sizeLabel
          // ignore: cast_nullable_to_non_nullable
          : sizeLabel as String,
    );
  }
}

extension $UpsertDrinkRecipeRequestCopyWith on UpsertDrinkRecipeRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpsertDrinkRecipeRequest.copyWith(...)` or like so:`instanceOfUpsertDrinkRecipeRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpsertDrinkRecipeRequestCWProxy get copyWith =>
      _$UpsertDrinkRecipeRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpsertDrinkRecipeRequest _$UpsertDrinkRecipeRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'UpsertDrinkRecipeRequest',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'ingredient_name',
        'ingredient_unit',
        'quantity_used',
        'size_label',
      ],
    );
    final val = UpsertDrinkRecipeRequest(
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
      sizeLabel: $checkedConvert('size_label', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'ingredientName': 'ingredient_name',
    'ingredientUnit': 'ingredient_unit',
    'orgIngredientId': 'org_ingredient_id',
    'quantityUsed': 'quantity_used',
    'sizeLabel': 'size_label',
  },
);

Map<String, dynamic> _$UpsertDrinkRecipeRequestToJson(
  UpsertDrinkRecipeRequest instance,
) => <String, dynamic>{
  'ingredient_name': instance.ingredientName,
  'ingredient_unit': instance.ingredientUnit,
  'org_ingredient_id': ?instance.orgIngredientId,
  'quantity_used': instance.quantityUsed,
  'size_label': instance.sizeLabel,
};
