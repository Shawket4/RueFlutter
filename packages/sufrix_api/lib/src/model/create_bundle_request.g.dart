// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_bundle_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateBundleRequestCWProxy {
  CreateBundleRequest availableFromDate(DateTime? availableFromDate);

  CreateBundleRequest availableFromTime(String? availableFromTime);

  CreateBundleRequest availableUntilDate(DateTime? availableUntilDate);

  CreateBundleRequest availableUntilTime(String? availableUntilTime);

  CreateBundleRequest branchIds(List<String>? branchIds);

  CreateBundleRequest components(List<CreateBundleComponentInput> components);

  CreateBundleRequest description(String? description);

  CreateBundleRequest descriptionTranslations(Object? descriptionTranslations);

  CreateBundleRequest displayOrder(int? displayOrder);

  CreateBundleRequest imageUrl(String? imageUrl);

  CreateBundleRequest name(String name);

  CreateBundleRequest nameTranslations(Object? nameTranslations);

  CreateBundleRequest orgId(String orgId);

  CreateBundleRequest price(int price);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateBundleRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateBundleRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateBundleRequest call({
    DateTime? availableFromDate,
    String? availableFromTime,
    DateTime? availableUntilDate,
    String? availableUntilTime,
    List<String>? branchIds,
    List<CreateBundleComponentInput> components,
    String? description,
    Object? descriptionTranslations,
    int? displayOrder,
    String? imageUrl,
    String name,
    Object? nameTranslations,
    String orgId,
    int price,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateBundleRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateBundleRequest.copyWith.fieldName(...)`
class _$CreateBundleRequestCWProxyImpl implements _$CreateBundleRequestCWProxy {
  const _$CreateBundleRequestCWProxyImpl(this._value);

  final CreateBundleRequest _value;

  @override
  CreateBundleRequest availableFromDate(DateTime? availableFromDate) =>
      this(availableFromDate: availableFromDate);

  @override
  CreateBundleRequest availableFromTime(String? availableFromTime) =>
      this(availableFromTime: availableFromTime);

  @override
  CreateBundleRequest availableUntilDate(DateTime? availableUntilDate) =>
      this(availableUntilDate: availableUntilDate);

  @override
  CreateBundleRequest availableUntilTime(String? availableUntilTime) =>
      this(availableUntilTime: availableUntilTime);

  @override
  CreateBundleRequest branchIds(List<String>? branchIds) =>
      this(branchIds: branchIds);

  @override
  CreateBundleRequest components(List<CreateBundleComponentInput> components) =>
      this(components: components);

  @override
  CreateBundleRequest description(String? description) =>
      this(description: description);

  @override
  CreateBundleRequest descriptionTranslations(
    Object? descriptionTranslations,
  ) => this(descriptionTranslations: descriptionTranslations);

  @override
  CreateBundleRequest displayOrder(int? displayOrder) =>
      this(displayOrder: displayOrder);

  @override
  CreateBundleRequest imageUrl(String? imageUrl) => this(imageUrl: imageUrl);

  @override
  CreateBundleRequest name(String name) => this(name: name);

  @override
  CreateBundleRequest nameTranslations(Object? nameTranslations) =>
      this(nameTranslations: nameTranslations);

  @override
  CreateBundleRequest orgId(String orgId) => this(orgId: orgId);

  @override
  CreateBundleRequest price(int price) => this(price: price);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateBundleRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateBundleRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateBundleRequest call({
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
    Object? orgId = const $CopyWithPlaceholder(),
    Object? price = const $CopyWithPlaceholder(),
  }) {
    return CreateBundleRequest(
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
          : components as List<CreateBundleComponentInput>,
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
          : name as String,
      nameTranslations: nameTranslations == const $CopyWithPlaceholder()
          ? _value.nameTranslations
          // ignore: cast_nullable_to_non_nullable
          : nameTranslations as Object?,
      orgId: orgId == const $CopyWithPlaceholder()
          ? _value.orgId
          // ignore: cast_nullable_to_non_nullable
          : orgId as String,
      price: price == const $CopyWithPlaceholder()
          ? _value.price
          // ignore: cast_nullable_to_non_nullable
          : price as int,
    );
  }
}

extension $CreateBundleRequestCopyWith on CreateBundleRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreateBundleRequest.copyWith(...)` or like so:`instanceOfCreateBundleRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateBundleRequestCWProxy get copyWith =>
      _$CreateBundleRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBundleRequest _$CreateBundleRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CreateBundleRequest',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['components', 'name', 'org_id', 'price'],
        );
        final val = CreateBundleRequest(
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
            (v) => (v as List<dynamic>)
                .map(
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
          name: $checkedConvert('name', (v) => v as String),
          nameTranslations: $checkedConvert('name_translations', (v) => v),
          orgId: $checkedConvert('org_id', (v) => v as String),
          price: $checkedConvert('price', (v) => (v as num).toInt()),
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
        'orgId': 'org_id',
      },
    );

Map<String, dynamic> _$CreateBundleRequestToJson(
  CreateBundleRequest instance,
) => <String, dynamic>{
  'available_from_date': ?instance.availableFromDate?.toIso8601String(),
  'available_from_time': ?instance.availableFromTime,
  'available_until_date': ?instance.availableUntilDate?.toIso8601String(),
  'available_until_time': ?instance.availableUntilTime,
  'branch_ids': ?instance.branchIds,
  'components': instance.components.map((e) => e.toJson()).toList(),
  'description': ?instance.description,
  'description_translations': ?instance.descriptionTranslations,
  'display_order': ?instance.displayOrder,
  'image_url': ?instance.imageUrl,
  'name': instance.name,
  'name_translations': ?instance.nameTranslations,
  'org_id': instance.orgId,
  'price': instance.price,
};
