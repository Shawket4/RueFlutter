// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addon_slot.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddonSlotCWProxy {
  AddonSlot addonType(String addonType);

  AddonSlot createdAt(DateTime createdAt);

  AddonSlot displayOrder(int displayOrder);

  AddonSlot id(String id);

  AddonSlot isRequired(bool isRequired);

  AddonSlot label(String? label);

  AddonSlot labelTranslations(Object labelTranslations);

  AddonSlot maxSelections(int? maxSelections);

  AddonSlot menuItemId(String menuItemId);

  AddonSlot minSelections(int minSelections);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddonSlot(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddonSlot(...).copyWith(id: 12, name: "My name")
  /// ````
  AddonSlot call({
    String addonType,
    DateTime createdAt,
    int displayOrder,
    String id,
    bool isRequired,
    String? label,
    Object labelTranslations,
    int? maxSelections,
    String menuItemId,
    int minSelections,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAddonSlot.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAddonSlot.copyWith.fieldName(...)`
class _$AddonSlotCWProxyImpl implements _$AddonSlotCWProxy {
  const _$AddonSlotCWProxyImpl(this._value);

  final AddonSlot _value;

  @override
  AddonSlot addonType(String addonType) => this(addonType: addonType);

  @override
  AddonSlot createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  AddonSlot displayOrder(int displayOrder) => this(displayOrder: displayOrder);

  @override
  AddonSlot id(String id) => this(id: id);

  @override
  AddonSlot isRequired(bool isRequired) => this(isRequired: isRequired);

  @override
  AddonSlot label(String? label) => this(label: label);

  @override
  AddonSlot labelTranslations(Object labelTranslations) =>
      this(labelTranslations: labelTranslations);

  @override
  AddonSlot maxSelections(int? maxSelections) =>
      this(maxSelections: maxSelections);

  @override
  AddonSlot menuItemId(String menuItemId) => this(menuItemId: menuItemId);

  @override
  AddonSlot minSelections(int minSelections) =>
      this(minSelections: minSelections);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddonSlot(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddonSlot(...).copyWith(id: 12, name: "My name")
  /// ````
  AddonSlot call({
    Object? addonType = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isRequired = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? labelTranslations = const $CopyWithPlaceholder(),
    Object? maxSelections = const $CopyWithPlaceholder(),
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? minSelections = const $CopyWithPlaceholder(),
  }) {
    return AddonSlot(
      addonType: addonType == const $CopyWithPlaceholder()
          ? _value.addonType
          // ignore: cast_nullable_to_non_nullable
          : addonType as String,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      displayOrder: displayOrder == const $CopyWithPlaceholder()
          ? _value.displayOrder
          // ignore: cast_nullable_to_non_nullable
          : displayOrder as int,
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
      menuItemId: menuItemId == const $CopyWithPlaceholder()
          ? _value.menuItemId
          // ignore: cast_nullable_to_non_nullable
          : menuItemId as String,
      minSelections: minSelections == const $CopyWithPlaceholder()
          ? _value.minSelections
          // ignore: cast_nullable_to_non_nullable
          : minSelections as int,
    );
  }
}

extension $AddonSlotCopyWith on AddonSlot {
  /// Returns a callable class that can be used as follows: `instanceOfAddonSlot.copyWith(...)` or like so:`instanceOfAddonSlot.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddonSlotCWProxy get copyWith => _$AddonSlotCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddonSlot _$AddonSlotFromJson(Map<String, dynamic> json) => $checkedCreate(
  'AddonSlot',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'addon_type',
        'created_at',
        'display_order',
        'id',
        'is_required',
        'label_translations',
        'menu_item_id',
        'min_selections',
      ],
    );
    final val = AddonSlot(
      addonType: $checkedConvert('addon_type', (v) => v as String),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      displayOrder: $checkedConvert('display_order', (v) => (v as num).toInt()),
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
      menuItemId: $checkedConvert('menu_item_id', (v) => v as String),
      minSelections: $checkedConvert(
        'min_selections',
        (v) => (v as num).toInt(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'addonType': 'addon_type',
    'createdAt': 'created_at',
    'displayOrder': 'display_order',
    'isRequired': 'is_required',
    'labelTranslations': 'label_translations',
    'maxSelections': 'max_selections',
    'menuItemId': 'menu_item_id',
    'minSelections': 'min_selections',
  },
);

Map<String, dynamic> _$AddonSlotToJson(AddonSlot instance) => <String, dynamic>{
  'addon_type': instance.addonType,
  'created_at': instance.createdAt.toIso8601String(),
  'display_order': instance.displayOrder,
  'id': instance.id,
  'is_required': instance.isRequired,
  'label': ?instance.label,
  'label_translations': instance.labelTranslations,
  'max_selections': ?instance.maxSelections,
  'menu_item_id': instance.menuItemId,
  'min_selections': instance.minSelections,
};
