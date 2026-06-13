// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_addon_slot_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateAddonSlotRequestCWProxy {
  CreateAddonSlotRequest addonType(String? addonType);

  CreateAddonSlotRequest isRequired(bool? isRequired);

  CreateAddonSlotRequest label(String? label);

  CreateAddonSlotRequest labelTranslations(Object? labelTranslations);

  CreateAddonSlotRequest maxSelections(int? maxSelections);

  CreateAddonSlotRequest minSelections(int? minSelections);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateAddonSlotRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateAddonSlotRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateAddonSlotRequest call({
    String? addonType,
    bool? isRequired,
    String? label,
    Object? labelTranslations,
    int? maxSelections,
    int? minSelections,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateAddonSlotRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateAddonSlotRequest.copyWith.fieldName(...)`
class _$CreateAddonSlotRequestCWProxyImpl
    implements _$CreateAddonSlotRequestCWProxy {
  const _$CreateAddonSlotRequestCWProxyImpl(this._value);

  final CreateAddonSlotRequest _value;

  @override
  CreateAddonSlotRequest addonType(String? addonType) =>
      this(addonType: addonType);

  @override
  CreateAddonSlotRequest isRequired(bool? isRequired) =>
      this(isRequired: isRequired);

  @override
  CreateAddonSlotRequest label(String? label) => this(label: label);

  @override
  CreateAddonSlotRequest labelTranslations(Object? labelTranslations) =>
      this(labelTranslations: labelTranslations);

  @override
  CreateAddonSlotRequest maxSelections(int? maxSelections) =>
      this(maxSelections: maxSelections);

  @override
  CreateAddonSlotRequest minSelections(int? minSelections) =>
      this(minSelections: minSelections);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateAddonSlotRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateAddonSlotRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateAddonSlotRequest call({
    Object? addonType = const $CopyWithPlaceholder(),
    Object? isRequired = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? labelTranslations = const $CopyWithPlaceholder(),
    Object? maxSelections = const $CopyWithPlaceholder(),
    Object? minSelections = const $CopyWithPlaceholder(),
  }) {
    return CreateAddonSlotRequest(
      addonType: addonType == const $CopyWithPlaceholder()
          ? _value.addonType
          // ignore: cast_nullable_to_non_nullable
          : addonType as String?,
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

extension $CreateAddonSlotRequestCopyWith on CreateAddonSlotRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreateAddonSlotRequest.copyWith(...)` or like so:`instanceOfCreateAddonSlotRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateAddonSlotRequestCWProxy get copyWith =>
      _$CreateAddonSlotRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAddonSlotRequest _$CreateAddonSlotRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'CreateAddonSlotRequest',
  json,
  ($checkedConvert) {
    final val = CreateAddonSlotRequest(
      addonType: $checkedConvert('addon_type', (v) => v as String?),
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
    'addonType': 'addon_type',
    'isRequired': 'is_required',
    'labelTranslations': 'label_translations',
    'maxSelections': 'max_selections',
    'minSelections': 'min_selections',
  },
);

Map<String, dynamic> _$CreateAddonSlotRequestToJson(
  CreateAddonSlotRequest instance,
) => <String, dynamic>{
  'addon_type': ?instance.addonType,
  'is_required': ?instance.isRequired,
  'label': ?instance.label,
  'label_translations': ?instance.labelTranslations,
  'max_selections': ?instance.maxSelections,
  'min_selections': ?instance.minSelections,
};
