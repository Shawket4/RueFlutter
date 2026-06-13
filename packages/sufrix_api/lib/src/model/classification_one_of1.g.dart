// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classification_one_of1.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ClassificationOneOf1CWProxy {
  ClassificationOneOf1 class_(RevenueClass class_);

  ClassificationOneOf1 mode(ClassificationOneOf1ModeEnum mode);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClassificationOneOf1(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClassificationOneOf1(...).copyWith(id: 12, name: "My name")
  /// ````
  ClassificationOneOf1 call({
    RevenueClass class_,
    ClassificationOneOf1ModeEnum mode,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfClassificationOneOf1.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfClassificationOneOf1.copyWith.fieldName(...)`
class _$ClassificationOneOf1CWProxyImpl
    implements _$ClassificationOneOf1CWProxy {
  const _$ClassificationOneOf1CWProxyImpl(this._value);

  final ClassificationOneOf1 _value;

  @override
  ClassificationOneOf1 class_(RevenueClass class_) => this(class_: class_);

  @override
  ClassificationOneOf1 mode(ClassificationOneOf1ModeEnum mode) =>
      this(mode: mode);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClassificationOneOf1(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClassificationOneOf1(...).copyWith(id: 12, name: "My name")
  /// ````
  ClassificationOneOf1 call({
    Object? class_ = const $CopyWithPlaceholder(),
    Object? mode = const $CopyWithPlaceholder(),
  }) {
    return ClassificationOneOf1(
      class_: class_ == const $CopyWithPlaceholder()
          ? _value.class_
          // ignore: cast_nullable_to_non_nullable
          : class_ as RevenueClass,
      mode: mode == const $CopyWithPlaceholder()
          ? _value.mode
          // ignore: cast_nullable_to_non_nullable
          : mode as ClassificationOneOf1ModeEnum,
    );
  }
}

extension $ClassificationOneOf1CopyWith on ClassificationOneOf1 {
  /// Returns a callable class that can be used as follows: `instanceOfClassificationOneOf1.copyWith(...)` or like so:`instanceOfClassificationOneOf1.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ClassificationOneOf1CWProxy get copyWith =>
      _$ClassificationOneOf1CWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassificationOneOf1 _$ClassificationOneOf1FromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ClassificationOneOf1', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['class', 'mode']);
  final val = ClassificationOneOf1(
    class_: $checkedConvert(
      'class',
      (v) => $enumDecode(
        _$RevenueClassEnumMap,
        v,
        unknownValue: RevenueClass.unknownDefaultOpenApi,
      ),
    ),
    mode: $checkedConvert(
      'mode',
      (v) => $enumDecode(
        _$ClassificationOneOf1ModeEnumEnumMap,
        v,
        unknownValue: ClassificationOneOf1ModeEnum.unknownDefaultOpenApi,
      ),
    ),
  );
  return val;
}, fieldKeyMap: const {'class_': 'class'});

Map<String, dynamic> _$ClassificationOneOf1ToJson(
  ClassificationOneOf1 instance,
) => <String, dynamic>{
  'class': _$RevenueClassEnumMap[instance.class_]!,
  'mode': _$ClassificationOneOf1ModeEnumEnumMap[instance.mode]!,
};

const _$RevenueClassEnumMap = {
  RevenueClass.hero: 'hero',
  RevenueClass.steady: 'steady',
  RevenueClass.slow: 'slow',
  RevenueClass.quiet: 'quiet',
  RevenueClass.unknownDefaultOpenApi: 'unknown_default_open_api',
};

const _$ClassificationOneOf1ModeEnumEnumMap = {
  ClassificationOneOf1ModeEnum.revenue: 'revenue',
  ClassificationOneOf1ModeEnum.unknownDefaultOpenApi:
      'unknown_default_open_api',
};
