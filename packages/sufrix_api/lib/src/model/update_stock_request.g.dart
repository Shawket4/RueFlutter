// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_stock_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateStockRequestCWProxy {
  UpdateStockRequest currentStock(double? currentStock);

  UpdateStockRequest reorderThreshold(double? reorderThreshold);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateStockRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateStockRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateStockRequest call({double? currentStock, double? reorderThreshold});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateStockRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateStockRequest.copyWith.fieldName(...)`
class _$UpdateStockRequestCWProxyImpl implements _$UpdateStockRequestCWProxy {
  const _$UpdateStockRequestCWProxyImpl(this._value);

  final UpdateStockRequest _value;

  @override
  UpdateStockRequest currentStock(double? currentStock) =>
      this(currentStock: currentStock);

  @override
  UpdateStockRequest reorderThreshold(double? reorderThreshold) =>
      this(reorderThreshold: reorderThreshold);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateStockRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateStockRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateStockRequest call({
    Object? currentStock = const $CopyWithPlaceholder(),
    Object? reorderThreshold = const $CopyWithPlaceholder(),
  }) {
    return UpdateStockRequest(
      currentStock: currentStock == const $CopyWithPlaceholder()
          ? _value.currentStock
          // ignore: cast_nullable_to_non_nullable
          : currentStock as double?,
      reorderThreshold: reorderThreshold == const $CopyWithPlaceholder()
          ? _value.reorderThreshold
          // ignore: cast_nullable_to_non_nullable
          : reorderThreshold as double?,
    );
  }
}

extension $UpdateStockRequestCopyWith on UpdateStockRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateStockRequest.copyWith(...)` or like so:`instanceOfUpdateStockRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateStockRequestCWProxy get copyWith =>
      _$UpdateStockRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateStockRequest _$UpdateStockRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UpdateStockRequest',
      json,
      ($checkedConvert) {
        final val = UpdateStockRequest(
          currentStock: $checkedConvert(
            'current_stock',
            (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
          ),
          reorderThreshold: $checkedConvert(
            'reorder_threshold',
            (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'currentStock': 'current_stock',
        'reorderThreshold': 'reorder_threshold',
      },
    );

Map<String, dynamic> _$UpdateStockRequestToJson(UpdateStockRequest instance) =>
    <String, dynamic>{
      'current_stock': ?instance.currentStock,
      'reorder_threshold': ?instance.reorderThreshold,
    };
