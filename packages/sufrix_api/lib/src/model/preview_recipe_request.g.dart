// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_recipe_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PreviewRecipeRequestCWProxy {
  PreviewRecipeRequest addons(List<PreviewAddonInput> addons);

  PreviewRecipeRequest menuItemId(String menuItemId);

  PreviewRecipeRequest optionalFieldIds(List<String> optionalFieldIds);

  PreviewRecipeRequest sizeLabel(String? sizeLabel);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PreviewRecipeRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PreviewRecipeRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  PreviewRecipeRequest call({
    List<PreviewAddonInput> addons,
    String menuItemId,
    List<String> optionalFieldIds,
    String? sizeLabel,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPreviewRecipeRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPreviewRecipeRequest.copyWith.fieldName(...)`
class _$PreviewRecipeRequestCWProxyImpl
    implements _$PreviewRecipeRequestCWProxy {
  const _$PreviewRecipeRequestCWProxyImpl(this._value);

  final PreviewRecipeRequest _value;

  @override
  PreviewRecipeRequest addons(List<PreviewAddonInput> addons) =>
      this(addons: addons);

  @override
  PreviewRecipeRequest menuItemId(String menuItemId) =>
      this(menuItemId: menuItemId);

  @override
  PreviewRecipeRequest optionalFieldIds(List<String> optionalFieldIds) =>
      this(optionalFieldIds: optionalFieldIds);

  @override
  PreviewRecipeRequest sizeLabel(String? sizeLabel) =>
      this(sizeLabel: sizeLabel);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PreviewRecipeRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PreviewRecipeRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  PreviewRecipeRequest call({
    Object? addons = const $CopyWithPlaceholder(),
    Object? menuItemId = const $CopyWithPlaceholder(),
    Object? optionalFieldIds = const $CopyWithPlaceholder(),
    Object? sizeLabel = const $CopyWithPlaceholder(),
  }) {
    return PreviewRecipeRequest(
      addons: addons == const $CopyWithPlaceholder()
          ? _value.addons
          // ignore: cast_nullable_to_non_nullable
          : addons as List<PreviewAddonInput>,
      menuItemId: menuItemId == const $CopyWithPlaceholder()
          ? _value.menuItemId
          // ignore: cast_nullable_to_non_nullable
          : menuItemId as String,
      optionalFieldIds: optionalFieldIds == const $CopyWithPlaceholder()
          ? _value.optionalFieldIds
          // ignore: cast_nullable_to_non_nullable
          : optionalFieldIds as List<String>,
      sizeLabel: sizeLabel == const $CopyWithPlaceholder()
          ? _value.sizeLabel
          // ignore: cast_nullable_to_non_nullable
          : sizeLabel as String?,
    );
  }
}

extension $PreviewRecipeRequestCopyWith on PreviewRecipeRequest {
  /// Returns a callable class that can be used as follows: `instanceOfPreviewRecipeRequest.copyWith(...)` or like so:`instanceOfPreviewRecipeRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PreviewRecipeRequestCWProxy get copyWith =>
      _$PreviewRecipeRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreviewRecipeRequest _$PreviewRecipeRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'PreviewRecipeRequest',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['addons', 'menu_item_id', 'optional_field_ids'],
    );
    final val = PreviewRecipeRequest(
      addons: $checkedConvert(
        'addons',
        (v) => (v as List<dynamic>)
            .map((e) => PreviewAddonInput.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      menuItemId: $checkedConvert('menu_item_id', (v) => v as String),
      optionalFieldIds: $checkedConvert(
        'optional_field_ids',
        (v) => (v as List<dynamic>).map((e) => e as String).toList(),
      ),
      sizeLabel: $checkedConvert('size_label', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'menuItemId': 'menu_item_id',
    'optionalFieldIds': 'optional_field_ids',
    'sizeLabel': 'size_label',
  },
);

Map<String, dynamic> _$PreviewRecipeRequestToJson(
  PreviewRecipeRequest instance,
) => <String, dynamic>{
  'addons': instance.addons.map((e) => e.toJson()).toList(),
  'menu_item_id': instance.menuItemId,
  'optional_field_ids': instance.optionalFieldIds,
  'size_label': ?instance.sizeLabel,
};
