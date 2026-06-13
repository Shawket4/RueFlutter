// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classification_one_of2.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ClassificationOneOf2CWProxy {
  ClassificationOneOf2 mode(ClassificationOneOf2ModeEnum mode);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClassificationOneOf2(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClassificationOneOf2(...).copyWith(id: 12, name: "My name")
  /// ````
  ClassificationOneOf2 call({ClassificationOneOf2ModeEnum mode});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfClassificationOneOf2.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfClassificationOneOf2.copyWith.fieldName(...)`
class _$ClassificationOneOf2CWProxyImpl
    implements _$ClassificationOneOf2CWProxy {
  const _$ClassificationOneOf2CWProxyImpl(this._value);

  final ClassificationOneOf2 _value;

  @override
  ClassificationOneOf2 mode(ClassificationOneOf2ModeEnum mode) =>
      this(mode: mode);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClassificationOneOf2(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClassificationOneOf2(...).copyWith(id: 12, name: "My name")
  /// ````
  ClassificationOneOf2 call({Object? mode = const $CopyWithPlaceholder()}) {
    return ClassificationOneOf2(
      mode: mode == const $CopyWithPlaceholder()
          ? _value.mode
          // ignore: cast_nullable_to_non_nullable
          : mode as ClassificationOneOf2ModeEnum,
    );
  }
}

extension $ClassificationOneOf2CopyWith on ClassificationOneOf2 {
  /// Returns a callable class that can be used as follows: `instanceOfClassificationOneOf2.copyWith(...)` or like so:`instanceOfClassificationOneOf2.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ClassificationOneOf2CWProxy get copyWith =>
      _$ClassificationOneOf2CWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassificationOneOf2 _$ClassificationOneOf2FromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ClassificationOneOf2', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['mode']);
  final val = ClassificationOneOf2(
    mode: $checkedConvert(
      'mode',
      (v) => $enumDecode(
        _$ClassificationOneOf2ModeEnumEnumMap,
        v,
        unknownValue: ClassificationOneOf2ModeEnum.unknownDefaultOpenApi,
      ),
    ),
  );
  return val;
});

Map<String, dynamic> _$ClassificationOneOf2ToJson(
  ClassificationOneOf2 instance,
) => <String, dynamic>{
  'mode': _$ClassificationOneOf2ModeEnumEnumMap[instance.mode]!,
};

const _$ClassificationOneOf2ModeEnumEnumMap = {
  ClassificationOneOf2ModeEnum.insufficient: 'insufficient',
  ClassificationOneOf2ModeEnum.unknownDefaultOpenApi:
      'unknown_default_open_api',
};
