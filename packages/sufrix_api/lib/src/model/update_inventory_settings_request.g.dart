// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_inventory_settings_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateInventorySettingsRequestCWProxy {
  UpdateInventorySettingsRequest stocktakeVarianceThresholdPct(
    double stocktakeVarianceThresholdPct,
  );

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateInventorySettingsRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateInventorySettingsRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateInventorySettingsRequest call({double stocktakeVarianceThresholdPct});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateInventorySettingsRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateInventorySettingsRequest.copyWith.fieldName(...)`
class _$UpdateInventorySettingsRequestCWProxyImpl
    implements _$UpdateInventorySettingsRequestCWProxy {
  const _$UpdateInventorySettingsRequestCWProxyImpl(this._value);

  final UpdateInventorySettingsRequest _value;

  @override
  UpdateInventorySettingsRequest stocktakeVarianceThresholdPct(
    double stocktakeVarianceThresholdPct,
  ) => this(stocktakeVarianceThresholdPct: stocktakeVarianceThresholdPct);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateInventorySettingsRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateInventorySettingsRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateInventorySettingsRequest call({
    Object? stocktakeVarianceThresholdPct = const $CopyWithPlaceholder(),
  }) {
    return UpdateInventorySettingsRequest(
      stocktakeVarianceThresholdPct:
          stocktakeVarianceThresholdPct == const $CopyWithPlaceholder()
          ? _value.stocktakeVarianceThresholdPct
          // ignore: cast_nullable_to_non_nullable
          : stocktakeVarianceThresholdPct as double,
    );
  }
}

extension $UpdateInventorySettingsRequestCopyWith
    on UpdateInventorySettingsRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateInventorySettingsRequest.copyWith(...)` or like so:`instanceOfUpdateInventorySettingsRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateInventorySettingsRequestCWProxy get copyWith =>
      _$UpdateInventorySettingsRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateInventorySettingsRequest _$UpdateInventorySettingsRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'UpdateInventorySettingsRequest',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['stocktake_variance_threshold_pct']);
    final val = UpdateInventorySettingsRequest(
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

Map<String, dynamic> _$UpdateInventorySettingsRequestToJson(
  UpdateInventorySettingsRequest instance,
) => <String, dynamic>{
  'stocktake_variance_threshold_pct': instance.stocktakeVarianceThresholdPct,
};
