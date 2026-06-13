// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_ingredient.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrgIngredientCWProxy {
  OrgIngredient category(String category);

  OrgIngredient costPerUnit(double? costPerUnit);

  OrgIngredient createdAt(DateTime createdAt);

  OrgIngredient description(String? description);

  OrgIngredient id(String id);

  OrgIngredient isActive(bool isActive);

  OrgIngredient name(String name);

  OrgIngredient orgId(String orgId);

  OrgIngredient supplierId(String? supplierId);

  OrgIngredient supplierName(String? supplierName);

  OrgIngredient unit(String unit);

  OrgIngredient updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrgIngredient(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrgIngredient(...).copyWith(id: 12, name: "My name")
  /// ````
  OrgIngredient call({
    String category,
    double? costPerUnit,
    DateTime createdAt,
    String? description,
    String id,
    bool isActive,
    String name,
    String orgId,
    String? supplierId,
    String? supplierName,
    String unit,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrgIngredient.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrgIngredient.copyWith.fieldName(...)`
class _$OrgIngredientCWProxyImpl implements _$OrgIngredientCWProxy {
  const _$OrgIngredientCWProxyImpl(this._value);

  final OrgIngredient _value;

  @override
  OrgIngredient category(String category) => this(category: category);

  @override
  OrgIngredient costPerUnit(double? costPerUnit) =>
      this(costPerUnit: costPerUnit);

  @override
  OrgIngredient createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  OrgIngredient description(String? description) =>
      this(description: description);

  @override
  OrgIngredient id(String id) => this(id: id);

  @override
  OrgIngredient isActive(bool isActive) => this(isActive: isActive);

  @override
  OrgIngredient name(String name) => this(name: name);

  @override
  OrgIngredient orgId(String orgId) => this(orgId: orgId);

  @override
  OrgIngredient supplierId(String? supplierId) => this(supplierId: supplierId);

  @override
  OrgIngredient supplierName(String? supplierName) =>
      this(supplierName: supplierName);

  @override
  OrgIngredient unit(String unit) => this(unit: unit);

  @override
  OrgIngredient updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrgIngredient(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrgIngredient(...).copyWith(id: 12, name: "My name")
  /// ````
  OrgIngredient call({
    Object? category = const $CopyWithPlaceholder(),
    Object? costPerUnit = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
    Object? supplierId = const $CopyWithPlaceholder(),
    Object? supplierName = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return OrgIngredient(
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as String,
      costPerUnit: costPerUnit == const $CopyWithPlaceholder()
          ? _value.costPerUnit
          // ignore: cast_nullable_to_non_nullable
          : costPerUnit as double?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      orgId: orgId == const $CopyWithPlaceholder()
          ? _value.orgId
          // ignore: cast_nullable_to_non_nullable
          : orgId as String,
      supplierId: supplierId == const $CopyWithPlaceholder()
          ? _value.supplierId
          // ignore: cast_nullable_to_non_nullable
          : supplierId as String?,
      supplierName: supplierName == const $CopyWithPlaceholder()
          ? _value.supplierName
          // ignore: cast_nullable_to_non_nullable
          : supplierName as String?,
      unit: unit == const $CopyWithPlaceholder()
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as String,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $OrgIngredientCopyWith on OrgIngredient {
  /// Returns a callable class that can be used as follows: `instanceOfOrgIngredient.copyWith(...)` or like so:`instanceOfOrgIngredient.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrgIngredientCWProxy get copyWith => _$OrgIngredientCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgIngredient _$OrgIngredientFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'OrgIngredient',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'category',
            'created_at',
            'id',
            'is_active',
            'name',
            'org_id',
            'unit',
            'updated_at',
          ],
        );
        final val = OrgIngredient(
          category: $checkedConvert('category', (v) => v as String),
          costPerUnit: $checkedConvert(
            'cost_per_unit',
            (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
          ),
          createdAt: $checkedConvert(
            'created_at',
            (v) => DateTime.parse(v as String),
          ),
          description: $checkedConvert('description', (v) => v as String?),
          id: $checkedConvert('id', (v) => v as String),
          isActive: $checkedConvert('is_active', (v) => v as bool),
          name: $checkedConvert('name', (v) => v as String),
          orgId: $checkedConvert('org_id', (v) => v as String),
          supplierId: $checkedConvert('supplier_id', (v) => v as String?),
          supplierName: $checkedConvert('supplier_name', (v) => v as String?),
          unit: $checkedConvert('unit', (v) => v as String),
          updatedAt: $checkedConvert(
            'updated_at',
            (v) => DateTime.parse(v as String),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'costPerUnit': 'cost_per_unit',
        'createdAt': 'created_at',
        'isActive': 'is_active',
        'orgId': 'org_id',
        'supplierId': 'supplier_id',
        'supplierName': 'supplier_name',
        'updatedAt': 'updated_at',
      },
    );

Map<String, dynamic> _$OrgIngredientToJson(OrgIngredient instance) =>
    <String, dynamic>{
      'category': instance.category,
      'cost_per_unit': ?instance.costPerUnit,
      'created_at': instance.createdAt.toIso8601String(),
      'description': ?instance.description,
      'id': instance.id,
      'is_active': instance.isActive,
      'name': instance.name,
      'org_id': instance.orgId,
      'supplier_id': ?instance.supplierId,
      'supplier_name': ?instance.supplierName,
      'unit': instance.unit,
      'updated_at': instance.updatedAt.toIso8601String(),
    };
