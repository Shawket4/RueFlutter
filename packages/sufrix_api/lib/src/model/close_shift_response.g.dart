// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'close_shift_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CloseShiftResponseCWProxy {
  CloseShiftResponse inventoryCounts(List<InventoryCountRow> inventoryCounts);

  CloseShiftResponse shift(Shift shift);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CloseShiftResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CloseShiftResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  CloseShiftResponse call({
    List<InventoryCountRow> inventoryCounts,
    Shift shift,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCloseShiftResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCloseShiftResponse.copyWith.fieldName(...)`
class _$CloseShiftResponseCWProxyImpl implements _$CloseShiftResponseCWProxy {
  const _$CloseShiftResponseCWProxyImpl(this._value);

  final CloseShiftResponse _value;

  @override
  CloseShiftResponse inventoryCounts(List<InventoryCountRow> inventoryCounts) =>
      this(inventoryCounts: inventoryCounts);

  @override
  CloseShiftResponse shift(Shift shift) => this(shift: shift);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CloseShiftResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CloseShiftResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  CloseShiftResponse call({
    Object? inventoryCounts = const $CopyWithPlaceholder(),
    Object? shift = const $CopyWithPlaceholder(),
  }) {
    return CloseShiftResponse(
      inventoryCounts: inventoryCounts == const $CopyWithPlaceholder()
          ? _value.inventoryCounts
          // ignore: cast_nullable_to_non_nullable
          : inventoryCounts as List<InventoryCountRow>,
      shift: shift == const $CopyWithPlaceholder()
          ? _value.shift
          // ignore: cast_nullable_to_non_nullable
          : shift as Shift,
    );
  }
}

extension $CloseShiftResponseCopyWith on CloseShiftResponse {
  /// Returns a callable class that can be used as follows: `instanceOfCloseShiftResponse.copyWith(...)` or like so:`instanceOfCloseShiftResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CloseShiftResponseCWProxy get copyWith =>
      _$CloseShiftResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloseShiftResponse _$CloseShiftResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CloseShiftResponse',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['inventory_counts', 'shift']);
        final val = CloseShiftResponse(
          inventoryCounts: $checkedConvert(
            'inventory_counts',
            (v) => (v as List<dynamic>)
                .map(
                  (e) => InventoryCountRow.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
          ),
          shift: $checkedConvert(
            'shift',
            (v) => Shift.fromJson(v as Map<String, dynamic>),
          ),
        );
        return val;
      },
      fieldKeyMap: const {'inventoryCounts': 'inventory_counts'},
    );

Map<String, dynamic> _$CloseShiftResponseToJson(
  CloseShiftResponse instance,
) => <String, dynamic>{
  'inventory_counts': instance.inventoryCounts.map((e) => e.toJson()).toList(),
  'shift': instance.shift.toJson(),
};
