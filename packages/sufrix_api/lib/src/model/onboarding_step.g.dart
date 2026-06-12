// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_step.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OnboardingStepCWProxy {
  OnboardingStep count(int count);

  OnboardingStep done(bool done);

  OnboardingStep key(String key);

  OnboardingStep required_(bool required_);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OnboardingStep(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OnboardingStep(...).copyWith(id: 12, name: "My name")
  /// ````
  OnboardingStep call({int count, bool done, String key, bool required_});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOnboardingStep.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOnboardingStep.copyWith.fieldName(...)`
class _$OnboardingStepCWProxyImpl implements _$OnboardingStepCWProxy {
  const _$OnboardingStepCWProxyImpl(this._value);

  final OnboardingStep _value;

  @override
  OnboardingStep count(int count) => this(count: count);

  @override
  OnboardingStep done(bool done) => this(done: done);

  @override
  OnboardingStep key(String key) => this(key: key);

  @override
  OnboardingStep required_(bool required_) => this(required_: required_);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OnboardingStep(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OnboardingStep(...).copyWith(id: 12, name: "My name")
  /// ````
  OnboardingStep call({
    Object? count = const $CopyWithPlaceholder(),
    Object? done = const $CopyWithPlaceholder(),
    Object? key = const $CopyWithPlaceholder(),
    Object? required_ = const $CopyWithPlaceholder(),
  }) {
    return OnboardingStep(
      count: count == const $CopyWithPlaceholder()
          ? _value.count
          // ignore: cast_nullable_to_non_nullable
          : count as int,
      done: done == const $CopyWithPlaceholder()
          ? _value.done
          // ignore: cast_nullable_to_non_nullable
          : done as bool,
      key: key == const $CopyWithPlaceholder()
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as String,
      required_: required_ == const $CopyWithPlaceholder()
          ? _value.required_
          // ignore: cast_nullable_to_non_nullable
          : required_ as bool,
    );
  }
}

extension $OnboardingStepCopyWith on OnboardingStep {
  /// Returns a callable class that can be used as follows: `instanceOfOnboardingStep.copyWith(...)` or like so:`instanceOfOnboardingStep.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OnboardingStepCWProxy get copyWith => _$OnboardingStepCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnboardingStep _$OnboardingStepFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OnboardingStep', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['count', 'done', 'key', 'required'],
      );
      final val = OnboardingStep(
        count: $checkedConvert('count', (v) => (v as num).toInt()),
        done: $checkedConvert('done', (v) => v as bool),
        key: $checkedConvert('key', (v) => v as String),
        required_: $checkedConvert('required', (v) => v as bool),
      );
      return val;
    }, fieldKeyMap: const {'required_': 'required'});

Map<String, dynamic> _$OnboardingStepToJson(OnboardingStep instance) =>
    <String, dynamic>{
      'count': instance.count,
      'done': instance.done,
      'key': instance.key,
      'required': instance.required_,
    };
