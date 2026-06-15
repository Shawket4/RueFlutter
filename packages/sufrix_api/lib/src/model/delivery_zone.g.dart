// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_zone.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DeliveryZoneCWProxy {
  DeliveryZone branchId(String branchId);

  DeliveryZone fee(int fee);

  DeliveryZone id(String id);

  DeliveryZone isActive(bool isActive);

  DeliveryZone maxRoadDistanceMeters(int maxRoadDistanceMeters);

  DeliveryZone name(String name);

  DeliveryZone nameTranslations(Object nameTranslations);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryZone(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryZone(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryZone call({
    String branchId,
    int fee,
    String id,
    bool isActive,
    int maxRoadDistanceMeters,
    String name,
    Object nameTranslations,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDeliveryZone.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDeliveryZone.copyWith.fieldName(...)`
class _$DeliveryZoneCWProxyImpl implements _$DeliveryZoneCWProxy {
  const _$DeliveryZoneCWProxyImpl(this._value);

  final DeliveryZone _value;

  @override
  DeliveryZone branchId(String branchId) => this(branchId: branchId);

  @override
  DeliveryZone fee(int fee) => this(fee: fee);

  @override
  DeliveryZone id(String id) => this(id: id);

  @override
  DeliveryZone isActive(bool isActive) => this(isActive: isActive);

  @override
  DeliveryZone maxRoadDistanceMeters(int maxRoadDistanceMeters) =>
      this(maxRoadDistanceMeters: maxRoadDistanceMeters);

  @override
  DeliveryZone name(String name) => this(name: name);

  @override
  DeliveryZone nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeliveryZone(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeliveryZone(...).copyWith(id: 12, name: "My name")
  /// ````
  DeliveryZone call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? fee = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? maxRoadDistanceMeters = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
  }) {
    return DeliveryZone(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      fee: fee == const $CopyWithPlaceholder()
          ? _value.fee
          // ignore: cast_nullable_to_non_nullable
          : fee as int,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
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
          : nameTranslations as Object,
    );
  }
}

extension $DeliveryZoneCopyWith on DeliveryZone {
  /// Returns a callable class that can be used as follows: `instanceOfDeliveryZone.copyWith(...)` or like so:`instanceOfDeliveryZone.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DeliveryZoneCWProxy get copyWith => _$DeliveryZoneCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryZone _$DeliveryZoneFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DeliveryZone',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'branch_id',
            'fee',
            'id',
            'is_active',
            'max_road_distance_meters',
            'name',
            'name_translations',
          ],
        );
        final val = DeliveryZone(
          branchId: $checkedConvert('branch_id', (v) => v as String),
          fee: $checkedConvert('fee', (v) => (v as num).toInt()),
          id: $checkedConvert('id', (v) => v as String),
          isActive: $checkedConvert('is_active', (v) => v as bool),
          maxRoadDistanceMeters: $checkedConvert(
            'max_road_distance_meters',
            (v) => (v as num).toInt(),
          ),
          name: $checkedConvert('name', (v) => v as String),
          nameTranslations: $checkedConvert(
            'name_translations',
            (v) => v as Object,
          ),
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

Map<String, dynamic> _$DeliveryZoneToJson(DeliveryZone instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'fee': instance.fee,
      'id': instance.id,
      'is_active': instance.isActive,
      'max_road_distance_meters': instance.maxRoadDistanceMeters,
      'name': instance.name,
      'name_translations': instance.nameTranslations,
    };
