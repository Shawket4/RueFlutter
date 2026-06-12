// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ErrorBodyCWProxy {
  ErrorBody error(String error);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ErrorBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ErrorBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ErrorBody call({String error});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfErrorBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfErrorBody.copyWith.fieldName(...)`
class _$ErrorBodyCWProxyImpl implements _$ErrorBodyCWProxy {
  const _$ErrorBodyCWProxyImpl(this._value);

  final ErrorBody _value;

  @override
  ErrorBody error(String error) => this(error: error);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ErrorBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ErrorBody(...).copyWith(id: 12, name: "My name")
  /// ````
  ErrorBody call({Object? error = const $CopyWithPlaceholder()}) {
    return ErrorBody(
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as String,
    );
  }
}

extension $ErrorBodyCopyWith on ErrorBody {
  /// Returns a callable class that can be used as follows: `instanceOfErrorBody.copyWith(...)` or like so:`instanceOfErrorBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ErrorBodyCWProxy get copyWith => _$ErrorBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorBody _$ErrorBodyFromJson(Map<String, dynamic> json) => $checkedCreate(
  'ErrorBody',
  json,
  ($checkedConvert) {
    $checkKeys(json, requiredKeys: const ['error']);
    final val = ErrorBody(error: $checkedConvert('error', (v) => v as String));
    return val;
  },
);

Map<String, dynamic> _$ErrorBodyToJson(ErrorBody instance) => <String, dynamic>{
  'error': instance.error,
};
