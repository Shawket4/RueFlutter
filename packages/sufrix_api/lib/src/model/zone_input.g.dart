// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ZoneInputCWProxy {
  ZoneInput branchId(String branchId);

  ZoneInput fee(int fee);

  ZoneInput isActive(bool? isActive);

  ZoneInput maxRoadDistanceMeters(int maxRoadDistanceMeters);

  ZoneInput name(String name);

  ZoneInput nameTranslations(Object? nameTranslations);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ZoneInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ZoneInput(...).copyWith(id: 12, name: "My name")
  /// ````
  ZoneInput call({
    String branchId,
    int fee,
    bool? isActive,
    int maxRoadDistanceMeters,
    String name,
    Object? nameTranslations,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfZoneInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfZoneInput.copyWith.fieldName(...)`
class _$ZoneInputCWProxyImpl implements _$ZoneInputCWProxy {
  const _$ZoneInputCWProxyImpl(this._value);

  final ZoneInput _value;

  @override
  ZoneInput branchId(String branchId) => this(branchId: branchId);

  @override
  ZoneInput fee(int fee) => this(fee: fee);

  @override
  ZoneInput isActive(bool? isActive) => this(isActive: isActive);

  @override
  ZoneInput maxRoadDistanceMeters(int maxRoadDistanceMeters) =>
      this(maxRoadDistanceMeters: maxRoadDistanceMeters);

  @override
  ZoneInput name(String name) => this(name: name);

  @override
  ZoneInput nameTranslations(Object? nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ZoneInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ZoneInput(...).copyWith(id: 12, name: "My name")
  /// ````
  ZoneInput call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? fee = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? maxRoadDistanceMeters = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
  }) {
    return ZoneInput(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      fee: fee == const $CopyWithPlaceholder()
          ? _value.fee
          // ignore: cast_nullable_to_non_nullable
          : fee as int,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      maxRoadDistanceMeters:
          maxRoadDistanceMeters == const $CopyWithPlaceholder()
          ? _value.maxRoadDistanceMeters
          // ignore: cast_nullable_to_non_nullable
          : maxRoadDistanceMeters as int,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      nameTranslations: nameTranslations == const $CopyWithPlaceholder()
          ? _value.nameTranslations
          // ignore: cast_nullable_to_non_nullable
          : nameTranslations as Object?,
    );
  }
}

extension $ZoneInputCopyWith on ZoneInput {
  /// Returns a callable class that can be used as follows: `instanceOfZoneInput.copyWith(...)` or like so:`instanceOfZoneInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ZoneInputCWProxy get copyWith => _$ZoneInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZoneInput _$ZoneInputFromJson(Map<String, dynamic> json) => $checkedCreate(
  'ZoneInput',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'branch_id',
        'fee',
        'max_road_distance_meters',
        'name',
      ],
    );
    final val = ZoneInput(
      branchId: $checkedConvert('branch_id', (v) => v as String),
      fee: $checkedConvert('fee', (v) => (v as num).toInt()),
      isActive: $checkedConvert('is_active', (v) => v as bool?),
      maxRoadDistanceMeters: $checkedConvert(
        'max_road_distance_meters',
        (v) => (v as num).toInt(),
      ),
      name: $checkedConvert('name', (v) => v as String),
      nameTranslations: $checkedConvert('name_translations', (v) => v),
    );
    return val;
  },
  fieldKeyMap: const {
    'branchId': 'branch_id',
    'isActive': 'is_active',
    'maxRoadDistanceMeters': 'max_road_distance_meters',
    'nameTranslations': 'name_translations',
  },
);

Map<String, dynamic> _$ZoneInputToJson(ZoneInput instance) => <String, dynamic>{
  'branch_id': instance.branchId,
  'fee': instance.fee,
  'is_active': ?instance.isActive,
  'max_road_distance_meters': instance.maxRoadDistanceMeters,
  'name': instance.name,
  'name_translations': ?instance.nameTranslations,
};
