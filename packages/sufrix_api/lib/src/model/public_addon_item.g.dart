// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_addon_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PublicAddonItemCWProxy {
  PublicAddonItem defaultPrice(int defaultPrice);

  PublicAddonItem id(String id);

  PublicAddonItem name(String name);

  PublicAddonItem nameTranslations(Object nameTranslations);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PublicAddonItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PublicAddonItem(...).copyWith(id: 12, name: "My name")
  /// ````
  PublicAddonItem call({
    int defaultPrice,
    String id,
    String name,
    Object nameTranslations,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPublicAddonItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPublicAddonItem.copyWith.fieldName(...)`
class _$PublicAddonItemCWProxyImpl implements _$PublicAddonItemCWProxy {
  const _$PublicAddonItemCWProxyImpl(this._value);

  final PublicAddonItem _value;

  @override
  PublicAddonItem defaultPrice(int defaultPrice) =>
      this(defaultPrice: defaultPrice);

  @override
  PublicAddonItem id(String id) => this(id: id);

  @override
  PublicAddonItem name(String name) => this(name: name);

  @override
  PublicAddonItem nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PublicAddonItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PublicAddonItem(...).copyWith(id: 12, name: "My name")
  /// ````
  PublicAddonItem call({
    Object? defaultPrice = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
  }) {
    return PublicAddonItem(
      defaultPrice: defaultPrice == const $CopyWithPlaceholder()
          ? _value.defaultPrice
          // ignore: cast_nullable_to_non_nullable
          : defaultPrice as int,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      nameTranslations: nameTranslations == const $CopyWithPlaceholder()
          ? _value.nameTranslations
          // ignore: cast_nullable_to_non_nullable
          : nameTranslations as Object,
    );
  }
}

extension $PublicAddonItemCopyWith on PublicAddonItem {
  /// Returns a callable class that can be used as follows: `instanceOfPublicAddonItem.copyWith(...)` or like so:`instanceOfPublicAddonItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PublicAddonItemCWProxy get copyWith => _$PublicAddonItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicAddonItem _$PublicAddonItemFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'PublicAddonItem',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['default_price', 'id', 'name', 'name_translations'],
    );
    final val = PublicAddonItem(
      defaultPrice: $checkedConvert('default_price', (v) => (v as num).toInt()),
      id: $checkedConvert('id', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      nameTranslations: $checkedConvert(
        'name_translations',
        (v) => v as Object,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'defaultPrice': 'default_price',
    'nameTranslations': 'name_translations',
  },
);

Map<String, dynamic> _$PublicAddonItemToJson(PublicAddonItem instance) =>
    <String, dynamic>{
      'default_price': instance.defaultPrice,
      'id': instance.id,
      'name': instance.name,
      'name_translations': instance.nameTranslations,
    };
