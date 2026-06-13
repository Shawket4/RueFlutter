// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_catalog_item_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateCatalogItemRequestCWProxy {
  UpdateCatalogItemRequest category(String? category);

  UpdateCatalogItemRequest costPerUnit(double? costPerUnit);

  UpdateCatalogItemRequest description(String? description);

  UpdateCatalogItemRequest isActive(bool? isActive);

  UpdateCatalogItemRequest name(String? name);

  UpdateCatalogItemRequest supplierId(String? supplierId);

  UpdateCatalogItemRequest unit(String? unit);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateCatalogItemRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateCatalogItemRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateCatalogItemRequest call({
    String? category,
    double? costPerUnit,
    String? description,
    bool? isActive,
    String? name,
    String? supplierId,
    String? unit,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateCatalogItemRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateCatalogItemRequest.copyWith.fieldName(...)`
class _$UpdateCatalogItemRequestCWProxyImpl
    implements _$UpdateCatalogItemRequestCWProxy {
  const _$UpdateCatalogItemRequestCWProxyImpl(this._value);

  final UpdateCatalogItemRequest _value;

  @override
  UpdateCatalogItemRequest category(String? category) =>
      this(category: category);

  @override
  UpdateCatalogItemRequest costPerUnit(double? costPerUnit) =>
      this(costPerUnit: costPerUnit);

  @override
  UpdateCatalogItemRequest description(String? description) =>
      this(description: description);

  @override
  UpdateCatalogItemRequest isActive(bool? isActive) => this(isActive: isActive);

  @override
  UpdateCatalogItemRequest name(String? name) => this(name: name);

  @override
  UpdateCatalogItemRequest supplierId(String? supplierId) =>
      this(supplierId: supplierId);

  @override
  UpdateCatalogItemRequest unit(String? unit) => this(unit: unit);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateCatalogItemRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateCatalogItemRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateCatalogItemRequest call({
    Object? category = const $CopyWithPlaceholder(),
    Object? costPerUnit = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? supplierId = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
  }) {
    return UpdateCatalogItemRequest(
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as String?,
      costPerUnit: costPerUnit == const $CopyWithPlaceholder()
          ? _value.costPerUnit
          // ignore: cast_nullable_to_non_nullable
          : costPerUnit as double?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      supplierId: supplierId == const $CopyWithPlaceholder()
          ? _value.supplierId
          // ignore: cast_nullable_to_non_nullable
          : supplierId as String?,
      unit: unit == const $CopyWithPlaceholder()
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as String?,
    );
  }
}

extension $UpdateCatalogItemRequestCopyWith on UpdateCatalogItemRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateCatalogItemRequest.copyWith(...)` or like so:`instanceOfUpdateCatalogItemRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateCatalogItemRequestCWProxy get copyWith =>
      _$UpdateCatalogItemRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCatalogItemRequest _$UpdateCatalogItemRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'UpdateCatalogItemRequest',
  json,
  ($checkedConvert) {
    final val = UpdateCatalogItemRequest(
      category: $checkedConvert('category', (v) => v as String?),
      costPerUnit: $checkedConvert(
        'cost_per_unit',
        (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
      ),
      description: $checkedConvert('description', (v) => v as String?),
      isActive: $checkedConvert('is_active', (v) => v as bool?),
      name: $checkedConvert('name', (v) => v as String?),
      supplierId: $checkedConvert('supplier_id', (v) => v as String?),
      unit: $checkedConvert('unit', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'costPerUnit': 'cost_per_unit',
    'isActive': 'is_active',
    'supplierId': 'supplier_id',
  },
);

Map<String, dynamic> _$UpdateCatalogItemRequestToJson(
  UpdateCatalogItemRequest instance,
) => <String, dynamic>{
  'category': ?instance.category,
  'cost_per_unit': ?instance.costPerUnit,
  'description': ?instance.description,
  'is_active': ?instance.isActive,
  'name': ?instance.name,
  'supplier_id': ?instance.supplierId,
  'unit': ?instance.unit,
};
