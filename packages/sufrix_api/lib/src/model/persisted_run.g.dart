// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persisted_run.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PersistedRunCWProxy {
  PersistedRun branchId(String branchId);

  PersistedRun completedAt(DateTime? completedAt);

  PersistedRun config(AnalysisConfig config);

  PersistedRun errorMessage(String? errorMessage);

  PersistedRun id(String id);

  PersistedRun modeSummary(ModeSummary modeSummary);

  PersistedRun orgId(String orgId);

  PersistedRun startedAt(DateTime startedAt);

  PersistedRun status(RunStatus status);

  PersistedRun windowDays(double windowDays);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PersistedRun(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PersistedRun(...).copyWith(id: 12, name: "My name")
  /// ````
  PersistedRun call({
    String branchId,
    DateTime? completedAt,
    AnalysisConfig config,
    String? errorMessage,
    String id,
    ModeSummary modeSummary,
    String orgId,
    DateTime startedAt,
    RunStatus status,
    double windowDays,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPersistedRun.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPersistedRun.copyWith.fieldName(...)`
class _$PersistedRunCWProxyImpl implements _$PersistedRunCWProxy {
  const _$PersistedRunCWProxyImpl(this._value);

  final PersistedRun _value;

  @override
  PersistedRun branchId(String branchId) => this(branchId: branchId);

  @override
  PersistedRun completedAt(DateTime? completedAt) =>
      this(completedAt: completedAt);

  @override
  PersistedRun config(AnalysisConfig config) => this(config: config);

  @override
  PersistedRun errorMessage(String? errorMessage) =>
      this(errorMessage: errorMessage);

  @override
  PersistedRun id(String id) => this(id: id);

  @override
  PersistedRun modeSummary(ModeSummary modeSummary) =>
      this(modeSummary: modeSummary);

  @override
  PersistedRun orgId(String orgId) => this(orgId: orgId);

  @override
  PersistedRun startedAt(DateTime startedAt) => this(startedAt: startedAt);

  @override
  PersistedRun status(RunStatus status) => this(status: status);

  @override
  PersistedRun windowDays(double windowDays) => this(windowDays: windowDays);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PersistedRun(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PersistedRun(...).copyWith(id: 12, name: "My name")
  /// ````
  PersistedRun call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? completedAt = const $CopyWithPlaceholder(),
    Object? config = const $CopyWithPlaceholder(),
    Object? errorMessage = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? modeSummary = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
    Object? startedAt = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? windowDays = const $CopyWithPlaceholder(),
  }) {
    return PersistedRun(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      completedAt: completedAt == const $CopyWithPlaceholder()
          ? _value.completedAt
          // ignore: cast_nullable_to_non_nullable
          : completedAt as DateTime?,
      config: config == const $CopyWithPlaceholder()
          ? _value.config
          // ignore: cast_nullable_to_non_nullable
          : config as AnalysisConfig,
      errorMessage: errorMessage == const $CopyWithPlaceholder()
          ? _value.errorMessage
          // ignore: cast_nullable_to_non_nullable
          : errorMessage as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      modeSummary: modeSummary == const $CopyWithPlaceholder()
          ? _value.modeSummary
          // ignore: cast_nullable_to_non_nullable
          : modeSummary as ModeSummary,
      orgId: orgId == const $CopyWithPlaceholder()
          ? _value.orgId
          // ignore: cast_nullable_to_non_nullable
          : orgId as String,
      startedAt: startedAt == const $CopyWithPlaceholder()
          ? _value.startedAt
          // ignore: cast_nullable_to_non_nullable
          : startedAt as DateTime,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as RunStatus,
      windowDays: windowDays == const $CopyWithPlaceholder()
          ? _value.windowDays
          // ignore: cast_nullable_to_non_nullable
          : windowDays as double,
    );
  }
}

extension $PersistedRunCopyWith on PersistedRun {
  /// Returns a callable class that can be used as follows: `instanceOfPersistedRun.copyWith(...)` or like so:`instanceOfPersistedRun.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PersistedRunCWProxy get copyWith => _$PersistedRunCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersistedRun _$PersistedRunFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PersistedRun',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'branch_id',
            'config',
            'id',
            'mode_summary',
            'org_id',
            'started_at',
            'status',
            'window_days',
          ],
        );
        final val = PersistedRun(
          branchId: $checkedConvert('branch_id', (v) => v as String),
          completedAt: $checkedConvert(
            'completed_at',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          config: $checkedConvert(
            'config',
            (v) => AnalysisConfig.fromJson(v as Map<String, dynamic>),
          ),
          errorMessage: $checkedConvert('error_message', (v) => v as String?),
          id: $checkedConvert('id', (v) => v as String),
          modeSummary: $checkedConvert(
            'mode_summary',
            (v) => ModeSummary.fromJson(v as Map<String, dynamic>),
          ),
          orgId: $checkedConvert('org_id', (v) => v as String),
          startedAt: $checkedConvert(
            'started_at',
            (v) => DateTime.parse(v as String),
          ),
          status: $checkedConvert(
            'status',
            (v) => $enumDecode(
              _$RunStatusEnumMap,
              v,
              unknownValue: RunStatus.unknownDefaultOpenApi,
            ),
          ),
          windowDays: $checkedConvert(
            'window_days',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'branchId': 'branch_id',
        'completedAt': 'completed_at',
        'errorMessage': 'error_message',
        'modeSummary': 'mode_summary',
        'orgId': 'org_id',
        'startedAt': 'started_at',
        'windowDays': 'window_days',
      },
    );

Map<String, dynamic> _$PersistedRunToJson(PersistedRun instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'completed_at': ?instance.completedAt?.toIso8601String(),
      'config': instance.config.toJson(),
      'error_message': ?instance.errorMessage,
      'id': instance.id,
      'mode_summary': instance.modeSummary.toJson(),
      'org_id': instance.orgId,
      'started_at': instance.startedAt.toIso8601String(),
      'status': _$RunStatusEnumMap[instance.status]!,
      'window_days': instance.windowDays,
    };

const _$RunStatusEnumMap = {
  RunStatus.inProgress: 'in_progress',
  RunStatus.completed: 'completed',
  RunStatus.failed: 'failed',
  RunStatus.unknownDefaultOpenApi: 'unknown_default_open_api',
};
