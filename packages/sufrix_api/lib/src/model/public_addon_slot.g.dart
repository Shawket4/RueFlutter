// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_addon_slot.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PublicAddonSlotCWProxy {
  PublicAddonSlot addonItems(List<PublicAddonItem> addonItems);

  PublicAddonSlot addonType(String addonType);

  PublicAddonSlot id(String id);

  PublicAddonSlot isRequired(bool isRequired);

  PublicAddonSlot label(String? label);

  PublicAddonSlot labelTranslations(Object labelTranslations);

  PublicAddonSlot maxSelections(int? maxSelections);

  PublicAddonSlot minSelections(int minSelections);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PublicAddonSlot(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PublicAddonSlot(...).copyWith(id: 12, name: "My name")
  /// ````
  PublicAddonSlot call({
    List<PublicAddonItem> addonItems,
    String addonType,
    String id,
    bool isRequired,
    String? label,
    Object labelTranslations,
    int? maxSelections,
    int minSelections,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPublicAddonSlot.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPublicAddonSlot.copyWith.fieldName(...)`
class _$PublicAddonSlotCWProxyImpl implements _$PublicAddonSlotCWProxy {
  const _$PublicAddonSlotCWProxyImpl(this._value);

  final PublicAddonSlot _value;

  @override
  PublicAddonSlot addonItems(List<PublicAddonItem> addonItems) =>
      this(addonItems: addonItems);

  @override
  PublicAddonSlot addonType(String addonType) => this(addonType: addonType);

  @override
  PublicAddonSlot id(String id) => this(id: id);

  @override
  PublicAddonSlot isRequired(bool isRequired) => this(isRequired: isRequired);

  @override
  PublicAddonSlot label(String? label) => this(label: label);

  @override
  PublicAddonSlot labelTranslations(Object labelTranslations) =>
      this(labelTranslations: labelTranslations);

  @override
  PublicAddonSlot maxSelections(int? maxSelections) =>
      this(maxSelections: maxSelections);

  @override
  PublicAddonSlot minSelections(int minSelections) =>
      this(minSelections: minSelections);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PublicAddonSlot(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PublicAddonSlot(...).copyWith(id: 12, name: "My name")
  /// ````
  PublicAddonSlot call({
    Object? addonItems = const $CopyWithPlaceholder(),
    Object? addonType = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isRequired = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? labelTranslations = const $CopyWithPlaceholder(),
    Object? maxSelections = const $CopyWithPlaceholder(),
    Object? minSelections = const $CopyWithPlaceholder(),
  }) {
    return PublicAddonSlot(
      addonItems: addonItems == const $CopyWithPlaceholder()
          ? _value.addonItems
          // ignore: cast_nullable_to_non_nullable
          : addonItems as List<PublicAddonItem>,
      addonType: addonType == const $CopyWithPlaceholder()
          ? _value.addonType
          // ignore: cast_nullable_to_non_nullable
          : addonType as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      isRequired: isRequired == const $CopyWithPlaceholder()
          ? _value.isRequired
          // ignore: cast_nullable_to_non_nullable
          : isRequired as bool,
      label: label == const $CopyWithPlaceholder()
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String?,
      labelTranslations: labelTranslations == const $CopyWithPlaceholder()
          ? _value.labelTranslations
          // ignore: cast_nullable_to_non_nullable
          : labelTranslations as Object,
      maxSelections: maxSelections == const $CopyWithPlaceholder()
          ? _value.maxSelections
          // ignore: cast_nullable_to_non_nullable
          : maxSelections as int?,
      minSelections: minSelections == const $CopyWithPlaceholder()
          ? _value.minSelections
          // ignore: cast_nullable_to_non_nullable
          : minSelections as int,
    );
  }
}

extension $PublicAddonSlotCopyWith on PublicAddonSlot {
  /// Returns a callable class that can be used as follows: `instanceOfPublicAddonSlot.copyWith(...)` or like so:`instanceOfPublicAddonSlot.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PublicAddonSlotCWProxy get copyWith => _$PublicAddonSlotCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicAddonSlot _$PublicAddonSlotFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PublicAddonSlot',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'addon_items',
            'addon_type',
            'id',
            'is_required',
            'label_translations',
            'min_selections',
          ],
        );
        final val = PublicAddonSlot(
          addonItems: $checkedConvert(
            'addon_items',
            (v) => (v as List<dynamic>)
                .map((e) => PublicAddonItem.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          addonType: $checkedConvert('addon_type', (v) => v as String),
          id: $checkedConvert('id', (v) => v as String),
          isRequired: $checkedConvert('is_required', (v) => v as bool),
          label: $checkedConvert('label', (v) => v as String?),
          labelTranslations: $checkedConvert(
            'label_translations',
            (v) => v as Object,
          ),
          maxSelections: $checkedConvert(
            'max_selections',
            (v) => (v as num?)?.toInt(),
          ),
          minSelections: $checkedConvert(
            'min_selections',
            (v) => (v as num).toInt(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'addonItems': 'addon_items',
        'addonType': 'addon_type',
        'isRequired': 'is_required',
        'labelTranslations': 'label_translations',
        'maxSelections': 'max_selections',
        'minSelections': 'min_selections',
      },
    );

Map<String, dynamic> _$PublicAddonSlotToJson(PublicAddonSlot instance) =>
    <String, dynamic>{
      'addon_items': instance.addonItems.map((e) => e.toJson()).toList(),
      'addon_type': instance.addonType,
      'id': instance.id,
      'is_required': instance.isRequired,
      'label': ?instance.label,
      'label_translations': instance.labelTranslations,
      'max_selections': ?instance.maxSelections,
      'min_selections': instance.minSelections,
    };
