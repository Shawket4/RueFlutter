// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_ingredient.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PreviewIngredientCWProxy {
  PreviewIngredient category(String category);

  PreviewIngredient ingredientName(String ingredientName);

  PreviewIngredient orgIngredientId(String? orgIngredientId);

  PreviewIngredient quantity(double quantity);

  PreviewIngredient source_(String source_);

  PreviewIngredient unit(String unit);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PreviewIngredient(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PreviewIngredient(...).copyWith(id: 12, name: "My name")
  /// ````
  PreviewIngredient call({
    String category,
    String ingredientName,
    String? orgIngredientId,
    double quantity,
    String source_,
    String unit,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPreviewIngredient.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPreviewIngredient.copyWith.fieldName(...)`
class _$PreviewIngredientCWProxyImpl implements _$PreviewIngredientCWProxy {
  const _$PreviewIngredientCWProxyImpl(this._value);

  final PreviewIngredient _value;

  @override
  PreviewIngredient category(String category) => this(category: category);

  @override
  PreviewIngredient ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  PreviewIngredient orgIngredientId(String? orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  PreviewIngredient quantity(double quantity) => this(quantity: quantity);

  @override
  PreviewIngredient source_(String source_) => this(source_: source_);

  @override
  PreviewIngredient unit(String unit) => this(unit: unit);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PreviewIngredient(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PreviewIngredient(...).copyWith(id: 12, name: "My name")
  /// ````
  PreviewIngredient call({
    Object? category = const $CopyWithPlaceholder(),
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? source_ = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
  }) {
    return PreviewIngredient(
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as String,
      ingredientName: ingredientName == const $CopyWithPlaceholder()
          ? _value.ingredientName
          // ignore: cast_nullable_to_non_nullable
          : ingredientName as String,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String?,
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as double,
      source_: source_ == const $CopyWithPlaceholder()
          ? _value.source_
          // ignore: cast_nullable_to_non_nullable
          : source_ as String,
      unit: unit == const $CopyWithPlaceholder()
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as String,
    );
  }
}

extension $PreviewIngredientCopyWith on PreviewIngredient {
  /// Returns a callable class that can be used as follows: `instanceOfPreviewIngredient.copyWith(...)` or like so:`instanceOfPreviewIngredient.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PreviewIngredientCWProxy get copyWith =>
      _$PreviewIngredientCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreviewIngredient _$PreviewIngredientFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PreviewIngredient',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'category',
            'ingredient_name',
            'quantity',
            'source',
            'unit',
          ],
        );
        final val = PreviewIngredient(
          category: $checkedConvert('category', (v) => v as String),
          ingredientName: $checkedConvert(
            'ingredient_name',
            (v) => v as String,
          ),
          orgIngredientId: $checkedConvert(
            'org_ingredient_id',
            (v) => v as String?,
          ),
          quantity: $checkedConvert('quantity', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
          source_: $checkedConvert('source', (v) => v as String),
          unit: $checkedConvert('unit', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'ingredientName': 'ingredient_name',
        'orgIngredientId': 'org_ingredient_id',
        'source_': 'source',
      },
    );

Map<String, dynamic> _$PreviewIngredientToJson(PreviewIngredient instance) =>
    <String, dynamic>{
      'category': instance.category,
      'ingredient_name': instance.ingredientName,
      'org_ingredient_id': ?instance.orgIngredientId,
      'quantity': instance.quantity,
      'source': instance.source_,
      'unit': instance.unit,
    };
