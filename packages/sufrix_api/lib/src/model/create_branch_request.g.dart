// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_branch_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateBranchRequestCWProxy {
  CreateBranchRequest address(String? address);

  CreateBranchRequest geoRadiusMeters(int? geoRadiusMeters);

  CreateBranchRequest latitude(double? latitude);

  CreateBranchRequest longitude(double? longitude);

  CreateBranchRequest name(String name);

  CreateBranchRequest orgId(String orgId);

  CreateBranchRequest phone(String? phone);

  CreateBranchRequest printerBrand(PrinterBrand? printerBrand);

  CreateBranchRequest printerIp(String? printerIp);

  CreateBranchRequest printerPort(int? printerPort);

  CreateBranchRequest timezone(String? timezone);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateBranchRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateBranchRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateBranchRequest call({
    String? address,
    int? geoRadiusMeters,
    double? latitude,
    double? longitude,
    String name,
    String orgId,
    String? phone,
    PrinterBrand? printerBrand,
    String? printerIp,
    int? printerPort,
    String? timezone,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateBranchRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateBranchRequest.copyWith.fieldName(...)`
class _$CreateBranchRequestCWProxyImpl implements _$CreateBranchRequestCWProxy {
  const _$CreateBranchRequestCWProxyImpl(this._value);

  final CreateBranchRequest _value;

  @override
  CreateBranchRequest address(String? address) => this(address: address);

  @override
  CreateBranchRequest geoRadiusMeters(int? geoRadiusMeters) =>
      this(geoRadiusMeters: geoRadiusMeters);

  @override
  CreateBranchRequest latitude(double? latitude) => this(latitude: latitude);

  @override
  CreateBranchRequest longitude(double? longitude) =>
      this(longitude: longitude);

  @override
  CreateBranchRequest name(String name) => this(name: name);

  @override
  CreateBranchRequest orgId(String orgId) => this(orgId: orgId);

  @override
  CreateBranchRequest phone(String? phone) => this(phone: phone);

  @override
  CreateBranchRequest printerBrand(PrinterBrand? printerBrand) =>
      this(printerBrand: printerBrand);

  @override
  CreateBranchRequest printerIp(String? printerIp) =>
      this(printerIp: printerIp);

  @override
  CreateBranchRequest printerPort(int? printerPort) =>
      this(printerPort: printerPort);

  @override
  CreateBranchRequest timezone(String? timezone) => this(timezone: timezone);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateBranchRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateBranchRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateBranchRequest call({
    Object? address = const $CopyWithPlaceholder(),
    Object? geoRadiusMeters = const $CopyWithPlaceholder(),
    Object? latitude = const $CopyWithPlaceholder(),
    Object? longitude = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? printerBrand = const $CopyWithPlaceholder(),
    Object? printerIp = const $CopyWithPlaceholder(),
    Object? printerPort = const $CopyWithPlaceholder(),
    Object? timezone = const $CopyWithPlaceholder(),
  }) {
    return CreateBranchRequest(
      address: address == const $CopyWithPlaceholder()
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String?,
      geoRadiusMeters: geoRadiusMeters == const $CopyWithPlaceholder()
          ? _value.geoRadiusMeters
          // ignore: cast_nullable_to_non_nullable
          : geoRadiusMeters as int?,
      latitude: latitude == const $CopyWithPlaceholder()
          ? _value.latitude
          // ignore: cast_nullable_to_non_nullable
          : latitude as double?,
      longitude: longitude == const $CopyWithPlaceholder()
          ? _value.longitude
          // ignore: cast_nullable_to_non_nullable
          : longitude as double?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      orgId: orgId == const $CopyWithPlaceholder()
          ? _value.orgId
          // ignore: cast_nullable_to_non_nullable
          : orgId as String,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
      printerBrand: printerBrand == const $CopyWithPlaceholder()
          ? _value.printerBrand
          // ignore: cast_nullable_to_non_nullable
          : printerBrand as PrinterBrand?,
      printerIp: printerIp == const $CopyWithPlaceholder()
          ? _value.printerIp
          // ignore: cast_nullable_to_non_nullable
          : printerIp as String?,
      printerPort: printerPort == const $CopyWithPlaceholder()
          ? _value.printerPort
          // ignore: cast_nullable_to_non_nullable
          : printerPort as int?,
      timezone: timezone == const $CopyWithPlaceholder()
          ? _value.timezone
          // ignore: cast_nullable_to_non_nullable
          : timezone as String?,
    );
  }
}

extension $CreateBranchRequestCopyWith on CreateBranchRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreateBranchRequest.copyWith(...)` or like so:`instanceOfCreateBranchRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateBranchRequestCWProxy get copyWith =>
      _$CreateBranchRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBranchRequest _$CreateBranchRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'CreateBranchRequest',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['name', 'org_id']);
    final val = CreateBranchRequest(
      address: $checkedConvert('address', (v) => v as String?),
      geoRadiusMeters: $checkedConvert(
        'geo_radius_meters',
        (v) => (v as num?)?.toInt(),
      ),
      latitude: $checkedConvert('latitude', (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble())),
      longitude: $checkedConvert('longitude', (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble())),
      name: $checkedConvert('name', (v) => v as String),
      orgId: $checkedConvert('org_id', (v) => v as String),
      phone: $checkedConvert('phone', (v) => v as String?),
      printerBrand: $checkedConvert(
        'printer_brand',
        (v) => $enumDecodeNullable(
          _$PrinterBrandEnumMap,
          v,
          unknownValue: PrinterBrand.unknownDefaultOpenApi,
        ),
      ),
      printerIp: $checkedConvert('printer_ip', (v) => v as String?),
      printerPort: $checkedConvert('printer_port', (v) => (v as num?)?.toInt()),
      timezone: $checkedConvert('timezone', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'geoRadiusMeters': 'geo_radius_meters',
    'orgId': 'org_id',
    'printerBrand': 'printer_brand',
    'printerIp': 'printer_ip',
    'printerPort': 'printer_port',
  },
);

Map<String, dynamic> _$CreateBranchRequestToJson(
  CreateBranchRequest instance,
) => <String, dynamic>{
  'address': ?instance.address,
  'geo_radius_meters': ?instance.geoRadiusMeters,
  'latitude': ?instance.latitude,
  'longitude': ?instance.longitude,
  'name': instance.name,
  'org_id': instance.orgId,
  'phone': ?instance.phone,
  'printer_brand': ?_$PrinterBrandEnumMap[instance.printerBrand],
  'printer_ip': ?instance.printerIp,
  'printer_port': ?instance.printerPort,
  'timezone': ?instance.timezone,
};

const _$PrinterBrandEnumMap = {
  PrinterBrand.star: 'star',
  PrinterBrand.epson: 'epson',
  PrinterBrand.unknownDefaultOpenApi: 'unknown_default_open_api',
};
