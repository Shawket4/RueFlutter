// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combined_item_sales_row.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CombinedItemSalesRowCWProxy {
  CombinedItemSalesRow bundleQty(int bundleQty);

  CombinedItemSalesRow itemId(String? itemId);

  CombinedItemSalesRow itemName(String itemName);

  CombinedItemSalesRow itemNameTranslations(Object itemNameTranslations);

  CombinedItemSalesRow standaloneQty(int standaloneQty);

  CombinedItemSalesRow totalQty(int totalQty);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CombinedItemSalesRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CombinedItemSalesRow(...).copyWith(id: 12, name: "My name")
  /// ````
  CombinedItemSalesRow call({
    int bundleQty,
    String? itemId,
    String itemName,
    Object itemNameTranslations,
    int standaloneQty,
    int totalQty,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCombinedItemSalesRow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCombinedItemSalesRow.copyWith.fieldName(...)`
class _$CombinedItemSalesRowCWProxyImpl
    implements _$CombinedItemSalesRowCWProxy {
  const _$CombinedItemSalesRowCWProxyImpl(this._value);

  final CombinedItemSalesRow _value;

  @override
  CombinedItemSalesRow bundleQty(int bundleQty) => this(bundleQty: bundleQty);

  @override
  CombinedItemSalesRow itemId(String? itemId) => this(itemId: itemId);

  @override
  CombinedItemSalesRow itemName(String itemName) => this(itemName: itemName);

  @override
  CombinedItemSalesRow itemNameTranslations(Object itemNameTranslations) =>
      this(itemNameTranslations: itemNameTranslations);

  @override
  CombinedItemSalesRow standaloneQty(int standaloneQty) =>
      this(standaloneQty: standaloneQty);

  @override
  CombinedItemSalesRow totalQty(int totalQty) => this(totalQty: totalQty);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CombinedItemSalesRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CombinedItemSalesRow(...).copyWith(id: 12, name: "My name")
  /// ````
  CombinedItemSalesRow call({
    Object? bundleQty = const $CopyWithPlaceholder(),
    Object? itemId = const $CopyWithPlaceholder(),
    Object? itemName = const $CopyWithPlaceholder(),
    Object? itemNameTranslations = const $CopyWithPlaceholder(),
    Object? standaloneQty = const $CopyWithPlaceholder(),
    Object? totalQty = const $CopyWithPlaceholder(),
  }) {
    return CombinedItemSalesRow(
      bundleQty: bundleQty == const $CopyWithPlaceholder()
          ? _value.bundleQty
          // ignore: cast_nullable_to_non_nullable
          : bundleQty as int,
      itemId: itemId == const $CopyWithPlaceholder()
          ? _value.itemId
          // ignore: cast_nullable_to_non_nullable
          : itemId as String?,
      itemName: itemName == const $CopyWithPlaceholder()
          ? _value.itemName
          // ignore: cast_nullable_to_non_nullable
          : itemName as String,
      itemNameTranslations: itemNameTranslations == const $CopyWithPlaceholder()
          ? _value.itemNameTranslations
          // ignore: cast_nullable_to_non_nullable
          : itemNameTranslations as Object,
      standaloneQty: standaloneQty == const $CopyWithPlaceholder()
          ? _value.standaloneQty
          // ignore: cast_nullable_to_non_nullable
          : standaloneQty as int,
      totalQty: totalQty == const $CopyWithPlaceholder()
          ? _value.totalQty
          // ignore: cast_nullable_to_non_nullable
          : totalQty as int,
    );
  }
}

extension $CombinedItemSalesRowCopyWith on CombinedItemSalesRow {
  /// Returns a callable class that can be used as follows: `instanceOfCombinedItemSalesRow.copyWith(...)` or like so:`instanceOfCombinedItemSalesRow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CombinedItemSalesRowCWProxy get copyWith =>
      _$CombinedItemSalesRowCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CombinedItemSalesRow _$CombinedItemSalesRowFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'CombinedItemSalesRow',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'bundle_qty',
        'item_name',
        'item_name_translations',
        'standalone_qty',
        'total_qty',
      ],
    );
    final val = CombinedItemSalesRow(
      bundleQty: $checkedConvert('bundle_qty', (v) => (v as num).toInt()),
      itemId: $checkedConvert('item_id', (v) => v as String?),
      itemName: $checkedConvert('item_name', (v) => v as String),
      itemNameTranslations: $checkedConvert(
        'item_name_translations',
        (v) => v as Object,
      ),
      standaloneQty: $checkedConvert(
        'standalone_qty',
        (v) => (v as num).toInt(),
      ),
      totalQty: $checkedConvert('total_qty', (v) => (v as num).toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'bundleQty': 'bundle_qty',
    'itemId': 'item_id',
    'itemName': 'item_name',
    'itemNameTranslations': 'item_name_translations',
    'standaloneQty': 'standalone_qty',
    'totalQty': 'total_qty',
  },
);

Map<String, dynamic> _$CombinedItemSalesRowToJson(
  CombinedItemSalesRow instance,
) => <String, dynamic>{
  'bundle_qty': instance.bundleQty,
  'item_id': ?instance.itemId,
  'item_name': instance.itemName,
  'item_name_translations': instance.itemNameTranslations,
  'standalone_qty': instance.standaloneQty,
  'total_qty': instance.totalQty,
};
