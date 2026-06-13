// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mode_summary.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ModeSummaryCWProxy {
  ModeSummary itemsCmTracked(int itemsCmTracked);

  ModeSummary itemsInsufficient(int itemsInsufficient);

  ModeSummary itemsRevenueOnly(int itemsRevenueOnly);

  ModeSummary itemsTotal(int itemsTotal);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ModeSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ModeSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  ModeSummary call({
    int itemsCmTracked,
    int itemsInsufficient,
    int itemsRevenueOnly,
    int itemsTotal,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfModeSummary.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfModeSummary.copyWith.fieldName(...)`
class _$ModeSummaryCWProxyImpl implements _$ModeSummaryCWProxy {
  const _$ModeSummaryCWProxyImpl(this._value);

  final ModeSummary _value;

  @override
  ModeSummary itemsCmTracked(int itemsCmTracked) =>
      this(itemsCmTracked: itemsCmTracked);

  @override
  ModeSummary itemsInsufficient(int itemsInsufficient) =>
      this(itemsInsufficient: itemsInsufficient);

  @override
  ModeSummary itemsRevenueOnly(int itemsRevenueOnly) =>
      this(itemsRevenueOnly: itemsRevenueOnly);

  @override
  ModeSummary itemsTotal(int itemsTotal) => this(itemsTotal: itemsTotal);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ModeSummary(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ModeSummary(...).copyWith(id: 12, name: "My name")
  /// ````
  ModeSummary call({
    Object? itemsCmTracked = const $CopyWithPlaceholder(),
    Object? itemsInsufficient = const $CopyWithPlaceholder(),
    Object? itemsRevenueOnly = const $CopyWithPlaceholder(),
    Object? itemsTotal = const $CopyWithPlaceholder(),
  }) {
    return ModeSummary(
      itemsCmTracked: itemsCmTracked == const $CopyWithPlaceholder()
          ? _value.itemsCmTracked
          // ignore: cast_nullable_to_non_nullable
          : itemsCmTracked as int,
      itemsInsufficient: itemsInsufficient == const $CopyWithPlaceholder()
          ? _value.itemsInsufficient
          // ignore: cast_nullable_to_non_nullable
          : itemsInsufficient as int,
      itemsRevenueOnly: itemsRevenueOnly == const $CopyWithPlaceholder()
          ? _value.itemsRevenueOnly
          // ignore: cast_nullable_to_non_nullable
          : itemsRevenueOnly as int,
      itemsTotal: itemsTotal == const $CopyWithPlaceholder()
          ? _value.itemsTotal
          // ignore: cast_nullable_to_non_nullable
          : itemsTotal as int,
    );
  }
}

extension $ModeSummaryCopyWith on ModeSummary {
  /// Returns a callable class that can be used as follows: `instanceOfModeSummary.copyWith(...)` or like so:`instanceOfModeSummary.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ModeSummaryCWProxy get copyWith => _$ModeSummaryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModeSummary _$ModeSummaryFromJson(Map<String, dynamic> json) => $checkedCreate(
  'ModeSummary',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'items_cm_tracked',
        'items_insufficient',
        'items_revenue_only',
        'items_total',
      ],
    );
    final val = ModeSummary(
      itemsCmTracked: $checkedConvert(
        'items_cm_tracked',
        (v) => (v as num).toInt(),
      ),
      itemsInsufficient: $checkedConvert(
        'items_insufficient',
        (v) => (v as num).toInt(),
      ),
      itemsRevenueOnly: $checkedConvert(
        'items_revenue_only',
        (v) => (v as num).toInt(),
      ),
      itemsTotal: $checkedConvert('items_total', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'itemsCmTracked': 'items_cm_tracked',
    'itemsInsufficient': 'items_insufficient',
    'itemsRevenueOnly': 'items_revenue_only',
    'itemsTotal': 'items_total',
  },
);

Map<String, dynamic> _$ModeSummaryToJson(ModeSummary instance) =>
    <String, dynamic>{
      'items_cm_tracked': instance.itemsCmTracked,
      'items_insufficient': instance.itemsInsufficient,
      'items_revenue_only': instance.itemsRevenueOnly,
      'items_total': instance.itemsTotal,
    };
