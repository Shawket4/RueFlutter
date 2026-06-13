// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_run_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateRunResponseCWProxy {
  CreateRunResponse runId(String runId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateRunResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateRunResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateRunResponse call({String runId});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateRunResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateRunResponse.copyWith.fieldName(...)`
class _$CreateRunResponseCWProxyImpl implements _$CreateRunResponseCWProxy {
  const _$CreateRunResponseCWProxyImpl(this._value);

  final CreateRunResponse _value;

  @override
  CreateRunResponse runId(String runId) => this(runId: runId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateRunResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateRunResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateRunResponse call({Object? runId = const $CopyWithPlaceholder()}) {
    return CreateRunResponse(
      runId: runId == const $CopyWithPlaceholder()
          ? _value.runId
          // ignore: cast_nullable_to_non_nullable
          : runId as String,
    );
  }
}

extension $CreateRunResponseCopyWith on CreateRunResponse {
  /// Returns a callable class that can be used as follows: `instanceOfCreateRunResponse.copyWith(...)` or like so:`instanceOfCreateRunResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateRunResponseCWProxy get copyWith =>
      _$CreateRunResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRunResponse _$CreateRunResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CreateRunResponse', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['run_id']);
      final val = CreateRunResponse(
        runId: $checkedConvert('run_id', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'runId': 'run_id'});

Map<String, dynamic> _$CreateRunResponseToJson(CreateRunResponse instance) =>
    <String, dynamic>{'run_id': instance.runId};
