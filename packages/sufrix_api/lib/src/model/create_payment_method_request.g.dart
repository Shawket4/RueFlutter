// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_payment_method_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreatePaymentMethodRequestCWProxy {
  CreatePaymentMethodRequest color(String color);

  CreatePaymentMethodRequest displayOrder(int? displayOrder);

  CreatePaymentMethodRequest icon(String icon);

  CreatePaymentMethodRequest isActive(bool? isActive);

  CreatePaymentMethodRequest isCash(bool isCash);

  CreatePaymentMethodRequest labelTranslations(
    Map<String, String> labelTranslations,
  );

  CreatePaymentMethodRequest name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreatePaymentMethodRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreatePaymentMethodRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreatePaymentMethodRequest call({
    String color,
    int? displayOrder,
    String icon,
    bool? isActive,
    bool isCash,
    Map<String, String> labelTranslations,
    String name,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreatePaymentMethodRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreatePaymentMethodRequest.copyWith.fieldName(...)`
class _$CreatePaymentMethodRequestCWProxyImpl
    implements _$CreatePaymentMethodRequestCWProxy {
  const _$CreatePaymentMethodRequestCWProxyImpl(this._value);

  final CreatePaymentMethodRequest _value;

  @override
  CreatePaymentMethodRequest color(String color) => this(color: color);

  @override
  CreatePaymentMethodRequest displayOrder(int? displayOrder) =>
      this(displayOrder: displayOrder);

  @override
  CreatePaymentMethodRequest icon(String icon) => this(icon: icon);

  @override
  CreatePaymentMethodRequest isActive(bool? isActive) =>
      this(isActive: isActive);

  @override
  CreatePaymentMethodRequest isCash(bool isCash) => this(isCash: isCash);

  @override
  CreatePaymentMethodRequest labelTranslations(
    Map<String, String> labelTranslations,
  ) => this(labelTranslations: labelTranslations);

  @override
  CreatePaymentMethodRequest name(String name) => this(name: name);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreatePaymentMethodRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreatePaymentMethodRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreatePaymentMethodRequest call({
    Object? color = const $CopyWithPlaceholder(),
    Object? displayOrder = const $CopyWithPlaceholder(),
    Object? icon = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? isCash = const $CopyWithPlaceholder(),
    Object? labelTranslations = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return CreatePaymentMethodRequest(
      color: color == const $CopyWithPlaceholder()
          ? _value.color
          // ignore: cast_nullable_to_non_nullable
          : color as String,
      displayOrder: displayOrder == const $CopyWithPlaceholder()
          ? _value.displayOrder
          // ignore: cast_nullable_to_non_nullable
          : displayOrder as int?,
      icon: icon == const $CopyWithPlaceholder()
          ? _value.icon
          // ignore: cast_nullable_to_non_nullable
          : icon as String,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      isCash: isCash == const $CopyWithPlaceholder()
          ? _value.isCash
          // ignore: cast_nullable_to_non_nullable
          : isCash as bool,
      labelTranslations: labelTranslations == const $CopyWithPlaceholder()
          ? _value.labelTranslations
          // ignore: cast_nullable_to_non_nullable
          : labelTranslations as Map<String, String>,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $CreatePaymentMethodRequestCopyWith on CreatePaymentMethodRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreatePaymentMethodRequest.copyWith(...)` or like so:`instanceOfCreatePaymentMethodRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreatePaymentMethodRequestCWProxy get copyWith =>
      _$CreatePaymentMethodRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePaymentMethodRequest _$CreatePaymentMethodRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'CreatePaymentMethodRequest',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'color',
        'icon',
        'is_cash',
        'label_translations',
        'name',
      ],
    );
    final val = CreatePaymentMethodRequest(
      color: $checkedConvert('color', (v) => v as String),
      displayOrder: $checkedConvert(
        'display_order',
        (v) => (v as num?)?.toInt(),
      ),
      icon: $checkedConvert('icon', (v) => v as String),
      isActive: $checkedConvert('is_active', (v) => v as bool?),
      isCash: $checkedConvert('is_cash', (v) => v as bool),
      labelTranslations: $checkedConvert(
        'label_translations',
        (v) => Map<String, String>.from(v as Map),
      ),
      name: $checkedConvert('name', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'displayOrder': 'display_order',
    'isActive': 'is_active',
    'isCash': 'is_cash',
    'labelTranslations': 'label_translations',
  },
);

Map<String, dynamic> _$CreatePaymentMethodRequestToJson(
  CreatePaymentMethodRequest instance,
) => <String, dynamic>{
  'color': instance.color,
  'display_order': ?instance.displayOrder,
  'icon': instance.icon,
  'is_active': ?instance.isActive,
  'is_cash': instance.isCash,
  'label_translations': instance.labelTranslations,
  'name': instance.name,
};
