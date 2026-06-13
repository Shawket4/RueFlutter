// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_payment_method_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdatePaymentMethodRequestCWProxy {
  UpdatePaymentMethodRequest color(String? color);

  UpdatePaymentMethodRequest icon(String? icon);

  UpdatePaymentMethodRequest isActive(bool? isActive);

  UpdatePaymentMethodRequest isCash(bool? isCash);

  UpdatePaymentMethodRequest labelTranslations(
    Map<String, String>? labelTranslations,
  );

  UpdatePaymentMethodRequest name(String? name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdatePaymentMethodRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdatePaymentMethodRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdatePaymentMethodRequest call({
    String? color,
    String? icon,
    bool? isActive,
    bool? isCash,
    Map<String, String>? labelTranslations,
    String? name,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdatePaymentMethodRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdatePaymentMethodRequest.copyWith.fieldName(...)`
class _$UpdatePaymentMethodRequestCWProxyImpl
    implements _$UpdatePaymentMethodRequestCWProxy {
  const _$UpdatePaymentMethodRequestCWProxyImpl(this._value);

  final UpdatePaymentMethodRequest _value;

  @override
  UpdatePaymentMethodRequest color(String? color) => this(color: color);

  @override
  UpdatePaymentMethodRequest icon(String? icon) => this(icon: icon);

  @override
  UpdatePaymentMethodRequest isActive(bool? isActive) =>
      this(isActive: isActive);

  @override
  UpdatePaymentMethodRequest isCash(bool? isCash) => this(isCash: isCash);

  @override
  UpdatePaymentMethodRequest labelTranslations(
    Map<String, String>? labelTranslations,
  ) => this(labelTranslations: labelTranslations);

  @override
  UpdatePaymentMethodRequest name(String? name) => this(name: name);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdatePaymentMethodRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdatePaymentMethodRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdatePaymentMethodRequest call({
    Object? color = const $CopyWithPlaceholder(),
    Object? icon = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? isCash = const $CopyWithPlaceholder(),
    Object? labelTranslations = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return UpdatePaymentMethodRequest(
      color: color == const $CopyWithPlaceholder()
          ? _value.color
          // ignore: cast_nullable_to_non_nullable
          : color as String?,
      icon: icon == const $CopyWithPlaceholder()
          ? _value.icon
          // ignore: cast_nullable_to_non_nullable
          : icon as String?,
      isActive: isActive == const $CopyWithPlaceholder()
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool?,
      isCash: isCash == const $CopyWithPlaceholder()
          ? _value.isCash
          // ignore: cast_nullable_to_non_nullable
          : isCash as bool?,
      labelTranslations: labelTranslations == const $CopyWithPlaceholder()
          ? _value.labelTranslations
          // ignore: cast_nullable_to_non_nullable
          : labelTranslations as Map<String, String>?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
    );
  }
}

extension $UpdatePaymentMethodRequestCopyWith on UpdatePaymentMethodRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdatePaymentMethodRequest.copyWith(...)` or like so:`instanceOfUpdatePaymentMethodRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdatePaymentMethodRequestCWProxy get copyWith =>
      _$UpdatePaymentMethodRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePaymentMethodRequest _$UpdatePaymentMethodRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'UpdatePaymentMethodRequest',
  json,
  ($checkedConvert) {
    final val = UpdatePaymentMethodRequest(
      color: $checkedConvert('color', (v) => v as String?),
      icon: $checkedConvert('icon', (v) => v as String?),
      isActive: $checkedConvert('is_active', (v) => v as bool?),
      isCash: $checkedConvert('is_cash', (v) => v as bool?),
      labelTranslations: $checkedConvert(
        'label_translations',
        (v) => (v as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(k, e as String),
        ),
      ),
      name: $checkedConvert('name', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'isActive': 'is_active',
    'isCash': 'is_cash',
    'labelTranslations': 'label_translations',
  },
);

Map<String, dynamic> _$UpdatePaymentMethodRequestToJson(
  UpdatePaymentMethodRequest instance,
) => <String, dynamic>{
  'color': ?instance.color,
  'icon': ?instance.icon,
  'is_active': ?instance.isActive,
  'is_cash': ?instance.isCash,
  'label_translations': ?instance.labelTranslations,
  'name': ?instance.name,
};
