// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addon_sales_row.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddonSalesRowCWProxy {
  AddonSalesRow addonItemId(String addonItemId);

  AddonSalesRow addonName(String addonName);

  AddonSalesRow addonNameTranslations(Object addonNameTranslations);

  AddonSalesRow addonType(String addonType);

  AddonSalesRow quantitySold(int quantitySold);

  AddonSalesRow revenue(int revenue);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddonSalesRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddonSalesRow(...).copyWith(id: 12, name: "My name")
  /// ````
  AddonSalesRow call({
    String addonItemId,
    String addonName,
    Object addonNameTranslations,
    String addonType,
    int quantitySold,
    int revenue,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAddonSalesRow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAddonSalesRow.copyWith.fieldName(...)`
class _$AddonSalesRowCWProxyImpl implements _$AddonSalesRowCWProxy {
  const _$AddonSalesRowCWProxyImpl(this._value);

  final AddonSalesRow _value;

  @override
  AddonSalesRow addonItemId(String addonItemId) =>
      this(addonItemId: addonItemId);

  @override
  AddonSalesRow addonName(String addonName) => this(addonName: addonName);

  @override
  AddonSalesRow addonNameTranslations(Object addonNameTranslations) =>
      this(addonNameTranslations: addonNameTranslations);

  @override
  AddonSalesRow addonType(String addonType) => this(addonType: addonType);

  @override
  AddonSalesRow quantitySold(int quantitySold) =>
      this(quantitySold: quantitySold);

  @override
  AddonSalesRow revenue(int revenue) => this(revenue: revenue);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddonSalesRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddonSalesRow(...).copyWith(id: 12, name: "My name")
  /// ````
  AddonSalesRow call({
    Object? addonItemId = const $CopyWithPlaceholder(),
    Object? addonName = const $CopyWithPlaceholder(),
    Object? addonNameTranslations = const $CopyWithPlaceholder(),
    Object? addonType = const $CopyWithPlaceholder(),
    Object? quantitySold = const $CopyWithPlaceholder(),
    Object? revenue = const $CopyWithPlaceholder(),
  }) {
    return AddonSalesRow(
      addonItemId: addonItemId == const $CopyWithPlaceholder()
          ? _value.addonItemId
          // ignore: cast_nullable_to_non_nullable
          : addonItemId as String,
      addonName: addonName == const $CopyWithPlaceholder()
          ? _value.addonName
          // ignore: cast_nullable_to_non_nullable
          : addonName as String,
      addonNameTranslations:
          addonNameTranslations == const $CopyWithPlaceholder()
          ? _value.addonNameTranslations
          // ignore: cast_nullable_to_non_nullable
          : addonNameTranslations as Object,
      addonType: addonType == const $CopyWithPlaceholder()
          ? _value.addonType
          // ignore: cast_nullable_to_non_nullable
          : addonType as String,
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

extension $AddonSalesRowCopyWith on AddonSalesRow {
  /// Returns a callable class that can be used as follows: `instanceOfAddonSalesRow.copyWith(...)` or like so:`instanceOfAddonSalesRow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddonSalesRowCWProxy get copyWith => _$AddonSalesRowCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddonSalesRow _$AddonSalesRowFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AddonSalesRow',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'addon_item_id',
            'addon_name',
            'addon_name_translations',
            'addon_type',
            'quantity_sold',
            'revenue',
          ],
        );
        final val = AddonSalesRow(
          addonItemId: $checkedConvert('addon_item_id', (v) => v as String),
          addonName: $checkedConvert('addon_name', (v) => v as String),
          addonNameTranslations: $checkedConvert(
            'addon_name_translations',
            (v) => v as Object,
          ),
          addonType: $checkedConvert('addon_type', (v) => v as String),
          quantitySold: $checkedConvert(
            'quantity_sold',
            (v) => (v as num).toInt(),
          ),
          revenue: $checkedConvert('revenue', (v) => (v as num).toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'addonItemId': 'addon_item_id',
        'addonName': 'addon_name',
        'addonNameTranslations': 'addon_name_translations',
        'addonType': 'addon_type',
        'quantitySold': 'quantity_sold',
      },
    );

Map<String, dynamic> _$AddonSalesRowToJson(AddonSalesRow instance) =>
    <String, dynamic>{
      'addon_item_id': instance.addonItemId,
      'addon_name': instance.addonName,
      'addon_name_translations': instance.addonNameTranslations,
      'addon_type': instance.addonType,
      'quantity_sold': instance.quantitySold,
      'revenue': instance.revenue,
    };
