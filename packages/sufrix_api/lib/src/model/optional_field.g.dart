// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'optional_field.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OptionalFieldCWProxy {
  OptionalField createdAt(DateTime createdAt);

  OptionalField id(String id);

  OptionalField ingredientName(String? ingredientName);

  OptionalField ingredientUnit(String? ingredientUnit);

  OptionalField isActive(bool isActive);

  OptionalField menuItemId(String menuItemId);

  OptionalField name(String name);

  OptionalField nameTranslations(Object nameTranslations);

  OptionalField orgIngredientId(String? orgIngredientId);

  OptionalField price(int price);

  OptionalField quantityUsed(double? quantityUsed);

  OptionalField sizeLabel(String? sizeLabel);

  OptionalField updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OptionalField(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OptionalField(...).copyWith(id: 12, name: "My name")
  /// ````
  OptionalField call({
    DateTime createdAt,
    String id,
    String? ingredientName,
    String? ingredientUnit,
    bool isActive,
    String menuItemId,
    String name,
    Object nameTranslations,
    String? orgIngredientId,
    int price,
    double? quantityUsed,
    String? sizeLabel,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOptionalField.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOptionalField.copyWith.fieldName(...)`
class _$OptionalFieldCWProxyImpl implements _$OptionalFieldCWProxy {
  const _$OptionalFieldCWProxyImpl(this._value);

  final OptionalField _value;

  @override
  OptionalField createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  OptionalField id(String id) => this(id: id);

  @override
  OptionalField ingredientName(String? ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  OptionalField ingredientUnit(String? ingredientUnit) =>
      this(ingredientUnit: ingredientUnit);

  @override
  OptionalField isActive(bool isActive) => this(isActive: isActive);

  @override
  OptionalField menuItemId(String menuItemId) => this(menuItemId: menuItemId);

  @override
  OptionalField name(String name) => this(name: name);

  @override
  OptionalField nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  OptionalField orgIngredientId(String? orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  OptionalField price(int price) => this(price: price);

  @override
  OptionalField quantityUsed(double? quantityUsed) =>
      this(quantityUsed: quantityUsed);

  @override
  OptionalField sizeLabel(String? sizeLabel) => this(sizeLabel: sizeLabel);

  @override
  OptionalField updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OptionalField(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OptionalField(...).copyWith(id: 12, name: "My name")
  /// ````
  OptionalField call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? ingredientUnit = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
    Object? quantityUsed = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return OptionalField(
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
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
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      menuItemId: menuItemId == const $CopyWithPlaceholder()
          ? _value.menuItemId
          // ignore: cast_nullable_to_non_nullable
          : menuItemId as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      nameTranslations: nameTranslations == const $CopyWithPlaceholder()
          ? _value.nameTranslations
          // ignore: cast_nullable_to_non_nullable
          : nameTranslations as Object,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String?,
      price: price == const $CopyWithPlaceholder()
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as int,
      quantityUsed: quantityUsed == const $CopyWithPlaceholder()
          ? _value.quantityUsed
          // ignore: cast_nullable_to_non_nullable
          : quantityUsed as double?,
      sizeLabel: sizeLabel == const $CopyWithPlaceholder()
          ? _value.sizeLabel
          // ignore: cast_nullable_to_non_nullable
          : sizeLabel as String?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $OptionalFieldCopyWith on OptionalField {
  /// Returns a callable class that can be used as follows: `instanceOfOptionalField.copyWith(...)` or like so:`instanceOfOptionalField.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OptionalFieldCWProxy get copyWith => _$OptionalFieldCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionalField _$OptionalFieldFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'OptionalField',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'created_at',
        'id',
        'is_active',
        'menu_item_id',
        'name',
        'name_translations',
        'price',
        'updated_at',
      ],
    );
    final val = OptionalField(
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      id: $checkedConvert('id', (v) => v as String),
      ingredientName: $checkedConvert('ingredient_name', (v) => v as String?),
      ingredientUnit: $checkedConvert('ingredient_unit', (v) => v as String?),
      isActive: $checkedConvert('is_active', (v) => v as bool),
      menuItemId: $checkedConvert('menu_item_id', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      nameTranslations: $checkedConvert(
        'name_translations',
        (v) => v as Object,
      ),
      orgIngredientId: $checkedConvert(
        'org_ingredient_id',
        (v) => v as String?,
      ),
      price: $checkedConvert('price', (v) => (v as num).toInt()),
      quantityUsed: $checkedConvert(
        'quantity_used',
        (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
      ),
      sizeLabel: $checkedConvert('size_label', (v) => v as String?),
      updatedAt: $checkedConvert(
        'updated_at',
        (v) => DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'createdAt': 'created_at',
    'ingredientName': 'ingredient_name',
    'ingredientUnit': 'ingredient_unit',
    'isActive': 'is_active',
    'menuItemId': 'menu_item_id',
    'nameTranslations': 'name_translations',
    'orgIngredientId': 'org_ingredient_id',
    'quantityUsed': 'quantity_used',
    'sizeLabel': 'size_label',
    'updatedAt': 'updated_at',
  },
);

Map<String, dynamic> _$OptionalFieldToJson(OptionalField instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt.toIso8601String(),
      'id': instance.id,
      'ingredient_name': ?instance.ingredientName,
      'ingredient_unit': ?instance.ingredientUnit,
      'is_active': instance.isActive,
      'menu_item_id': instance.menuItemId,
      'name': instance.name,
      'name_translations': instance.nameTranslations,
      'org_ingredient_id': ?instance.orgIngredientId,
      'price': instance.price,
      'quantity_used': ?instance.quantityUsed,
      'size_label': ?instance.sizeLabel,
      'updated_at': instance.updatedAt.toIso8601String(),
    };
