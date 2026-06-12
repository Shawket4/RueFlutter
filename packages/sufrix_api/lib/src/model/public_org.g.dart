// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_org.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PublicOrgCWProxy {
  PublicOrg address(String? address);

  PublicOrg branchCount(int? branchCount);

  PublicOrg createdAt(DateTime createdAt);

  PublicOrg logoUrl(String? logoUrl);

  PublicOrg name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PublicOrg(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PublicOrg(...).copyWith(id: 12, name: "My name")
  /// ````
  PublicOrg call({
    String? address,
    int? branchCount,
    DateTime createdAt,
    String? logoUrl,
    String name,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPublicOrg.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPublicOrg.copyWith.fieldName(...)`
class _$PublicOrgCWProxyImpl implements _$PublicOrgCWProxy {
  const _$PublicOrgCWProxyImpl(this._value);

  final PublicOrg _value;

  @override
  PublicOrg address(String? address) => this(address: address);

  @override
  PublicOrg branchCount(int? branchCount) => this(branchCount: branchCount);

  @override
  PublicOrg createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  PublicOrg logoUrl(String? logoUrl) => this(logoUrl: logoUrl);

  @override
  PublicOrg name(String name) => this(name: name);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PublicOrg(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PublicOrg(...).copyWith(id: 12, name: "My name")
  /// ````
  PublicOrg call({
    Object? address = const $CopyWithPlaceholder(),
    Object? branchCount = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? logoUrl = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return PublicOrg(
      address: address == const $CopyWithPlaceholder()
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String?,
      branchCount: branchCount == const $CopyWithPlaceholder()
          ? _value.branchCount
          // ignore: cast_nullable_to_non_nullable
          : branchCount as int?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      logoUrl: logoUrl == const $CopyWithPlaceholder()
          ? _value.logoUrl
          // ignore: cast_nullable_to_non_nullable
          : logoUrl as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $PublicOrgCopyWith on PublicOrg {
  /// Returns a callable class that can be used as follows: `instanceOfPublicOrg.copyWith(...)` or like so:`instanceOfPublicOrg.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PublicOrgCWProxy get copyWith => _$PublicOrgCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicOrg _$PublicOrgFromJson(Map<String, dynamic> json) => $checkedCreate(
  'PublicOrg',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['created_at', 'name']);
    final val = PublicOrg(
      address: $checkedConvert('address', (v) => v as String?),
      branchCount: $checkedConvert('branch_count', (v) => (v as num?)?.toInt()),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      logoUrl: $checkedConvert('logo_url', (v) => v as String?),
      name: $checkedConvert('name', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'branchCount': 'branch_count',
    'createdAt': 'created_at',
    'logoUrl': 'logo_url',
  },
);

Map<String, dynamic> _$PublicOrgToJson(PublicOrg instance) => <String, dynamic>{
  'address': ?instance.address,
  'branch_count': ?instance.branchCount,
  'created_at': instance.createdAt.toIso8601String(),
  'logo_url': ?instance.logoUrl,
  'name': instance.name,
};
