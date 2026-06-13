// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsert_items_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpsertItemsRequestCWProxy {
  UpsertItemsRequest items(List<ItemCountInput> items);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpsertItemsRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpsertItemsRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpsertItemsRequest call({List<ItemCountInput> items});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpsertItemsRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpsertItemsRequest.copyWith.fieldName(...)`
class _$UpsertItemsRequestCWProxyImpl implements _$UpsertItemsRequestCWProxy {
  const _$UpsertItemsRequestCWProxyImpl(this._value);

  final UpsertItemsRequest _value;

  @override
  UpsertItemsRequest items(List<ItemCountInput> items) => this(items: items);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpsertItemsRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpsertItemsRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpsertItemsRequest call({Object? items = const $CopyWithPlaceholder()}) {
    return UpsertItemsRequest(
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<ItemCountInput>,
    );
  }
}

extension $UpsertItemsRequestCopyWith on UpsertItemsRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpsertItemsRequest.copyWith(...)` or like so:`instanceOfUpsertItemsRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpsertItemsRequestCWProxy get copyWith =>
      _$UpsertItemsRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpsertItemsRequest _$UpsertItemsRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpsertItemsRequest', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['items']);
      final val = UpsertItemsRequest(
        items: $checkedConvert(
          'items',
          (v) => (v as List<dynamic>)
              .map((e) => ItemCountInput.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$UpsertItemsRequestToJson(UpsertItemsRequest instance) =>
    <String, dynamic>{'items': instance.items.map((e) => e.toJson()).toList()};
