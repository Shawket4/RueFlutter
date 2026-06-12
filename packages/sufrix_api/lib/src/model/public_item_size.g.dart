// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_item_size.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PublicItemSizeCWProxy {
  PublicItemSize id(String id);

  PublicItemSize label(String label);

  PublicItemSize priceOverride(int priceOverride);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PublicItemSize(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PublicItemSize(...).copyWith(id: 12, name: "My name")
  /// ````
  PublicItemSize call({String id, String label, int priceOverride});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPublicItemSize.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPublicItemSize.copyWith.fieldName(...)`
class _$PublicItemSizeCWProxyImpl implements _$PublicItemSizeCWProxy {
  const _$PublicItemSizeCWProxyImpl(this._value);

  final PublicItemSize _value;

  @override
  PublicItemSize id(String id) => this(id: id);

  @override
  PublicItemSize label(String label) => this(label: label);

  @override
  PublicItemSize priceOverride(int priceOverride) =>
      this(priceOverride: priceOverride);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PublicItemSize(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PublicItemSize(...).copyWith(id: 12, name: "My name")
  /// ````
  PublicItemSize call({
    Object? id = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? priceOverride = const $CopyWithPlaceholder(),
  }) {
    return PublicItemSize(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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

extension $PublicItemSizeCopyWith on PublicItemSize {
  /// Returns a callable class that can be used as follows: `instanceOfPublicItemSize.copyWith(...)` or like so:`instanceOfPublicItemSize.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PublicItemSizeCWProxy get copyWith => _$PublicItemSizeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicItemSize _$PublicItemSizeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PublicItemSize', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['id', 'label', 'price_override']);
      final val = PublicItemSize(
        id: $checkedConvert('id', (v) => v as String),
        label: $checkedConvert('label', (v) => v as String),
        priceOverride: $checkedConvert(
          'price_override',
          (v) => (v as num).toInt(),
        ),
      );
      return val;
    }, fieldKeyMap: const {'priceOverride': 'price_override'});

Map<String, dynamic> _$PublicItemSizeToJson(PublicItemSize instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'price_override': instance.priceOverride,
    };
