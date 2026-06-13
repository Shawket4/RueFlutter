// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'org_inventory_settings.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OrgInventorySettingsCWProxy {
  OrgInventorySettings stocktakeVarianceThresholdPct(
    double stocktakeVarianceThresholdPct,
  );

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrgInventorySettings(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrgInventorySettings(...).copyWith(id: 12, name: "My name")
  /// ````
  OrgInventorySettings call({double stocktakeVarianceThresholdPct});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOrgInventorySettings.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOrgInventorySettings.copyWith.fieldName(...)`
class _$OrgInventorySettingsCWProxyImpl
    implements _$OrgInventorySettingsCWProxy {
  const _$OrgInventorySettingsCWProxyImpl(this._value);

  final OrgInventorySettings _value;

  @override
  OrgInventorySettings stocktakeVarianceThresholdPct(
    double stocktakeVarianceThresholdPct,
  ) => this(stocktakeVarianceThresholdPct: stocktakeVarianceThresholdPct);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OrgInventorySettings(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OrgInventorySettings(...).copyWith(id: 12, name: "My name")
  /// ````
  OrgInventorySettings call({
    Object? stocktakeVarianceThresholdPct = const $CopyWithPlaceholder(),
  }) {
    return OrgInventorySettings(
      stocktakeVarianceThresholdPct:
          stocktakeVarianceThresholdPct == const $CopyWithPlaceholder()
          ? _value.stocktakeVarianceThresholdPct
          // ignore: cast_nullable_to_non_nullable
          : stocktakeVarianceThresholdPct as double,
    );
  }
}

extension $OrgInventorySettingsCopyWith on OrgInventorySettings {
  /// Returns a callable class that can be used as follows: `instanceOfOrgInventorySettings.copyWith(...)` or like so:`instanceOfOrgInventorySettings.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OrgInventorySettingsCWProxy get copyWith =>
      _$OrgInventorySettingsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrgInventorySettings _$OrgInventorySettingsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'OrgInventorySettings',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['stocktake_variance_threshold_pct']);
    final val = OrgInventorySettings(
      stocktakeVarianceThresholdPct: $checkedConvert(
        'stocktake_variance_threshold_pct',
        (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'stocktakeVarianceThresholdPct': 'stocktake_variance_threshold_pct',
  },
);

Map<String, dynamic> _$OrgInventorySettingsToJson(
  OrgInventorySettings instance,
) => <String, dynamic>{
  'stocktake_variance_threshold_pct': instance.stocktakeVarianceThresholdPct,
};
