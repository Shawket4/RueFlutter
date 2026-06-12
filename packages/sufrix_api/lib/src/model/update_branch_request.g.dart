// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_branch_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateBranchRequestCWProxy {
  UpdateBranchRequest address(String? address);

  UpdateBranchRequest geoRadiusMeters(int? geoRadiusMeters);

  UpdateBranchRequest isActive(bool? isActive);

  UpdateBranchRequest latitude(double? latitude);

  UpdateBranchRequest longitude(double? longitude);

  UpdateBranchRequest name(String? name);

  UpdateBranchRequest phone(String? phone);

  UpdateBranchRequest printerBrand(PrinterBrand? printerBrand);

  UpdateBranchRequest printerIp(String? printerIp);

  UpdateBranchRequest printerPort(int? printerPort);

  UpdateBranchRequest timezone(String? timezone);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateBranchRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateBranchRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateBranchRequest call({
    String? address,
    int? geoRadiusMeters,
    bool? isActive,
    double? latitude,
    double? longitude,
    String? name,
    String? phone,
    PrinterBrand? printerBrand,
    String? printerIp,
    int? printerPort,
    String? timezone,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateBranchRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateBranchRequest.copyWith.fieldName(...)`
class _$UpdateBranchRequestCWProxyImpl implements _$UpdateBranchRequestCWProxy {
  const _$UpdateBranchRequestCWProxyImpl(this._value);

  final UpdateBranchRequest _value;

  @override
  UpdateBranchRequest address(String? address) => this(address: address);

  @override
  UpdateBranchRequest geoRadiusMeters(int? geoRadiusMeters) =>
      this(geoRadiusMeters: geoRadiusMeters);

  @override
  UpdateBranchRequest isActive(bool? isActive) => this(isActive: isActive);

  @override
  UpdateBranchRequest latitude(double? latitude) => this(latitude: latitude);

  @override
  UpdateBranchRequest longitude(double? longitude) =>
      this(longitude: longitude);

  @override
  UpdateBranchRequest name(String? name) => this(name: name);

  @override
  UpdateBranchRequest phone(String? phone) => this(phone: phone);

  @override
  UpdateBranchRequest printerBrand(PrinterBrand? printerBrand) =>
      this(printerBrand: printerBrand);

  @override
  UpdateBranchRequest printerIp(String? printerIp) =>
      this(printerIp: printerIp);

  @override
  UpdateBranchRequest printerPort(int? printerPort) =>
      this(printerPort: printerPort);

  @override
  UpdateBranchRequest timezone(String? timezone) => this(timezone: timezone);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateBranchRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateBranchRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateBranchRequest call({
    Object? address = const $CopyWithPlaceholder(),
    Object? geoRadiusMeters = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? latitude = const $CopyWithPlaceholder(),
    Object? longitude = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? printerBrand = const $CopyWithPlaceholder(),
    Object? printerIp = const $CopyWithPlaceholder(),
    Object? printerPort = const $CopyWithPlaceholder(),
    Object? timezone = const $CopyWithPlaceholder(),
  }) {
    return UpdateBranchRequest(
      address: address == const $CopyWithPlaceholder()
          ? _value.address
          // ignore: cast_nullable_to_non_nullable
          : address as String?,
      geoRadiusMeters: geoRadiusMeters == const $CopyWithPlaceholder()
          ? _value.geoRadiusMeters
          // ignore: cast_nullable_to_non_nullable
          : geoRadiusMeters as int?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
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
          : name as String?,
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

extension $UpdateBranchRequestCopyWith on UpdateBranchRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateBranchRequest.copyWith(...)` or like so:`instanceOfUpdateBranchRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateBranchRequestCWProxy get copyWith =>
      _$UpdateBranchRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateBranchRequest _$UpdateBranchRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'UpdateBranchRequest',
  json,
  ($checkedConvert) {
    final val = UpdateBranchRequest(
      address: $checkedConvert('address', (v) => v as String?),
      geoRadiusMeters: $checkedConvert(
        'geo_radius_meters',
        (v) => (v as num?)?.toInt(),
      ),
      isActive: $checkedConvert('is_active', (v) => v as bool?),
      latitude: $checkedConvert('latitude', (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble())),
      longitude: $checkedConvert('longitude', (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble())),
      name: $checkedConvert('name', (v) => v as String?),
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
    'isActive': 'is_active',
    'printerBrand': 'printer_brand',
    'printerIp': 'printer_ip',
    'printerPort': 'printer_port',
  },
);

Map<String, dynamic> _$UpdateBranchRequestToJson(
  UpdateBranchRequest instance,
) => <String, dynamic>{
  'address': ?instance.address,
  'geo_radius_meters': ?instance.geoRadiusMeters,
  'is_active': ?instance.isActive,
  'latitude': ?instance.latitude,
  'longitude': ?instance.longitude,
  'name': ?instance.name,
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
