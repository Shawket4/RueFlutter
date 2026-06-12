// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsert_addon_override_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpsertAddonOverrideRequestCWProxy {
  UpsertAddonOverrideRequest addonItemId(String addonItemId);

  UpsertAddonOverrideRequest comboAddonItemId(String? comboAddonItemId);

  UpsertAddonOverrideRequest ingredientName(String ingredientName);

  UpsertAddonOverrideRequest ingredientUnit(String ingredientUnit);

  UpsertAddonOverrideRequest orgIngredientId(String? orgIngredientId);

  UpsertAddonOverrideRequest quantityUsed(double quantityUsed);

  UpsertAddonOverrideRequest replacesOrgIngredientId(
    String? replacesOrgIngredientId,
  );

  UpsertAddonOverrideRequest sizeLabel(String? sizeLabel);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpsertAddonOverrideRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpsertAddonOverrideRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpsertAddonOverrideRequest call({
    String addonItemId,
    String? comboAddonItemId,
    String ingredientName,
    String ingredientUnit,
    String? orgIngredientId,
    double quantityUsed,
    String? replacesOrgIngredientId,
    String? sizeLabel,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpsertAddonOverrideRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpsertAddonOverrideRequest.copyWith.fieldName(...)`
class _$UpsertAddonOverrideRequestCWProxyImpl
    implements _$UpsertAddonOverrideRequestCWProxy {
  const _$UpsertAddonOverrideRequestCWProxyImpl(this._value);

  final UpsertAddonOverrideRequest _value;

  @override
  UpsertAddonOverrideRequest addonItemId(String addonItemId) =>
      this(addonItemId: addonItemId);

  @override
  UpsertAddonOverrideRequest comboAddonItemId(String? comboAddonItemId) =>
      this(comboAddonItemId: comboAddonItemId);

  @override
  UpsertAddonOverrideRequest ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  UpsertAddonOverrideRequest ingredientUnit(String ingredientUnit) =>
      this(ingredientUnit: ingredientUnit);

  @override
  UpsertAddonOverrideRequest orgIngredientId(String? orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  UpsertAddonOverrideRequest quantityUsed(double quantityUsed) =>
      this(quantityUsed: quantityUsed);

  @override
  UpsertAddonOverrideRequest replacesOrgIngredientId(
    String? replacesOrgIngredientId,
  ) => this(replacesOrgIngredientId: replacesOrgIngredientId);

  @override
  UpsertAddonOverrideRequest sizeLabel(String? sizeLabel) =>
      this(sizeLabel: sizeLabel);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpsertAddonOverrideRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpsertAddonOverrideRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpsertAddonOverrideRequest call({
    Object? addonItemId = const $CopyWithPlaceholder(),
    Object? comboAddonItemId = const $CopyWithPlaceholder(),
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? ingredientUnit = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? quantityUsed = const $CopyWithPlaceholder(),
    Object? replacesOrgIngredientId = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
  }) {
    return UpsertAddonOverrideRequest(
      addonItemId: addonItemId == const $CopyWithPlaceholder()
          ? _value.addonItemId
          // ignore: cast_nullable_to_non_nullable
          : addonItemId as String,
      comboAddonItemId: comboAddonItemId == const $CopyWithPlaceholder()
          ? _value.comboAddonItemId
          // ignore: cast_nullable_to_non_nullable
          : comboAddonItemId as String?,
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
      replacesOrgIngredientId:
          replacesOrgIngredientId == const $CopyWithPlaceholder()
          ? _value.replacesOrgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : replacesOrgIngredientId as String?,
      sizeLabel: sizeLabel == const $CopyWithPlaceholder()
          ? _value.sizeLabel
          // ignore: cast_nullable_to_non_nullable
          : sizeLabel as String?,
    );
  }
}

extension $UpsertAddonOverrideRequestCopyWith on UpsertAddonOverrideRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpsertAddonOverrideRequest.copyWith(...)` or like so:`instanceOfUpsertAddonOverrideRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpsertAddonOverrideRequestCWProxy get copyWith =>
      _$UpsertAddonOverrideRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpsertAddonOverrideRequest _$UpsertAddonOverrideRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'UpsertAddonOverrideRequest',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'addon_item_id',
        'ingredient_name',
        'ingredient_unit',
        'quantity_used',
      ],
    );
    final val = UpsertAddonOverrideRequest(
      addonItemId: $checkedConvert('addon_item_id', (v) => v as String),
      comboAddonItemId: $checkedConvert(
        'combo_addon_item_id',
        (v) => v as String?,
      ),
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
      replacesOrgIngredientId: $checkedConvert(
        'replaces_org_ingredient_id',
        (v) => v as String?,
      ),
      sizeLabel: $checkedConvert('size_label', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'addonItemId': 'addon_item_id',
    'comboAddonItemId': 'combo_addon_item_id',
    'ingredientName': 'ingredient_name',
    'ingredientUnit': 'ingredient_unit',
    'orgIngredientId': 'org_ingredient_id',
    'quantityUsed': 'quantity_used',
    'replacesOrgIngredientId': 'replaces_org_ingredient_id',
    'sizeLabel': 'size_label',
  },
);

Map<String, dynamic> _$UpsertAddonOverrideRequestToJson(
  UpsertAddonOverrideRequest instance,
) => <String, dynamic>{
  'addon_item_id': instance.addonItemId,
  'combo_addon_item_id': ?instance.comboAddonItemId,
  'ingredient_name': instance.ingredientName,
  'ingredient_unit': instance.ingredientUnit,
  'org_ingredient_id': ?instance.orgIngredientId,
  'quantity_used': instance.quantityUsed,
  'replaces_org_ingredient_id': ?instance.replacesOrgIngredientId,
  'size_label': ?instance.sizeLabel,
};
