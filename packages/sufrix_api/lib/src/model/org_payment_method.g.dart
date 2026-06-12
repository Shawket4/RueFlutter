// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_payment_method.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrgPaymentMethodCWProxy {
  OrgPaymentMethod color(String color);

  OrgPaymentMethod createdAt(DateTime createdAt);

  OrgPaymentMethod displayOrder(int displayOrder);

  OrgPaymentMethod icon(String icon);

  OrgPaymentMethod id(String id);

  OrgPaymentMethod isActive(bool isActive);

  OrgPaymentMethod isCash(bool isCash);

  OrgPaymentMethod labelTranslations(Object? labelTranslations);

  OrgPaymentMethod name(String name);

  OrgPaymentMethod orgId(String orgId);

  OrgPaymentMethod updatedAt(DateTime updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrgPaymentMethod(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrgPaymentMethod(...).copyWith(id: 12, name: "My name")
  /// ````
  OrgPaymentMethod call({
    String color,
    DateTime createdAt,
    int displayOrder,
    String icon,
    String id,
    bool isActive,
    bool isCash,
    Object? labelTranslations,
    String name,
    String orgId,
    DateTime updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrgPaymentMethod.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrgPaymentMethod.copyWith.fieldName(...)`
class _$OrgPaymentMethodCWProxyImpl implements _$OrgPaymentMethodCWProxy {
  const _$OrgPaymentMethodCWProxyImpl(this._value);

  final OrgPaymentMethod _value;

  @override
  OrgPaymentMethod color(String color) => this(color: color);

  @override
  OrgPaymentMethod createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  OrgPaymentMethod displayOrder(int displayOrder) =>
      this(displayOrder: displayOrder);

  @override
  OrgPaymentMethod icon(String icon) => this(icon: icon);

  @override
  OrgPaymentMethod id(String id) => this(id: id);

  @override
  OrgPaymentMethod isActive(bool isActive) => this(isActive: isActive);

  @override
  OrgPaymentMethod isCash(bool isCash) => this(isCash: isCash);

  @override
  OrgPaymentMethod labelTranslations(Object? labelTranslations) =>
      this(labelTranslations: labelTranslations);

  @override
  OrgPaymentMethod name(String name) => this(name: name);

  @override
  OrgPaymentMethod orgId(String orgId) => this(orgId: orgId);

  @override
  OrgPaymentMethod updatedAt(DateTime updatedAt) => this(updatedAt: updatedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrgPaymentMethod(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrgPaymentMethod(...).copyWith(id: 12, name: "My name")
  /// ````
  OrgPaymentMethod call({
    Object? color = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? icon = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? isCash = const $CopyWithPlaceholder(),
    Object? labelTranslations = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return OrgPaymentMethod(
      color: color == const $CopyWithPlaceholder()
          ? _value.color
          // ignore: cast_nullable_to_non_nullable
          : color as String,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      displayOrder: displayOrder == const $CopyWithPlaceholder()
          ? _value.displayOrder
          // ignore: cast_nullable_to_non_nullable
          : displayOrder as int,
      icon: icon == const $CopyWithPlaceholder()
          ? _value.icon
          // ignore: cast_nullable_to_non_nullable
          : icon as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      isCash: isCash == const $CopyWithPlaceholder()
          ? _value.isCash
          // ignore: cast_nullable_to_non_nullable
          : isCash as bool,
      labelTranslations: labelTranslations == const $CopyWithPlaceholder()
          ? _value.labelTranslations
          // ignore: cast_nullable_to_non_nullable
          : labelTranslations as Object?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      orgId: orgId == const $CopyWithPlaceholder()
          ? _value.orgId
          // ignore: cast_nullable_to_non_nullable
          : orgId as String,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime,
    );
  }
}

extension $OrgPaymentMethodCopyWith on OrgPaymentMethod {
  /// Returns a callable class that can be used as follows: `instanceOfOrgPaymentMethod.copyWith(...)` or like so:`instanceOfOrgPaymentMethod.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrgPaymentMethodCWProxy get copyWith => _$OrgPaymentMethodCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgPaymentMethod _$OrgPaymentMethodFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'OrgPaymentMethod',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'color',
            'created_at',
            'display_order',
            'icon',
            'id',
            'is_active',
            'is_cash',
            'label_translations',
            'name',
            'org_id',
            'updated_at',
          ],
        );
        final val = OrgPaymentMethod(
          color: $checkedConvert('color', (v) => v as String),
          createdAt: $checkedConvert(
            'created_at',
            (v) => DateTime.parse(v as String),
          ),
          displayOrder: $checkedConvert(
            'display_order',
            (v) => (v as num).toInt(),
          ),
          icon: $checkedConvert('icon', (v) => v as String),
          id: $checkedConvert('id', (v) => v as String),
          isActive: $checkedConvert('is_active', (v) => v as bool),
          isCash: $checkedConvert('is_cash', (v) => v as bool),
          labelTranslations: $checkedConvert('label_translations', (v) => v),
          name: $checkedConvert('name', (v) => v as String),
          orgId: $checkedConvert('org_id', (v) => v as String),
          updatedAt: $checkedConvert(
            'updated_at',
            (v) => DateTime.parse(v as String),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'createdAt': 'created_at',
        'displayOrder': 'display_order',
        'isActive': 'is_active',
        'isCash': 'is_cash',
        'labelTranslations': 'label_translations',
        'orgId': 'org_id',
        'updatedAt': 'updated_at',
      },
    );

Map<String, dynamic> _$OrgPaymentMethodToJson(OrgPaymentMethod instance) =>
    <String, dynamic>{
      'color': instance.color,
      'created_at': instance.createdAt.toIso8601String(),
      'display_order': instance.displayOrder,
      'icon': instance.icon,
      'id': instance.id,
      'is_active': instance.isActive,
      'is_cash': instance.isCash,
      'label_translations': instance.labelTranslations,
      'name': instance.name,
      'org_id': instance.orgId,
      'updated_at': instance.updatedAt.toIso8601String(),
    };
