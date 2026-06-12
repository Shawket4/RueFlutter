// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_addon_slot_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateAddonSlotRequestCWProxy {
  UpdateAddonSlotRequest displayOrder(int? displayOrder);

  UpdateAddonSlotRequest isRequired(bool? isRequired);

  UpdateAddonSlotRequest label(String? label);

  UpdateAddonSlotRequest labelTranslations(Object? labelTranslations);

  UpdateAddonSlotRequest maxSelections(int? maxSelections);

  UpdateAddonSlotRequest minSelections(int? minSelections);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateAddonSlotRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateAddonSlotRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateAddonSlotRequest call({
    int? displayOrder,
    bool? isRequired,
    String? label,
    Object? labelTranslations,
    int? maxSelections,
    int? minSelections,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateAddonSlotRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateAddonSlotRequest.copyWith.fieldName(...)`
class _$UpdateAddonSlotRequestCWProxyImpl
    implements _$UpdateAddonSlotRequestCWProxy {
  const _$UpdateAddonSlotRequestCWProxyImpl(this._value);

  final UpdateAddonSlotRequest _value;

  @override
  UpdateAddonSlotRequest displayOrder(int? displayOrder) =>
      this(displayOrder: displayOrder);

  @override
  UpdateAddonSlotRequest isRequired(bool? isRequired) =>
      this(isRequired: isRequired);

  @override
  UpdateAddonSlotRequest label(String? label) => this(label: label);

  @override
  UpdateAddonSlotRequest labelTranslations(Object? labelTranslations) =>
      this(labelTranslations: labelTranslations);

  @override
  UpdateAddonSlotRequest maxSelections(int? maxSelections) =>
      this(maxSelections: maxSelections);

  @override
  UpdateAddonSlotRequest minSelections(int? minSelections) =>
      this(minSelections: minSelections);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateAddonSlotRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateAddonSlotRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateAddonSlotRequest call({
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? isRequired = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? labelTranslations = const $CopyWithPlaceholder(),
    Object? maxSelections = const $CopyWithPlaceholder(),
    Object? minSelections = const $CopyWithPlaceholder(),
  }) {
    return UpdateAddonSlotRequest(
      displayOrder: displayOrder == const $CopyWithPlaceholder()
          ? _value.displayOrder
          // ignore: cast_nullable_to_non_nullable
          : displayOrder as int?,
      isRequired: isRequired == const $CopyWithPlaceholder()
          ? _value.isRequired
          // ignore: cast_nullable_to_non_nullable
          : isRequired as bool?,
      label: label == const $CopyWithPlaceholder()
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String?,
      labelTranslations: labelTranslations == const $CopyWithPlaceholder()
          ? _value.labelTranslations
          // ignore: cast_nullable_to_non_nullable
          : labelTranslations as Object?,
      maxSelections: maxSelections == const $CopyWithPlaceholder()
          ? _value.maxSelections
          // ignore: cast_nullable_to_non_nullable
          : maxSelections as int?,
      minSelections: minSelections == const $CopyWithPlaceholder()
          ? _value.minSelections
          // ignore: cast_nullable_to_non_nullable
          : minSelections as int?,
    );
  }
}

extension $UpdateAddonSlotRequestCopyWith on UpdateAddonSlotRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateAddonSlotRequest.copyWith(...)` or like so:`instanceOfUpdateAddonSlotRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateAddonSlotRequestCWProxy get copyWith =>
      _$UpdateAddonSlotRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAddonSlotRequest _$UpdateAddonSlotRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'UpdateAddonSlotRequest',
  json,
  ($checkedConvert) {
    final val = UpdateAddonSlotRequest(
      displayOrder: $checkedConvert(
        'display_order',
        (v) => (v as num?)?.toInt(),
      ),
      isRequired: $checkedConvert('is_required', (v) => v as bool?),
      label: $checkedConvert('label', (v) => v as String?),
      labelTranslations: $checkedConvert('label_translations', (v) => v),
      maxSelections: $checkedConvert(
        'max_selections',
        (v) => (v as num?)?.toInt(),
      ),
      minSelections: $checkedConvert(
        'min_selections',
        (v) => (v as num?)?.toInt(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'displayOrder': 'display_order',
    'isRequired': 'is_required',
    'labelTranslations': 'label_translations',
    'maxSelections': 'max_selections',
    'minSelections': 'min_selections',
  },
);

Map<String, dynamic> _$UpdateAddonSlotRequestToJson(
  UpdateAddonSlotRequest instance,
) => <String, dynamic>{
  'display_order': ?instance.displayOrder,
  'is_required': ?instance.isRequired,
  'label': ?instance.label,
  'label_translations': ?instance.labelTranslations,
  'max_selections': ?instance.maxSelections,
  'min_selections': ?instance.minSelections,
};
