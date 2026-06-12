// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_menu_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PublicMenuResponseCWProxy {
  PublicMenuResponse categories(List<PublicCategory> categories);

  PublicMenuResponse logoUrl(String? logoUrl);

  PublicMenuResponse orgId(String orgId);

  PublicMenuResponse orgName(String orgName);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PublicMenuResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PublicMenuResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  PublicMenuResponse call({
    List<PublicCategory> categories,
    String? logoUrl,
    String orgId,
    String orgName,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPublicMenuResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPublicMenuResponse.copyWith.fieldName(...)`
class _$PublicMenuResponseCWProxyImpl implements _$PublicMenuResponseCWProxy {
  const _$PublicMenuResponseCWProxyImpl(this._value);

  final PublicMenuResponse _value;

  @override
  PublicMenuResponse categories(List<PublicCategory> categories) =>
      this(categories: categories);

  @override
  PublicMenuResponse logoUrl(String? logoUrl) => this(logoUrl: logoUrl);

  @override
  PublicMenuResponse orgId(String orgId) => this(orgId: orgId);

  @override
  PublicMenuResponse orgName(String orgName) => this(orgName: orgName);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PublicMenuResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PublicMenuResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  PublicMenuResponse call({
    Object? categories = const $CopyWithPlaceholder(),
    Object? logoUrl = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
    Object? orgName = const $CopyWithPlaceholder(),
  }) {
    return PublicMenuResponse(
      categories: categories == const $CopyWithPlaceholder()
          ? _value.categories
          // ignore: cast_nullable_to_non_nullable
          : categories as List<PublicCategory>,
      logoUrl: logoUrl == const $CopyWithPlaceholder()
          ? _value.logoUrl
          // ignore: cast_nullable_to_non_nullable
          : logoUrl as String?,
      orgId: orgId == const $CopyWithPlaceholder()
          ? _value.orgId
          // ignore: cast_nullable_to_non_nullable
          : orgId as String,
      orgName: orgName == const $CopyWithPlaceholder()
          ? _value.orgName
          // ignore: cast_nullable_to_non_nullable
          : orgName as String,
    );
  }
}

extension $PublicMenuResponseCopyWith on PublicMenuResponse {
  /// Returns a callable class that can be used as follows: `instanceOfPublicMenuResponse.copyWith(...)` or like so:`instanceOfPublicMenuResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PublicMenuResponseCWProxy get copyWith =>
      _$PublicMenuResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicMenuResponse _$PublicMenuResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PublicMenuResponse',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['categories', 'org_id', 'org_name'],
        );
        final val = PublicMenuResponse(
          categories: $checkedConvert(
            'categories',
            (v) => (v as List<dynamic>)
                .map((e) => PublicCategory.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          logoUrl: $checkedConvert('logo_url', (v) => v as String?),
          orgId: $checkedConvert('org_id', (v) => v as String),
          orgName: $checkedConvert('org_name', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'logoUrl': 'logo_url',
        'orgId': 'org_id',
        'orgName': 'org_name',
      },
    );

Map<String, dynamic> _$PublicMenuResponseToJson(PublicMenuResponse instance) =>
    <String, dynamic>{
      'categories': instance.categories.map((e) => e.toJson()).toList(),
      'logo_url': ?instance.logoUrl,
      'org_id': instance.orgId,
      'org_name': instance.orgName,
    };
