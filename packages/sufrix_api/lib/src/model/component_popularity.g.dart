// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component_popularity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ComponentPopularityCWProxy {
  ComponentPopularity itemId(String itemId);

  ComponentPopularity itemName(String itemName);

  ComponentPopularity quantitySold(int quantitySold);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ComponentPopularity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ComponentPopularity(...).copyWith(id: 12, name: "My name")
  /// ````
  ComponentPopularity call({String itemId, String itemName, int quantitySold});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfComponentPopularity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfComponentPopularity.copyWith.fieldName(...)`
class _$ComponentPopularityCWProxyImpl implements _$ComponentPopularityCWProxy {
  const _$ComponentPopularityCWProxyImpl(this._value);

  final ComponentPopularity _value;

  @override
  ComponentPopularity itemId(String itemId) => this(itemId: itemId);

  @override
  ComponentPopularity itemName(String itemName) => this(itemName: itemName);

  @override
  ComponentPopularity quantitySold(int quantitySold) =>
      this(quantitySold: quantitySold);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ComponentPopularity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ComponentPopularity(...).copyWith(id: 12, name: "My name")
  /// ````
  ComponentPopularity call({
    Object? itemId = const $CopyWithPlaceholder(),
    Object? itemName = const $CopyWithPlaceholder(),
    Object? quantitySold = const $CopyWithPlaceholder(),
  }) {
    return ComponentPopularity(
      itemId: itemId == const $CopyWithPlaceholder()
          ? _value.itemId
          // ignore: cast_nullable_to_non_nullable
          : itemId as String,
      itemName: itemName == const $CopyWithPlaceholder()
          ? _value.itemName
          // ignore: cast_nullable_to_non_nullable
          : itemName as String,
      quantitySold: quantitySold == const $CopyWithPlaceholder()
          ? _value.quantitySold
          // ignore: cast_nullable_to_non_nullable
          : quantitySold as int,
    );
  }
}

extension $ComponentPopularityCopyWith on ComponentPopularity {
  /// Returns a callable class that can be used as follows: `instanceOfComponentPopularity.copyWith(...)` or like so:`instanceOfComponentPopularity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ComponentPopularityCWProxy get copyWith =>
      _$ComponentPopularityCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComponentPopularity _$ComponentPopularityFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ComponentPopularity',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['item_id', 'item_name', 'quantity_sold'],
        );
        final val = ComponentPopularity(
          itemId: $checkedConvert('item_id', (v) => v as String),
          itemName: $checkedConvert('item_name', (v) => v as String),
          quantitySold: $checkedConvert(
            'quantity_sold',
            (v) => (v as num).toInt(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'itemId': 'item_id',
        'itemName': 'item_name',
        'quantitySold': 'quantity_sold',
      },
    );

Map<String, dynamic> _$ComponentPopularityToJson(
  ComponentPopularity instance,
) => <String, dynamic>{
  'item_id': instance.itemId,
  'item_name': instance.itemName,
  'quantity_sold': instance.quantitySold,
};
