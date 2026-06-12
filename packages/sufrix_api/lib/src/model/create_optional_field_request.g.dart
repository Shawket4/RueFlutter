// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_optional_field_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateOptionalFieldRequestCWProxy {
  CreateOptionalFieldRequest displayOrder(int? displayOrder);

  CreateOptionalFieldRequest ingredientName(String? ingredientName);

  CreateOptionalFieldRequest ingredientUnit(String? ingredientUnit);

  CreateOptionalFieldRequest name(String name);

  CreateOptionalFieldRequest nameTranslations(Object? nameTranslations);

  CreateOptionalFieldRequest orgIngredientId(String? orgIngredientId);

  CreateOptionalFieldRequest price(int? price);

  CreateOptionalFieldRequest quantityUsed(double? quantityUsed);

  CreateOptionalFieldRequest sizeLabel(String? sizeLabel);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateOptionalFieldRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateOptionalFieldRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateOptionalFieldRequest call({
    int? displayOrder,
    String? ingredientName,
    String? ingredientUnit,
    String name,
    Object? nameTranslations,
    String? orgIngredientId,
    int? price,
    double? quantityUsed,
    String? sizeLabel,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateOptionalFieldRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateOptionalFieldRequest.copyWith.fieldName(...)`
class _$CreateOptionalFieldRequestCWProxyImpl
    implements _$CreateOptionalFieldRequestCWProxy {
  const _$CreateOptionalFieldRequestCWProxyImpl(this._value);

  final CreateOptionalFieldRequest _value;

  @override
  CreateOptionalFieldRequest displayOrder(int? displayOrder) =>
      this(displayOrder: displayOrder);

  @override
  CreateOptionalFieldRequest ingredientName(String? ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  CreateOptionalFieldRequest ingredientUnit(String? ingredientUnit) =>
      this(ingredientUnit: ingredientUnit);

  @override
  CreateOptionalFieldRequest name(String name) => this(name: name);

  @override
  CreateOptionalFieldRequest nameTranslations(Object? nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  CreateOptionalFieldRequest orgIngredientId(String? orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  CreateOptionalFieldRequest price(int? price) => this(price: price);

  @override
  CreateOptionalFieldRequest quantityUsed(double? quantityUsed) =>
      this(quantityUsed: quantityUsed);

  @override
  CreateOptionalFieldRequest sizeLabel(String? sizeLabel) =>
      this(sizeLabel: sizeLabel);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateOptionalFieldRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateOptionalFieldRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateOptionalFieldRequest call({
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? ingredientUnit = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? quantityUsed = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
  }) {
    return CreateOptionalFieldRequest(
      displayOrder: displayOrder == const $CopyWithPlaceholder()
          ? _value.displayOrder
          // ignore: cast_nullable_to_non_nullable
          : displayOrder as int?,
      ingredientName: ingredientName == const $CopyWithPlaceholder()
          ? _value.ingredientName
          // ignore: cast_nullable_to_non_nullable
          : ingredientName as String?,
      ingredientUnit: ingredientUnit == const $CopyWithPlaceholder()
          ? _value.ingredientUnit
          // ignore: cast_nullable_to_non_nullable
          : ingredientUnit as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
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

extension $CreateOptionalFieldRequestCopyWith on CreateOptionalFieldRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreateOptionalFieldRequest.copyWith(...)` or like so:`instanceOfCreateOptionalFieldRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateOptionalFieldRequestCWProxy get copyWith =>
      _$CreateOptionalFieldRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOptionalFieldRequest _$CreateOptionalFieldRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'CreateOptionalFieldRequest',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['name']);
    final val = CreateOptionalFieldRequest(
      displayOrder: $checkedConvert(
        'display_order',
        (v) => (v as num?)?.toInt(),
      ),
      ingredientName: $checkedConvert('ingredient_name', (v) => v as String?),
      ingredientUnit: $checkedConvert('ingredient_unit', (v) => v as String?),
      name: $checkedConvert('name', (v) => v as String),
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
    'displayOrder': 'display_order',
    'ingredientName': 'ingredient_name',
    'ingredientUnit': 'ingredient_unit',
    'nameTranslations': 'name_translations',
    'orgIngredientId': 'org_ingredient_id',
    'quantityUsed': 'quantity_used',
    'sizeLabel': 'size_label',
  },
);

Map<String, dynamic> _$CreateOptionalFieldRequestToJson(
  CreateOptionalFieldRequest instance,
) => <String, dynamic>{
  'display_order': ?instance.displayOrder,
  'ingredient_name': ?instance.ingredientName,
  'ingredient_unit': ?instance.ingredientUnit,
  'name': instance.name,
  'name_translations': ?instance.nameTranslations,
  'org_ingredient_id': ?instance.orgIngredientId,
  'price': ?instance.price,
  'quantity_used': ?instance.quantityUsed,
  'size_label': ?instance.sizeLabel,
};
