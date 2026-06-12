// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_bundle_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateBundleRequestCWProxy {
  UpdateBundleRequest availableFromDate(DateTime? availableFromDate);

  UpdateBundleRequest availableFromTime(String? availableFromTime);

  UpdateBundleRequest availableUntilDate(DateTime? availableUntilDate);

  UpdateBundleRequest availableUntilTime(String? availableUntilTime);

  UpdateBundleRequest branchIds(List<String>? branchIds);

  UpdateBundleRequest components(List<CreateBundleComponentInput>? components);

  UpdateBundleRequest description(String? description);

  UpdateBundleRequest descriptionTranslations(Object? descriptionTranslations);

  UpdateBundleRequest displayOrder(int? displayOrder);

  UpdateBundleRequest imageUrl(String? imageUrl);

  UpdateBundleRequest name(String? name);

  UpdateBundleRequest nameTranslations(Object? nameTranslations);

  UpdateBundleRequest price(int? price);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateBundleRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateBundleRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateBundleRequest call({
    DateTime? availableFromDate,
    String? availableFromTime,
    DateTime? availableUntilDate,
    String? availableUntilTime,
    List<String>? branchIds,
    List<CreateBundleComponentInput>? components,
    String? description,
    Object? descriptionTranslations,
    int? displayOrder,
    String? imageUrl,
    String? name,
    Object? nameTranslations,
    int? price,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateBundleRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateBundleRequest.copyWith.fieldName(...)`
class _$UpdateBundleRequestCWProxyImpl implements _$UpdateBundleRequestCWProxy {
  const _$UpdateBundleRequestCWProxyImpl(this._value);

  final UpdateBundleRequest _value;

  @override
  UpdateBundleRequest availableFromDate(DateTime? availableFromDate) =>
      this(availableFromDate: availableFromDate);

  @override
  UpdateBundleRequest availableFromTime(String? availableFromTime) =>
      this(availableFromTime: availableFromTime);

  @override
  UpdateBundleRequest availableUntilDate(DateTime? availableUntilDate) =>
      this(availableUntilDate: availableUntilDate);

  @override
  UpdateBundleRequest availableUntilTime(String? availableUntilTime) =>
      this(availableUntilTime: availableUntilTime);

  @override
  UpdateBundleRequest branchIds(List<String>? branchIds) =>
      this(branchIds: branchIds);

  @override
  UpdateBundleRequest components(
    List<CreateBundleComponentInput>? components,
  ) => this(components: components);

  @override
  UpdateBundleRequest description(String? description) =>
      this(description: description);

  @override
  UpdateBundleRequest descriptionTranslations(
    Object? descriptionTranslations,
  ) => this(descriptionTranslations: descriptionTranslations);

  @override
  UpdateBundleRequest displayOrder(int? displayOrder) =>
      this(displayOrder: displayOrder);

  @override
  UpdateBundleRequest imageUrl(String? imageUrl) => this(imageUrl: imageUrl);

  @override
  UpdateBundleRequest name(String? name) => this(name: name);

  @override
  UpdateBundleRequest nameTranslations(Object? nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  UpdateBundleRequest price(int? price) => this(price: price);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateBundleRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateBundleRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateBundleRequest call({
    Object? availableFromDate = const $CopyWithPlaceholder(),
    Object? availableFromTime = const $CopyWithPlaceholder(),
    Object? availableUntilDate = const $CopyWithPlaceholder(),
    Object? availableUntilTime = const $CopyWithPlaceholder(),
    Object? branchIds = const $CopyWithPlaceholder(),
    Object? components = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? descriptionTranslations = const $CopyWithPlaceholder(),
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? nameTranslations = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
  }) {
    return UpdateBundleRequest(
      availableFromDate: availableFromDate == const $CopyWithPlaceholder()
          ? _value.availableFromDate
          // ignore: cast_nullable_to_non_nullable
          : availableFromDate as DateTime?,
      availableFromTime: availableFromTime == const $CopyWithPlaceholder()
          ? _value.availableFromTime
          // ignore: cast_nullable_to_non_nullable
          : availableFromTime as String?,
      availableUntilDate: availableUntilDate == const $CopyWithPlaceholder()
          ? _value.availableUntilDate
          // ignore: cast_nullable_to_non_nullable
          : availableUntilDate as DateTime?,
      availableUntilTime: availableUntilTime == const $CopyWithPlaceholder()
          ? _value.availableUntilTime
          // ignore: cast_nullable_to_non_nullable
          : availableUntilTime as String?,
      branchIds: branchIds == const $CopyWithPlaceholder()
          ? _value.branchIds
          // ignore: cast_nullable_to_non_nullable
          : branchIds as List<String>?,
      components: components == const $CopyWithPlaceholder()
          ? _value.components
          // ignore: cast_nullable_to_non_nullable
          : components as List<CreateBundleComponentInput>?,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      descriptionTranslations:
          descriptionTranslations == const $CopyWithPlaceholder()
          ? _value.descriptionTranslations
          // ignore: cast_nullable_to_non_nullable
          : descriptionTranslations as Object?,
      displayOrder: displayOrder == const $CopyWithPlaceholder()
          ? _value.displayOrder
          // ignore: cast_nullable_to_non_nullable
          : displayOrder as int?,
      imageUrl: imageUrl == const $CopyWithPlaceholder()
          ? _value.imageUrl
          // ignore: cast_nullable_to_non_nullable
          : imageUrl as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      nameTranslations: nameTranslations == const $CopyWithPlaceholder()
          ? _value.nameTranslations
          // ignore: cast_nullable_to_non_nullable
          : nameTranslations as Object?,
      price: price == const $CopyWithPlaceholder()
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as int?,
    );
  }
}

extension $UpdateBundleRequestCopyWith on UpdateBundleRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateBundleRequest.copyWith(...)` or like so:`instanceOfUpdateBundleRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateBundleRequestCWProxy get copyWith =>
      _$UpdateBundleRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateBundleRequest _$UpdateBundleRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UpdateBundleRequest',
      json,
      ($checkedConvert) {
        final val = UpdateBundleRequest(
          availableFromDate: $checkedConvert(
            'available_from_date',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          availableFromTime: $checkedConvert(
            'available_from_time',
            (v) => v as String?,
          ),
          availableUntilDate: $checkedConvert(
            'available_until_date',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          availableUntilTime: $checkedConvert(
            'available_until_time',
            (v) => v as String?,
          ),
          branchIds: $checkedConvert(
            'branch_ids',
            (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
          ),
          components: $checkedConvert(
            'components',
            (v) => (v as List<dynamic>?)
                ?.map(
                  (e) => CreateBundleComponentInput.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList(),
          ),
          description: $checkedConvert('description', (v) => v as String?),
          descriptionTranslations: $checkedConvert(
            'description_translations',
            (v) => v,
          ),
          displayOrder: $checkedConvert(
            'display_order',
            (v) => (v as num?)?.toInt(),
          ),
          imageUrl: $checkedConvert('image_url', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
          nameTranslations: $checkedConvert('name_translations', (v) => v),
          price: $checkedConvert('price', (v) => (v as num?)?.toInt()),
        );
        return val;
      },
      fieldKeyMap: const {
        'availableFromDate': 'available_from_date',
        'availableFromTime': 'available_from_time',
        'availableUntilDate': 'available_until_date',
        'availableUntilTime': 'available_until_time',
        'branchIds': 'branch_ids',
        'descriptionTranslations': 'description_translations',
        'displayOrder': 'display_order',
        'imageUrl': 'image_url',
        'nameTranslations': 'name_translations',
      },
    );

Map<String, dynamic> _$UpdateBundleRequestToJson(
  UpdateBundleRequest instance,
) => <String, dynamic>{
  'available_from_date': ?instance.availableFromDate?.toIso8601String(),
  'available_from_time': ?instance.availableFromTime,
  'available_until_date': ?instance.availableUntilDate?.toIso8601String(),
  'available_until_time': ?instance.availableUntilTime,
  'branch_ids': ?instance.branchIds,
  'components': ?instance.components?.map((e) => e.toJson()).toList(),
  'description': ?instance.description,
  'description_translations': ?instance.descriptionTranslations,
  'display_order': ?instance.displayOrder,
  'image_url': ?instance.imageUrl,
  'name': ?instance.name,
  'name_translations': ?instance.nameTranslations,
  'price': ?instance.price,
};
