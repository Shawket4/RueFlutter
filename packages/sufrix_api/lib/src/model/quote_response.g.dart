// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$QuoteResponseCWProxy {
  QuoteResponse distanceMeters(int? distanceMeters);

  QuoteResponse fee(int? fee);

  QuoteResponse status(String status);

  QuoteResponse zoneId(String? zoneId);

  QuoteResponse zoneName(String? zoneName);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `QuoteResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// QuoteResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  QuoteResponse call({
    int? distanceMeters,
    int? fee,
    String status,
    String? zoneId,
    String? zoneName,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfQuoteResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfQuoteResponse.copyWith.fieldName(...)`
class _$QuoteResponseCWProxyImpl implements _$QuoteResponseCWProxy {
  const _$QuoteResponseCWProxyImpl(this._value);

  final QuoteResponse _value;

  @override
  QuoteResponse distanceMeters(int? distanceMeters) =>
      this(distanceMeters: distanceMeters);

  @override
  QuoteResponse fee(int? fee) => this(fee: fee);

  @override
  QuoteResponse status(String status) => this(status: status);

  @override
  QuoteResponse zoneId(String? zoneId) => this(zoneId: zoneId);

  @override
  QuoteResponse zoneName(String? zoneName) => this(zoneName: zoneName);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `QuoteResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// QuoteResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  QuoteResponse call({
    Object? distanceMeters = const $CopyWithPlaceholder(),
    Object? fee = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? zoneId = const $CopyWithPlaceholder(),
    Object? zoneName = const $CopyWithPlaceholder(),
  }) {
    return QuoteResponse(
      distanceMeters: distanceMeters == const $CopyWithPlaceholder()
          ? _value.distanceMeters
          // ignore: cast_nullable_to_non_nullable
          : distanceMeters as int?,
      fee: fee == const $CopyWithPlaceholder()
          ? _value.fee
          // ignore: cast_nullable_to_non_nullable
          : fee as int?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String,
      zoneId: zoneId == const $CopyWithPlaceholder()
          ? _value.zoneId
          // ignore: cast_nullable_to_non_nullable
          : zoneId as String?,
      zoneName: zoneName == const $CopyWithPlaceholder()
          ? _value.zoneName
          // ignore: cast_nullable_to_non_nullable
          : zoneName as String?,
    );
  }
}

extension $QuoteResponseCopyWith on QuoteResponse {
  /// Returns a callable class that can be used as follows: `instanceOfQuoteResponse.copyWith(...)` or like so:`instanceOfQuoteResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$QuoteResponseCWProxy get copyWith => _$QuoteResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteResponse _$QuoteResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'QuoteResponse',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['status']);
        final val = QuoteResponse(
          distanceMeters: $checkedConvert(
            'distance_meters',
            (v) => (v as num?)?.toInt(),
          ),
          fee: $checkedConvert('fee', (v) => (v as num?)?.toInt()),
          status: $checkedConvert('status', (v) => v as String),
          zoneId: $checkedConvert('zone_id', (v) => v as String?),
          zoneName: $checkedConvert('zone_name', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'distanceMeters': 'distance_meters',
        'zoneId': 'zone_id',
        'zoneName': 'zone_name',
      },
    );

Map<String, dynamic> _$QuoteResponseToJson(QuoteResponse instance) =>
    <String, dynamic>{
      'distance_meters': ?instance.distanceMeters,
      'fee': ?instance.fee,
      'status': instance.status,
      'zone_id': ?instance.zoneId,
      'zone_name': ?instance.zoneName,
    };
