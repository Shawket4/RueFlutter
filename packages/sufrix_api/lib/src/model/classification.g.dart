// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classification.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ClassificationCWProxy {
  Classification mode(ClassificationModeEnum mode);

  Classification quadrant(CmQuadrant quadrant);

  Classification class_(RevenueClass class_);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Classification(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Classification(...).copyWith(id: 12, name: "My name")
  /// ````
  Classification call({
    ClassificationModeEnum mode,
    CmQuadrant quadrant,
    RevenueClass class_,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfClassification.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfClassification.copyWith.fieldName(...)`
class _$ClassificationCWProxyImpl implements _$ClassificationCWProxy {
  const _$ClassificationCWProxyImpl(this._value);

  final Classification _value;

  @override
  Classification mode(ClassificationModeEnum mode) => this(mode: mode);

  @override
  Classification quadrant(CmQuadrant quadrant) => this(quadrant: quadrant);

  @override
  Classification class_(RevenueClass class_) => this(class_: class_);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Classification(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Classification(...).copyWith(id: 12, name: "My name")
  /// ````
  Classification call({
    Object? mode = const $CopyWithPlaceholder(),
    Object? quadrant = const $CopyWithPlaceholder(),
    Object? class_ = const $CopyWithPlaceholder(),
  }) {
    return Classification(
      mode: mode == const $CopyWithPlaceholder()
          ? _value.mode
          // ignore: cast_nullable_to_non_nullable
          : mode as ClassificationModeEnum,
      quadrant: quadrant == const $CopyWithPlaceholder()
          ? _value.quadrant
          // ignore: cast_nullable_to_non_nullable
          : quadrant as CmQuadrant,
      class_: class_ == const $CopyWithPlaceholder()
          ? _value.class_
          // ignore: cast_nullable_to_non_nullable
          : class_ as RevenueClass,
    );
  }
}

extension $ClassificationCopyWith on Classification {
  /// Returns a callable class that can be used as follows: `instanceOfClassification.copyWith(...)` or like so:`instanceOfClassification.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ClassificationCWProxy get copyWith => _$ClassificationCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Classification _$ClassificationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Classification', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['mode', 'quadrant', 'class']);
      final val = Classification(
        mode: $checkedConvert(
          'mode',
          (v) => $enumDecode(
            _$ClassificationModeEnumEnumMap,
            v,
            unknownValue: ClassificationModeEnum.unknownDefaultOpenApi,
          ),
        ),
        quadrant: $checkedConvert(
          'quadrant',
          (v) => $enumDecode(
            _$CmQuadrantEnumMap,
            v,
            unknownValue: CmQuadrant.unknownDefaultOpenApi,
          ),
        ),
        class_: $checkedConvert(
          'class',
          (v) => $enumDecode(
            _$RevenueClassEnumMap,
            v,
            unknownValue: RevenueClass.unknownDefaultOpenApi,
          ),
        ),
      );
      return val;
    }, fieldKeyMap: const {'class_': 'class'});

Map<String, dynamic> _$ClassificationToJson(Classification instance) =>
    <String, dynamic>{
      'mode': _$ClassificationModeEnumEnumMap[instance.mode]!,
      'quadrant': _$CmQuadrantEnumMap[instance.quadrant]!,
      'class': _$RevenueClassEnumMap[instance.class_]!,
    };

const _$ClassificationModeEnumEnumMap = {
  ClassificationModeEnum.insufficient: 'insufficient',
  ClassificationModeEnum.unknownDefaultOpenApi: 'unknown_default_open_api',
};

const _$CmQuadrantEnumMap = {
  CmQuadrant.star: 'star',
  CmQuadrant.plowhorse: 'plowhorse',
  CmQuadrant.puzzle: 'puzzle',
  CmQuadrant.dog: 'dog',
  CmQuadrant.unknownDefaultOpenApi: 'unknown_default_open_api',
};

const _$RevenueClassEnumMap = {
  RevenueClass.hero: 'hero',
  RevenueClass.steady: 'steady',
  RevenueClass.slow: 'slow',
  RevenueClass.quiet: 'quiet',
  RevenueClass.unknownDefaultOpenApi: 'unknown_default_open_api',
};
