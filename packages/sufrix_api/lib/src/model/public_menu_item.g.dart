// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_menu_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PublicMenuItemCWProxy {
  PublicMenuItem addonSlots(List<PublicAddonSlot> addonSlots);

  PublicMenuItem basePrice(int basePrice);

  PublicMenuItem description(String? description);

  PublicMenuItem descriptionTranslations(Object descriptionTranslations);

  PublicMenuItem displayOrder(int displayOrder);

  PublicMenuItem id(String id);

  PublicMenuItem imageUrl(String? imageUrl);

  PublicMenuItem name(String name);

  PublicMenuItem nameTranslations(Object nameTranslations);

  PublicMenuItem sizes(List<PublicItemSize> sizes);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PublicMenuItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PublicMenuItem(...).copyWith(id: 12, name: "My name")
  /// ````
  PublicMenuItem call({
    List<PublicAddonSlot> addonSlots,
    int basePrice,
    String? description,
    Object descriptionTranslations,
    int displayOrder,
    String id,
    String? imageUrl,
    String name,
    Object nameTranslations,
    List<PublicItemSize> sizes,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPublicMenuItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPublicMenuItem.copyWith.fieldName(...)`
class _$PublicMenuItemCWProxyImpl implements _$PublicMenuItemCWProxy {
  const _$PublicMenuItemCWProxyImpl(this._value);

  final PublicMenuItem _value;

  @override
  PublicMenuItem addonSlots(List<PublicAddonSlot> addonSlots) =>
      this(addonSlots: addonSlots);

  @override
  PublicMenuItem basePrice(int basePrice) => this(basePrice: basePrice);

  @override
  PublicMenuItem description(String? description) =>
      this(description: description);

  @override
  PublicMenuItem descriptionTranslations(Object descriptionTranslations) =>
      this(descriptionTranslations: descriptionTranslations);

  @override
  PublicMenuItem displayOrder(int displayOrder) =>
      this(displayOrder: displayOrder);

  @override
  PublicMenuItem id(String id) => this(id: id);

  @override
  PublicMenuItem imageUrl(String? imageUrl) => this(imageUrl: imageUrl);

  @override
  PublicMenuItem name(String name) => this(name: name);

  @override
  PublicMenuItem nameTranslations(Object nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  PublicMenuItem sizes(List<PublicItemSize> sizes) => this(sizes: sizes);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PublicMenuItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PublicMenuItem(...).copyWith(id: 12, name: "My name")
  /// ````
  PublicMenuItem call({
    Object? addonSlots = const $CopyWithPlaceholder(),
    Object? basePrice = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? descriptionTranslations = const $CopyWithPlaceholder(),
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? sizes = const $CopyWithPlaceholder(),
  }) {
    return PublicMenuItem(
      addonSlots: addonSlots == const $CopyWithPlaceholder()
          ? _value.addonSlots
          // ignore: cast_nullable_to_non_nullable
          : addonSlots as List<PublicAddonSlot>,
      basePrice: basePrice == const $CopyWithPlaceholder()
          ? _value.basePrice
          // ignore: cast_nullable_to_non_nullable
          : basePrice as int,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      descriptionTranslations:
          descriptionTranslations == const $CopyWithPlaceholder()
          ? _value.descriptionTranslations
          // ignore: cast_nullable_to_non_nullable
          : descriptionTranslations as Object,
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
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      nameTranslations: nameTranslations == const $CopyWithPlaceholder()
          ? _value.nameTranslations
          // ignore: cast_nullable_to_non_nullable
          : nameTranslations as Object,
      sizes: sizes == const $CopyWithPlaceholder()
          ? _value.sizes
          // ignore: cast_nullable_to_non_nullable
          : sizes as List<PublicItemSize>,
    );
  }
}

extension $PublicMenuItemCopyWith on PublicMenuItem {
  /// Returns a callable class that can be used as follows: `instanceOfPublicMenuItem.copyWith(...)` or like so:`instanceOfPublicMenuItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PublicMenuItemCWProxy get copyWith => _$PublicMenuItemCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicMenuItem _$PublicMenuItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PublicMenuItem',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'addon_slots',
            'base_price',
            'description_translations',
            'display_order',
            'id',
            'name',
            'name_translations',
            'sizes',
          ],
        );
        final val = PublicMenuItem(
          addonSlots: $checkedConvert(
            'addon_slots',
            (v) => (v as List<dynamic>)
                .map((e) => PublicAddonSlot.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          basePrice: $checkedConvert('base_price', (v) => (v as num).toInt()),
          description: $checkedConvert('description', (v) => v as String?),
          descriptionTranslations: $checkedConvert(
            'description_translations',
            (v) => v as Object,
          ),
          displayOrder: $checkedConvert(
            'display_order',
            (v) => (v as num).toInt(),
          ),
          id: $checkedConvert('id', (v) => v as String),
          imageUrl: $checkedConvert('image_url', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String),
          nameTranslations: $checkedConvert(
            'name_translations',
            (v) => v as Object,
          ),
          sizes: $checkedConvert(
            'sizes',
            (v) => (v as List<dynamic>)
                .map((e) => PublicItemSize.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'addonSlots': 'addon_slots',
        'basePrice': 'base_price',
        'descriptionTranslations': 'description_translations',
        'displayOrder': 'display_order',
        'imageUrl': 'image_url',
        'nameTranslations': 'name_translations',
      },
    );

Map<String, dynamic> _$PublicMenuItemToJson(PublicMenuItem instance) =>
    <String, dynamic>{
      'addon_slots': instance.addonSlots.map((e) => e.toJson()).toList(),
      'base_price': instance.basePrice,
      'description': ?instance.description,
      'description_translations': instance.descriptionTranslations,
      'display_order': instance.displayOrder,
      'id': instance.id,
      'image_url': ?instance.imageUrl,
      'name': instance.name,
      'name_translations': instance.nameTranslations,
      'sizes': instance.sizes.map((e) => e.toJson()).toList(),
    };
