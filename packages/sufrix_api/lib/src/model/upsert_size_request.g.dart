// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsert_size_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpsertSizeRequestCWProxy {
  UpsertSizeRequest displayOrder(int? displayOrder);

  UpsertSizeRequest label(String label);

  UpsertSizeRequest priceOverride(int priceOverride);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpsertSizeRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpsertSizeRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpsertSizeRequest call({int? displayOrder, String label, int priceOverride});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpsertSizeRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpsertSizeRequest.copyWith.fieldName(...)`
class _$UpsertSizeRequestCWProxyImpl implements _$UpsertSizeRequestCWProxy {
  const _$UpsertSizeRequestCWProxyImpl(this._value);

  final UpsertSizeRequest _value;

  @override
  UpsertSizeRequest displayOrder(int? displayOrder) =>
      this(displayOrder: displayOrder);

  @override
  UpsertSizeRequest label(String label) => this(label: label);

  @override
  UpsertSizeRequest priceOverride(int priceOverride) =>
      this(priceOverride: priceOverride);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpsertSizeRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpsertSizeRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpsertSizeRequest call({
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? priceOverride = const $CopyWithPlaceholder(),
  }) {
    return UpsertSizeRequest(
      displayOrder: displayOrder == const $CopyWithPlaceholder()
          ? _value.displayOrder
          // ignore: cast_nullable_to_non_nullable
          : displayOrder as int?,
      label: label == const $CopyWithPlaceholder()
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String,
      priceOverride: priceOverride == const $CopyWithPlaceholder()
          ? _value.priceOverride
          // ignore: cast_nullable_to_non_nullable
          : priceOverride as int,
    );
  }
}

extension $UpsertSizeRequestCopyWith on UpsertSizeRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpsertSizeRequest.copyWith(...)` or like so:`instanceOfUpsertSizeRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpsertSizeRequestCWProxy get copyWith =>
      _$UpsertSizeRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpsertSizeRequest _$UpsertSizeRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UpsertSizeRequest',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['label', 'price_override']);
        final val = UpsertSizeRequest(
          displayOrder: $checkedConvert(
            'display_order',
            (v) => (v as num?)?.toInt(),
          ),
          label: $checkedConvert('label', (v) => v as String),
          priceOverride: $checkedConvert(
            'price_override',
            (v) => (v as num).toInt(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'displayOrder': 'display_order',
        'priceOverride': 'price_override',
      },
    );

Map<String, dynamic> _$UpsertSizeRequestToJson(UpsertSizeRequest instance) =>
    <String, dynamic>{
      'display_order': ?instance.displayOrder,
      'label': instance.label,
      'price_override': instance.priceOverride,
    };
