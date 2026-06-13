// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waste_report_row.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WasteReportRowCWProxy {
  WasteReportRow ingredientName(String ingredientName);

  WasteReportRow orgIngredientId(String orgIngredientId);

  WasteReportRow reason(String reason);

  WasteReportRow unit(String unit);

  WasteReportRow wasteQty(double wasteQty);

  WasteReportRow wasteValue(int? wasteValue);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WasteReportRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WasteReportRow(...).copyWith(id: 12, name: "My name")
  /// ````
  WasteReportRow call({
    String ingredientName,
    String orgIngredientId,
    String reason,
    String unit,
    double wasteQty,
    int? wasteValue,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWasteReportRow.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWasteReportRow.copyWith.fieldName(...)`
class _$WasteReportRowCWProxyImpl implements _$WasteReportRowCWProxy {
  const _$WasteReportRowCWProxyImpl(this._value);

  final WasteReportRow _value;

  @override
  WasteReportRow ingredientName(String ingredientName) =>
      this(ingredientName: ingredientName);

  @override
  WasteReportRow orgIngredientId(String orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  WasteReportRow reason(String reason) => this(reason: reason);

  @override
  WasteReportRow unit(String unit) => this(unit: unit);

  @override
  WasteReportRow wasteQty(double wasteQty) => this(wasteQty: wasteQty);

  @override
  WasteReportRow wasteValue(int? wasteValue) => this(wasteValue: wasteValue);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WasteReportRow(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WasteReportRow(...).copyWith(id: 12, name: "My name")
  /// ````
  WasteReportRow call({
    Object? ingredientName = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
    Object? unit = const $CopyWithPlaceholder(),
    Object? wasteQty = const $CopyWithPlaceholder(),
    Object? wasteValue = const $CopyWithPlaceholder(),
  }) {
    return WasteReportRow(
      ingredientName: ingredientName == const $CopyWithPlaceholder()
          ? _value.ingredientName
          // ignore: cast_nullable_to_non_nullable
          : ingredientName as String,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
      unit: unit == const $CopyWithPlaceholder()
          ? _value.unit
          // ignore: cast_nullable_to_non_nullable
          : unit as String,
      wasteQty: wasteQty == const $CopyWithPlaceholder()
          ? _value.wasteQty
          // ignore: cast_nullable_to_non_nullable
          : wasteQty as double,
      wasteValue: wasteValue == const $CopyWithPlaceholder()
          ? _value.wasteValue
          // ignore: cast_nullable_to_non_nullable
          : wasteValue as int?,
    );
  }
}

extension $WasteReportRowCopyWith on WasteReportRow {
  /// Returns a callable class that can be used as follows: `instanceOfWasteReportRow.copyWith(...)` or like so:`instanceOfWasteReportRow.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WasteReportRowCWProxy get copyWith => _$WasteReportRowCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WasteReportRow _$WasteReportRowFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'WasteReportRow',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'ingredient_name',
        'org_ingredient_id',
        'reason',
        'unit',
        'waste_qty',
      ],
    );
    final val = WasteReportRow(
      ingredientName: $checkedConvert('ingredient_name', (v) => v as String),
      orgIngredientId: $checkedConvert('org_ingredient_id', (v) => v as String),
      reason: $checkedConvert('reason', (v) => v as String),
      unit: $checkedConvert('unit', (v) => v as String),
      wasteQty: $checkedConvert('waste_qty', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
      wasteValue: $checkedConvert('waste_value', (v) => (v as num?)?.toInt()),
    );
    return val;
  },
  fieldKeyMap: const {
    'ingredientName': 'ingredient_name',
    'orgIngredientId': 'org_ingredient_id',
    'wasteQty': 'waste_qty',
    'wasteValue': 'waste_value',
  },
);

Map<String, dynamic> _$WasteReportRowToJson(WasteReportRow instance) =>
    <String, dynamic>{
      'ingredient_name': instance.ingredientName,
      'org_ingredient_id': instance.orgIngredientId,
      'reason': instance.reason,
      'unit': instance.unit,
      'waste_qty': instance.wasteQty,
      'waste_value': ?instance.wasteValue,
    };
