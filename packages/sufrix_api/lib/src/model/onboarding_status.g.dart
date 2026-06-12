// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_status.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OnboardingStatusCWProxy {
  OnboardingStatus canComplete(bool canComplete);

  OnboardingStatus completed(bool completed);

  OnboardingStatus completedAt(DateTime? completedAt);

  OnboardingStatus orgId(String orgId);

  OnboardingStatus recipeCoverage(double recipeCoverage);

  OnboardingStatus steps(List<OnboardingStep> steps);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OnboardingStatus(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OnboardingStatus(...).copyWith(id: 12, name: "My name")
  /// ````
  OnboardingStatus call({
    bool canComplete,
    bool completed,
    DateTime? completedAt,
    String orgId,
    double recipeCoverage,
    List<OnboardingStep> steps,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOnboardingStatus.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOnboardingStatus.copyWith.fieldName(...)`
class _$OnboardingStatusCWProxyImpl implements _$OnboardingStatusCWProxy {
  const _$OnboardingStatusCWProxyImpl(this._value);

  final OnboardingStatus _value;

  @override
  OnboardingStatus canComplete(bool canComplete) =>
      this(canComplete: canComplete);

  @override
  OnboardingStatus completed(bool completed) => this(completed: completed);

  @override
  OnboardingStatus completedAt(DateTime? completedAt) =>
      this(completedAt: completedAt);

  @override
  OnboardingStatus orgId(String orgId) => this(orgId: orgId);

  @override
  OnboardingStatus recipeCoverage(double recipeCoverage) =>
      this(recipeCoverage: recipeCoverage);

  @override
  OnboardingStatus steps(List<OnboardingStep> steps) => this(steps: steps);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OnboardingStatus(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OnboardingStatus(...).copyWith(id: 12, name: "My name")
  /// ````
  OnboardingStatus call({
    Object? canComplete = const $CopyWithPlaceholder(),
    Object? completed = const $CopyWithPlaceholder(),
    Object? completedAt = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
    Object? recipeCoverage = const $CopyWithPlaceholder(),
    Object? steps = const $CopyWithPlaceholder(),
  }) {
    return OnboardingStatus(
      canComplete: canComplete == const $CopyWithPlaceholder()
          ? _value.canComplete
          // ignore: cast_nullable_to_non_nullable
          : canComplete as bool,
      completed: completed == const $CopyWithPlaceholder()
          ? _value.completed
          // ignore: cast_nullable_to_non_nullable
          : completed as bool,
      completedAt: completedAt == const $CopyWithPlaceholder()
          ? _value.completedAt
          // ignore: cast_nullable_to_non_nullable
          : completedAt as DateTime?,
      orgId: orgId == const $CopyWithPlaceholder()
          ? _value.orgId
          // ignore: cast_nullable_to_non_nullable
          : orgId as String,
      recipeCoverage: recipeCoverage == const $CopyWithPlaceholder()
          ? _value.recipeCoverage
          // ignore: cast_nullable_to_non_nullable
          : recipeCoverage as double,
      steps: steps == const $CopyWithPlaceholder()
          ? _value.steps
          // ignore: cast_nullable_to_non_nullable
          : steps as List<OnboardingStep>,
    );
  }
}

extension $OnboardingStatusCopyWith on OnboardingStatus {
  /// Returns a callable class that can be used as follows: `instanceOfOnboardingStatus.copyWith(...)` or like so:`instanceOfOnboardingStatus.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OnboardingStatusCWProxy get copyWith => _$OnboardingStatusCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnboardingStatus _$OnboardingStatusFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'OnboardingStatus',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'can_complete',
            'completed',
            'org_id',
            'recipe_coverage',
            'steps',
          ],
        );
        final val = OnboardingStatus(
          canComplete: $checkedConvert('can_complete', (v) => v as bool),
          completed: $checkedConvert('completed', (v) => v as bool),
          completedAt: $checkedConvert(
            'completed_at',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          orgId: $checkedConvert('org_id', (v) => v as String),
          recipeCoverage: $checkedConvert(
            'recipe_coverage',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
          steps: $checkedConvert(
            'steps',
            (v) => (v as List<dynamic>)
                .map((e) => OnboardingStep.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'canComplete': 'can_complete',
        'completedAt': 'completed_at',
        'orgId': 'org_id',
        'recipeCoverage': 'recipe_coverage',
      },
    );

Map<String, dynamic> _$OnboardingStatusToJson(OnboardingStatus instance) =>
    <String, dynamic>{
      'can_complete': instance.canComplete,
      'completed': instance.completed,
      'completed_at': ?instance.completedAt?.toIso8601String(),
      'org_id': instance.orgId,
      'recipe_coverage': instance.recipeCoverage,
      'steps': instance.steps.map((e) => e.toJson()).toList(),
    };
