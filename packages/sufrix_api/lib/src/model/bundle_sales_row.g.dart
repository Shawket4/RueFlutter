// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bundle_sales_row.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BundleSalesRowCWProxy {
  BundleSalesRow bundleId(String? bundleId);

  BundleSalesRow bundleName(String bundleName);

  BundleSalesRow quantitySold(int quantitySold);

  BundleSalesRow revenue(int revenue);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BundleSalesRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BundleSalesRow(...).copyWith(id: 12, name: "My name")
  /// ````
  BundleSalesRow call({
    String? bundleId,
    String bundleName,
    int quantitySold,
    int revenue,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBundleSalesRow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBundleSalesRow.copyWith.fieldName(...)`
class _$BundleSalesRowCWProxyImpl implements _$BundleSalesRowCWProxy {
  const _$BundleSalesRowCWProxyImpl(this._value);

  final BundleSalesRow _value;

  @override
  BundleSalesRow bundleId(String? bundleId) => this(bundleId: bundleId);

  @override
  BundleSalesRow bundleName(String bundleName) => this(bundleName: bundleName);

  @override
  BundleSalesRow quantitySold(int quantitySold) =>
      this(quantitySold: quantitySold);

  @override
  BundleSalesRow revenue(int revenue) => this(revenue: revenue);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BundleSalesRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BundleSalesRow(...).copyWith(id: 12, name: "My name")
  /// ````
  BundleSalesRow call({
    Object? bundleId = const $CopyWithPlaceholder(),
    Object? bundleName = const $CopyWithPlaceholder(),
    Object? quantitySold = const $CopyWithPlaceholder(),
    Object? revenue = const $CopyWithPlaceholder(),
  }) {
    return BundleSalesRow(
      bundleId: bundleId == const $CopyWithPlaceholder()
          ? _value.bundleId
          // ignore: cast_nullable_to_non_nullable
          : bundleId as String?,
      bundleName: bundleName == const $CopyWithPlaceholder()
          ? _value.bundleName
          // ignore: cast_nullable_to_non_nullable
          : bundleName as String,
      quantitySold: quantitySold == const $CopyWithPlaceholder()
          ? _value.quantitySold
          // ignore: cast_nullable_to_non_nullable
          : quantitySold as int,
      revenue: revenue == const $CopyWithPlaceholder()
          ? _value.revenue
          // ignore: cast_nullable_to_non_nullable
          : revenue as int,
    );
  }
}

extension $BundleSalesRowCopyWith on BundleSalesRow {
  /// Returns a callable class that can be used as follows: `instanceOfBundleSalesRow.copyWith(...)` or like so:`instanceOfBundleSalesRow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BundleSalesRowCWProxy get copyWith => _$BundleSalesRowCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BundleSalesRow _$BundleSalesRowFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'BundleSalesRow',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['bundle_name', 'quantity_sold', 'revenue'],
        );
        final val = BundleSalesRow(
          bundleId: $checkedConvert('bundle_id', (v) => v as String?),
          bundleName: $checkedConvert('bundle_name', (v) => v as String),
          quantitySold: $checkedConvert(
            'quantity_sold',
            (v) => (v as num).toInt(),
          ),
          revenue: $checkedConvert('revenue', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'bundleId': 'bundle_id',
        'bundleName': 'bundle_name',
        'quantitySold': 'quantity_sold',
      },
    );

Map<String, dynamic> _$BundleSalesRowToJson(BundleSalesRow instance) =>
    <String, dynamic>{
      'bundle_id': ?instance.bundleId,
      'bundle_name': instance.bundleName,
      'quantity_sold': instance.quantitySold,
      'revenue': instance.revenue,
    };
