// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_stock_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddToStockRequestCWProxy {
  AddToStockRequest currentStock(double? currentStock);

  AddToStockRequest orgIngredientId(String orgIngredientId);

  AddToStockRequest reorderThreshold(double? reorderThreshold);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddToStockRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddToStockRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AddToStockRequest call({
    double? currentStock,
    String orgIngredientId,
    double? reorderThreshold,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAddToStockRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAddToStockRequest.copyWith.fieldName(...)`
class _$AddToStockRequestCWProxyImpl implements _$AddToStockRequestCWProxy {
  const _$AddToStockRequestCWProxyImpl(this._value);

  final AddToStockRequest _value;

  @override
  AddToStockRequest currentStock(double? currentStock) =>
      this(currentStock: currentStock);

  @override
  AddToStockRequest orgIngredientId(String orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  AddToStockRequest reorderThreshold(double? reorderThreshold) =>
      this(reorderThreshold: reorderThreshold);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddToStockRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddToStockRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AddToStockRequest call({
    Object? currentStock = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? reorderThreshold = const $CopyWithPlaceholder(),
  }) {
    return AddToStockRequest(
      currentStock: currentStock == const $CopyWithPlaceholder()
          ? _value.currentStock
          // ignore: cast_nullable_to_non_nullable
          : currentStock as double?,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String,
      reorderThreshold: reorderThreshold == const $CopyWithPlaceholder()
          ? _value.reorderThreshold
          // ignore: cast_nullable_to_non_nullable
          : reorderThreshold as double?,
    );
  }
}

extension $AddToStockRequestCopyWith on AddToStockRequest {
  /// Returns a callable class that can be used as follows: `instanceOfAddToStockRequest.copyWith(...)` or like so:`instanceOfAddToStockRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddToStockRequestCWProxy get copyWith =>
      _$AddToStockRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToStockRequest _$AddToStockRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AddToStockRequest',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['org_ingredient_id']);
        final val = AddToStockRequest(
          currentStock: $checkedConvert(
            'current_stock',
            (v) => (v is String ? double.parse(v) : (v as num?)?.toDouble()),
          ),
          orgIngredientId: $checkedConvert(
            'org_ingredient_id',
            (v) => v as String,
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
        'orgIngredientId': 'org_ingredient_id',
        'reorderThreshold': 'reorder_threshold',
      },
    );

Map<String, dynamic> _$AddToStockRequestToJson(AddToStockRequest instance) =>
    <String, dynamic>{
      'current_stock': ?instance.currentStock,
      'org_ingredient_id': instance.orgIngredientId,
      'reorder_threshold': ?instance.reorderThreshold,
    };
