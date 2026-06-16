// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrgCWProxy {
  Org currencyCode(String currencyCode);

  Org id(String id);

  Org isActive(bool isActive);

  Org logoUrl(String? logoUrl);

  Org name(String name);

  Org receiptFooter(String? receiptFooter);

  Org slug(String slug);

  Org taxRate(double taxRate);

  Org timezone(String timezone);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Org(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Org(...).copyWith(id: 12, name: "My name")
  /// ````
  Org call({
    String currencyCode,
    String id,
    bool isActive,
    String? logoUrl,
    String name,
    String? receiptFooter,
    String slug,
    double taxRate,
    String timezone,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrg.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrg.copyWith.fieldName(...)`
class _$OrgCWProxyImpl implements _$OrgCWProxy {
  const _$OrgCWProxyImpl(this._value);

  final Org _value;

  @override
  Org currencyCode(String currencyCode) => this(currencyCode: currencyCode);

  @override
  Org id(String id) => this(id: id);

  @override
  Org isActive(bool isActive) => this(isActive: isActive);

  @override
  Org logoUrl(String? logoUrl) => this(logoUrl: logoUrl);

  @override
  Org name(String name) => this(name: name);

  @override
  Org receiptFooter(String? receiptFooter) =>
      this(receiptFooter: receiptFooter);

  @override
  Org slug(String slug) => this(slug: slug);

  @override
  Org taxRate(double taxRate) => this(taxRate: taxRate);

  @override
  Org timezone(String timezone) => this(timezone: timezone);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Org(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Org(...).copyWith(id: 12, name: "My name")
  /// ````
  Org call({
    Object? currencyCode = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? logoUrl = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? receiptFooter = const $CopyWithPlaceholder(),
    Object? slug = const $CopyWithPlaceholder(),
    Object? taxRate = const $CopyWithPlaceholder(),
    Object? timezone = const $CopyWithPlaceholder(),
  }) {
    return Org(
      currencyCode: currencyCode == const $CopyWithPlaceholder()
          ? _value.currencyCode
          // ignore: cast_nullable_to_non_nullable
          : currencyCode as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      logoUrl: logoUrl == const $CopyWithPlaceholder()
          ? _value.logoUrl
          // ignore: cast_nullable_to_non_nullable
          : logoUrl as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      receiptFooter: receiptFooter == const $CopyWithPlaceholder()
          ? _value.receiptFooter
          // ignore: cast_nullable_to_non_nullable
          : receiptFooter as String?,
      slug: slug == const $CopyWithPlaceholder()
          ? _value.slug
          // ignore: cast_nullable_to_non_nullable
          : slug as String,
      taxRate: taxRate == const $CopyWithPlaceholder()
          ? _value.taxRate
          // ignore: cast_nullable_to_non_nullable
          : taxRate as double,
      timezone: timezone == const $CopyWithPlaceholder()
          ? _value.timezone
          // ignore: cast_nullable_to_non_nullable
          : timezone as String,
    );
  }
}

extension $OrgCopyWith on Org {
  /// Returns a callable class that can be used as follows: `instanceOfOrg.copyWith(...)` or like so:`instanceOfOrg.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrgCWProxy get copyWith => _$OrgCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Org _$OrgFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Org',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'currency_code',
        'id',
        'is_active',
        'name',
        'slug',
        'tax_rate',
        'timezone',
      ],
    );
    final val = Org(
      currencyCode: $checkedConvert('currency_code', (v) => v as String),
      id: $checkedConvert('id', (v) => v as String),
      isActive: $checkedConvert('is_active', (v) => v as bool),
      logoUrl: $checkedConvert('logo_url', (v) => v as String?),
      name: $checkedConvert('name', (v) => v as String),
      receiptFooter: $checkedConvert('receipt_footer', (v) => v as String?),
      slug: $checkedConvert('slug', (v) => v as String),
      taxRate: $checkedConvert('tax_rate', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
      timezone: $checkedConvert('timezone', (v) => v as String),
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

Map<String, dynamic> _$OrgToJson(Org instance) => <String, dynamic>{
  'currency_code': instance.currencyCode,
  'id': instance.id,
  'is_active': instance.isActive,
  'logo_url': ?instance.logoUrl,
  'name': instance.name,
  'receipt_footer': ?instance.receiptFooter,
  'slug': instance.slug,
  'tax_rate': instance.taxRate,
  'timezone': instance.timezone,
};
