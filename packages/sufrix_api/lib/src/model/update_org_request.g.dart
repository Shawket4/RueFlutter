// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_org_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateOrgRequestCWProxy {
  UpdateOrgRequest currencyCode(String? currencyCode);

  UpdateOrgRequest isActive(bool? isActive);

  UpdateOrgRequest logoUrl(String? logoUrl);

  UpdateOrgRequest name(String? name);

  UpdateOrgRequest receiptFooter(String? receiptFooter);

  UpdateOrgRequest slug(String? slug);

  UpdateOrgRequest taxRate(double? taxRate);

  UpdateOrgRequest timezone(String? timezone);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateOrgRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateOrgRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateOrgRequest call({
    String? currencyCode,
    bool? isActive,
    String? logoUrl,
    String? name,
    String? receiptFooter,
    String? slug,
    double? taxRate,
    String? timezone,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateOrgRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateOrgRequest.copyWith.fieldName(...)`
class _$UpdateOrgRequestCWProxyImpl implements _$UpdateOrgRequestCWProxy {
  const _$UpdateOrgRequestCWProxyImpl(this._value);

  final UpdateOrgRequest _value;

  @override
  UpdateOrgRequest currencyCode(String? currencyCode) =>
      this(currencyCode: currencyCode);

  @override
  UpdateOrgRequest isActive(bool? isActive) => this(isActive: isActive);

  @override
  UpdateOrgRequest logoUrl(String? logoUrl) => this(logoUrl: logoUrl);

  @override
  UpdateOrgRequest name(String? name) => this(name: name);

  @override
  UpdateOrgRequest receiptFooter(String? receiptFooter) =>
      this(receiptFooter: receiptFooter);

  @override
  UpdateOrgRequest slug(String? slug) => this(slug: slug);

  @override
  UpdateOrgRequest taxRate(double? taxRate) => this(taxRate: taxRate);

  @override
  UpdateOrgRequest timezone(String? timezone) => this(timezone: timezone);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateOrgRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateOrgRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateOrgRequest call({
    Object? currencyCode = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? logoUrl = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? receiptFooter = const $CopyWithPlaceholder(),
    Object? slug = const $CopyWithPlaceholder(),
    Object? taxRate = const $CopyWithPlaceholder(),
    Object? timezone = const $CopyWithPlaceholder(),
  }) {
    return UpdateOrgRequest(
      currencyCode: currencyCode == const $CopyWithPlaceholder()
          ? _value.currencyCode
          // ignore: cast_nullable_to_non_nullable
          : currencyCode as String?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      logoUrl: logoUrl == const $CopyWithPlaceholder()
          ? _value.logoUrl
          // ignore: cast_nullable_to_non_nullable
          : logoUrl as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      receiptFooter: receiptFooter == const $CopyWithPlaceholder()
          ? _value.receiptFooter
          // ignore: cast_nullable_to_non_nullable
          : receiptFooter as String?,
      slug: slug == const $CopyWithPlaceholder()
          ? _value.slug
          // ignore: cast_nullable_to_non_nullable
          : slug as String?,
      taxRate: taxRate == const $CopyWithPlaceholder()
          ? _value.taxRate
          // ignore: cast_nullable_to_non_nullable
          : taxRate as double?,
      timezone: timezone == const $CopyWithPlaceholder()
          ? _value.timezone
          // ignore: cast_nullable_to_non_nullable
          : timezone as String?,
    );
  }
}

extension $UpdateOrgRequestCopyWith on UpdateOrgRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateOrgRequest.copyWith(...)` or like so:`instanceOfUpdateOrgRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateOrgRequestCWProxy get copyWith => _$UpdateOrgRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateOrgRequest _$UpdateOrgRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UpdateOrgRequest',
      json,
      ($checkedConvert) {
        final val = UpdateOrgRequest(
          currencyCode: $checkedConvert('currency_code', (v) => v as String?),
          isActive: $checkedConvert('is_active', (v) => v as bool?),
          logoUrl: $checkedConvert('logo_url', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
          receiptFooter: $checkedConvert('receipt_footer', (v) => v as String?),
          slug: $checkedConvert('slug', (v) => v as String?),
          taxRate: $checkedConvert('tax_rate', (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble())),
          timezone: $checkedConvert('timezone', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'currencyCode': 'currency_code',
        'isActive': 'is_active',
        'logoUrl': 'logo_url',
        'receiptFooter': 'receipt_footer',
        'taxRate': 'tax_rate',
      },
    );

Map<String, dynamic> _$UpdateOrgRequestToJson(UpdateOrgRequest instance) =>
    <String, dynamic>{
      'currency_code': ?instance.currencyCode,
      'is_active': ?instance.isActive,
      'logo_url': ?instance.logoUrl,
      'name': ?instance.name,
      'receipt_footer': ?instance.receiptFooter,
      'slug': ?instance.slug,
      'tax_rate': ?instance.taxRate,
      'timezone': ?instance.timezone,
    };
