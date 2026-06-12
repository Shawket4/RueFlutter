// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_category.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PublicCategoryCWProxy {
  PublicCategory displayOrder(int displayOrder);

  PublicCategory id(String id);

  PublicCategory imageUrl(String? imageUrl);

  PublicCategory items(List<PublicMenuItem> items);

  PublicCategory name(String name);

  PublicCategory nameTranslations(Object nameTranslations);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PublicCategory(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PublicCategory(...).copyWith(id: 12, name: "My name")
  /// ````
  PublicCategory call({
    int displayOrder,
    String id,
    String? imageUrl,
    List<PublicMenuItem> items,
    String name,
    Object nameTranslations,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPublicCategory.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPublicCategory.copyWith.fieldName(...)`
class _$PublicCategoryCWProxyImpl implements _$PublicCategoryCWProxy {
  const _$PublicCategoryCWProxyImpl(this._value);

  final PublicCategory _value;

  @override
  PublicCategory displayOrder(int displayOrder) =>
      this(displayOrder: displayOrder);

  @override
  PublicCategory id(String id) => this(id: id);

  @override
  PublicCategory imageUrl(String? imageUrl) => this(imageUrl: imageUrl);

  @override
  PublicCategory items(List<PublicMenuItem> items) => this(items: items);

  @override
  PublicCategory name(String name) => this(name: name);

  @override
  PublicCategory nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PublicCategory(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PublicCategory(...).copyWith(id: 12, name: "My name")
  /// ````
  PublicCategory call({
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
    Object? items = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
  }) {
    return PublicCategory(
      displayOrder: displayOrder == const $CopyWithPlaceholder()
          ? _value.displayOrder
          // ignore: cast_nullable_to_non_nullable
          : displayOrder as int,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      imageUrl: imageUrl == const $CopyWithPlaceholder()
          ? _value.imageUrl
          // ignore: cast_nullable_to_non_nullable
          : imageUrl as String?,
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<PublicMenuItem>,
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

extension $PublicCategoryCopyWith on PublicCategory {
  /// Returns a callable class that can be used as follows: `instanceOfPublicCategory.copyWith(...)` or like so:`instanceOfPublicCategory.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PublicCategoryCWProxy get copyWith => _$PublicCategoryCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicCategory _$PublicCategoryFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PublicCategory',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'display_order',
            'id',
            'items',
            'name',
            'name_translations',
          ],
        );
        final val = PublicCategory(
          displayOrder: $checkedConvert(
            'display_order',
            (v) => (v as num).toInt(),
          ),
          id: $checkedConvert('id', (v) => v as String),
          imageUrl: $checkedConvert('image_url', (v) => v as String?),
          items: $checkedConvert(
            'items',
            (v) => (v as List<dynamic>)
                .map((e) => PublicMenuItem.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          name: $checkedConvert('name', (v) => v as String),
          nameTranslations: $checkedConvert(
            'name_translations',
            (v) => v as Object,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'displayOrder': 'display_order',
        'imageUrl': 'image_url',
        'nameTranslations': 'name_translations',
      },
    );

Map<String, dynamic> _$PublicCategoryToJson(PublicCategory instance) =>
    <String, dynamic>{
      'display_order': instance.displayOrder,
      'id': instance.id,
      'image_url': ?instance.imageUrl,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'name': instance.name,
      'name_translations': instance.nameTranslations,
    };
