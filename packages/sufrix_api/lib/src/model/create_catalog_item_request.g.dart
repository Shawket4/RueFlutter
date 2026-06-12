// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_catalog_item_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateCatalogItemRequestCWProxy {
  CreateCatalogItemRequest category(String category);

  CreateCatalogItemRequest costPerUnit(double? costPerUnit);

  CreateCatalogItemRequest description(String? description);

  CreateCatalogItemRequest name(String name);

  CreateCatalogItemRequest unit(String unit);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateCatalogItemRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateCatalogItemRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateCatalogItemRequest call({
    String category,
    double? costPerUnit,
    String? description,
    String name,
    String unit,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateCatalogItemRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateCatalogItemRequest.copyWith.fieldName(...)`
class _$CreateCatalogItemRequestCWProxyImpl
    implements _$CreateCatalogItemRequestCWProxy {
  const _$CreateCatalogItemRequestCWProxyImpl(this._value);

  final CreateCatalogItemRequest _value;

  @override
  CreateCatalogItemRequest category(String category) =>
      this(category: category);

  @override
  CreateCatalogItemRequest costPerUnit(double? costPerUnit) =>
      this(costPerUnit: costPerUnit);

  @override
  CreateCatalogItemRequest description(String? description) =>
      this(description: description);

  @override
  CreateCatalogItemRequest name(String name) => this(name: name);

  @override
  CreateCatalogItemRequest unit(String unit) => this(unit: unit);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateCatalogItemRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateCatalogItemRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateCatalogItemRequest call({
    Object? category = const $CopyWithPlaceholder(),
    Object? costPerUnit = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
  }) {
    return CreateCatalogItemRequest(
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as String,
      costPerUnit: costPerUnit == const $CopyWithPlaceholder()
          ? _value.costPerUnit
          // ignore: cast_nullable_to_non_nullable
          : costPerUnit as double?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      unit: unit == const $CopyWithPlaceholder()
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as String,
    );
  }
}

extension $CreateCatalogItemRequestCopyWith on CreateCatalogItemRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreateCatalogItemRequest.copyWith(...)` or like so:`instanceOfCreateCatalogItemRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateCatalogItemRequestCWProxy get copyWith =>
      _$CreateCatalogItemRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCatalogItemRequest _$CreateCatalogItemRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'CreateCatalogItemRequest',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['category', 'name', 'unit']);
    final val = CreateCatalogItemRequest(
      category: $checkedConvert('category', (v) => v as String),
      costPerUnit: $checkedConvert(
        'cost_per_unit',
        (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
      ),
      description: $checkedConvert('description', (v) => v as String?),
      name: $checkedConvert('name', (v) => v as String),
      unit: $checkedConvert('unit', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {'costPerUnit': 'cost_per_unit'},
);

Map<String, dynamic> _$CreateCatalogItemRequestToJson(
  CreateCatalogItemRequest instance,
) => <String, dynamic>{
  'category': instance.category,
  'cost_per_unit': ?instance.costPerUnit,
  'description': ?instance.description,
  'name': instance.name,
  'unit': instance.unit,
};
