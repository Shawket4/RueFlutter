// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_optional_field_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateOptionalFieldRequestCWProxy {
  UpdateOptionalFieldRequest ingredientName(String? ingredientName);

  UpdateOptionalFieldRequest ingredientUnit(String? ingredientUnit);

  UpdateOptionalFieldRequest isActive(bool? isActive);

  UpdateOptionalFieldRequest name(String? name);

  UpdateOptionalFieldRequest nameTranslations(Object? nameTranslations);

  UpdateOptionalFieldRequest orgIngredientId(String? orgIngredientId);

  UpdateOptionalFieldRequest price(int? price);

  UpdateOptionalFieldRequest quantityUsed(double? quantityUsed);

  UpdateOptionalFieldRequest sizeLabel(String? sizeLabel);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateOptionalFieldRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateOptionalFieldRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateOptionalFieldRequest call({
    String? ingredientName,
    String? ingredientUnit,
    bool? isActive,
    String? name,
    Object? nameTranslations,
    String? orgIngredientId,
    int? price,
    double? quantityUsed,
    String? sizeLabel,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateOptionalFieldRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateOptionalFieldRequest.copyWith.fieldName(...)`
class _$UpdateOptionalFieldRequestCWProxyImpl
    implements _$UpdateOptionalFieldRequestCWProxy {
  const _$UpdateOptionalFieldRequestCWProxyImpl(this._value);

  final UpdateOptionalFieldRequest _value;

  @override
  UpdateOptionalFieldRequest ingredientName(String? ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  UpdateOptionalFieldRequest ingredientUnit(String? ingredientUnit) =>
      this(ingredientUnit: ingredientUnit);

  @override
  UpdateOptionalFieldRequest isActive(bool? isActive) =>
      this(isActive: isActive);

  @override
  UpdateOptionalFieldRequest name(String? name) => this(name: name);

  @override
  UpdateOptionalFieldRequest nameTranslations(Object? nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  UpdateOptionalFieldRequest orgIngredientId(String? orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  UpdateOptionalFieldRequest price(int? price) => this(price: price);

  @override
  UpdateOptionalFieldRequest quantityUsed(double? quantityUsed) =>
      this(quantityUsed: quantityUsed);

  @override
  UpdateOptionalFieldRequest sizeLabel(String? sizeLabel) =>
      this(sizeLabel: sizeLabel);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateOptionalFieldRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateOptionalFieldRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateOptionalFieldRequest call({
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? ingredientUnit = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? quantityUsed = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
  }) {
    return UpdateOptionalFieldRequest(
      ingredientName: ingredientName == const $CopyWithPlaceholder()
          ? _value.ingredientName
          // ignore: cast_nullable_to_non_nullable
          : ingredientName as String?,
      ingredientUnit: ingredientUnit == const $CopyWithPlaceholder()
          ? _value.ingredientUnit
          // ignore: cast_nullable_to_non_nullable
          : ingredientUnit as String?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      nameTranslations: nameTranslations == const $CopyWithPlaceholder()
          ? _value.nameTranslations
          // ignore: cast_nullable_to_non_nullable
          : nameTranslations as Object?,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String?,
      price: price == const $CopyWithPlaceholder()
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as int?,
      quantityUsed: quantityUsed == const $CopyWithPlaceholder()
          ? _value.quantityUsed
          // ignore: cast_nullable_to_non_nullable
          : quantityUsed as double?,
      sizeLabel: sizeLabel == const $CopyWithPlaceholder()
          ? _value.sizeLabel
          // ignore: cast_nullable_to_non_nullable
          : sizeLabel as String?,
    );
  }
}

extension $UpdateOptionalFieldRequestCopyWith on UpdateOptionalFieldRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateOptionalFieldRequest.copyWith(...)` or like so:`instanceOfUpdateOptionalFieldRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateOptionalFieldRequestCWProxy get copyWith =>
      _$UpdateOptionalFieldRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateOptionalFieldRequest _$UpdateOptionalFieldRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'UpdateOptionalFieldRequest',
  json,
  ($checkedConvert) {
    final val = UpdateOptionalFieldRequest(
      ingredientName: $checkedConvert('ingredient_name', (v) => v as String?),
      ingredientUnit: $checkedConvert('ingredient_unit', (v) => v as String?),
      isActive: $checkedConvert('is_active', (v) => v as bool?),
      name: $checkedConvert('name', (v) => v as String?),
      nameTranslations: $checkedConvert('name_translations', (v) => v),
      orgIngredientId: $checkedConvert(
        'org_ingredient_id',
        (v) => v as String?,
      ),
      price: $checkedConvert('price', (v) => (v as num?)?.toInt()),
      quantityUsed: $checkedConvert(
        'quantity_used',
        (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
      ),
      sizeLabel: $checkedConvert('size_label', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'ingredientName': 'ingredient_name',
    'ingredientUnit': 'ingredient_unit',
    'isActive': 'is_active',
    'nameTranslations': 'name_translations',
    'orgIngredientId': 'org_ingredient_id',
    'quantityUsed': 'quantity_used',
    'sizeLabel': 'size_label',
  },
);

Map<String, dynamic> _$UpdateOptionalFieldRequestToJson(
  UpdateOptionalFieldRequest instance,
) => <String, dynamic>{
  'ingredient_name': ?instance.ingredientName,
  'ingredient_unit': ?instance.ingredientUnit,
  'is_active': ?instance.isActive,
  'name': ?instance.name,
  'name_translations': ?instance.nameTranslations,
  'org_ingredient_id': ?instance.orgIngredientId,
  'price': ?instance.price,
  'quantity_used': ?instance.quantityUsed,
  'size_label': ?instance.sizeLabel,
};
