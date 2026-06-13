// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classification_one_of.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ClassificationOneOfCWProxy {
  ClassificationOneOf mode(ClassificationOneOfModeEnum mode);

  ClassificationOneOf quadrant(CmQuadrant quadrant);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClassificationOneOf(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClassificationOneOf(...).copyWith(id: 12, name: "My name")
  /// ````
  ClassificationOneOf call({
    ClassificationOneOfModeEnum mode,
    CmQuadrant quadrant,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfClassificationOneOf.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfClassificationOneOf.copyWith.fieldName(...)`
class _$ClassificationOneOfCWProxyImpl implements _$ClassificationOneOfCWProxy {
  const _$ClassificationOneOfCWProxyImpl(this._value);

  final ClassificationOneOf _value;

  @override
  ClassificationOneOf mode(ClassificationOneOfModeEnum mode) =>
      this(mode: mode);

  @override
  ClassificationOneOf quadrant(CmQuadrant quadrant) => this(quadrant: quadrant);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ClassificationOneOf(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ClassificationOneOf(...).copyWith(id: 12, name: "My name")
  /// ````
  ClassificationOneOf call({
    Object? mode = const $CopyWithPlaceholder(),
    Object? quadrant = const $CopyWithPlaceholder(),
  }) {
    return ClassificationOneOf(
      mode: mode == const $CopyWithPlaceholder()
          ? _value.mode
          // ignore: cast_nullable_to_non_nullable
          : mode as ClassificationOneOfModeEnum,
      quadrant: quadrant == const $CopyWithPlaceholder()
          ? _value.quadrant
          // ignore: cast_nullable_to_non_nullable
          : quadrant as CmQuadrant,
    );
  }
}

extension $ClassificationOneOfCopyWith on ClassificationOneOf {
  /// Returns a callable class that can be used as follows: `instanceOfClassificationOneOf.copyWith(...)` or like so:`instanceOfClassificationOneOf.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ClassificationOneOfCWProxy get copyWith =>
      _$ClassificationOneOfCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassificationOneOf _$ClassificationOneOfFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ClassificationOneOf', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['mode', 'quadrant']);
      final val = ClassificationOneOf(
        mode: $checkedConvert(
          'mode',
          (v) => $enumDecode(
            _$ClassificationOneOfModeEnumEnumMap,
            v,
            unknownValue: ClassificationOneOfModeEnum.unknownDefaultOpenApi,
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
      );
      return val;
    });

Map<String, dynamic> _$ClassificationOneOfToJson(
  ClassificationOneOf instance,
) => <String, dynamic>{
  'mode': _$ClassificationOneOfModeEnumEnumMap[instance.mode]!,
  'quadrant': _$CmQuadrantEnumMap[instance.quadrant]!,
};

const _$ClassificationOneOfModeEnumEnumMap = {
  ClassificationOneOfModeEnum.cm: 'cm',
  ClassificationOneOfModeEnum.unknownDefaultOpenApi: 'unknown_default_open_api',
};

const _$CmQuadrantEnumMap = {
  CmQuadrant.star: 'star',
  CmQuadrant.plowhorse: 'plowhorse',
  CmQuadrant.puzzle: 'puzzle',
  CmQuadrant.dog: 'dog',
  CmQuadrant.unknownDefaultOpenApi: 'unknown_default_open_api',
};
