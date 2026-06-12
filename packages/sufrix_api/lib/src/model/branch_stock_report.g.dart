// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_stock_report.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BranchStockReportCWProxy {
  BranchStockReport branchId(String branchId);

  BranchStockReport branchName(String branchName);

  BranchStockReport items(List<StockRow> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BranchStockReport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BranchStockReport(...).copyWith(id: 12, name: "My name")
  /// ````
  BranchStockReport call({
    String branchId,
    String branchName,
    List<StockRow> items,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBranchStockReport.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBranchStockReport.copyWith.fieldName(...)`
class _$BranchStockReportCWProxyImpl implements _$BranchStockReportCWProxy {
  const _$BranchStockReportCWProxyImpl(this._value);

  final BranchStockReport _value;

  @override
  BranchStockReport branchId(String branchId) => this(branchId: branchId);

  @override
  BranchStockReport branchName(String branchName) =>
      this(branchName: branchName);

  @override
  BranchStockReport items(List<StockRow> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BranchStockReport(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BranchStockReport(...).copyWith(id: 12, name: "My name")
  /// ````
  BranchStockReport call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? branchName = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
  }) {
    return BranchStockReport(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      branchName: branchName == const $CopyWithPlaceholder()
          ? _value.branchName
          // ignore: cast_nullable_to_non_nullable
          : branchName as String,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<StockRow>,
    );
  }
}

extension $BranchStockReportCopyWith on BranchStockReport {
  /// Returns a callable class that can be used as follows: `instanceOfBranchStockReport.copyWith(...)` or like so:`instanceOfBranchStockReport.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BranchStockReportCWProxy get copyWith =>
      _$BranchStockReportCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchStockReport _$BranchStockReportFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'BranchStockReport',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['branch_id', 'branch_name', 'items'],
        );
        final val = BranchStockReport(
          branchId: $checkedConvert('branch_id', (v) => v as String),
          branchName: $checkedConvert('branch_name', (v) => v as String),
          items: $checkedConvert(
            'items',
            (v) => (v as List<dynamic>)
                .map((e) => StockRow.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {'branchId': 'branch_id', 'branchName': 'branch_name'},
    );

Map<String, dynamic> _$BranchStockReportToJson(BranchStockReport instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };
