// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_run_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateRunBodyCWProxy {
  CreateRunBody config(AnalysisConfig? config);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateRunBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateRunBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateRunBody call({AnalysisConfig? config});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateRunBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateRunBody.copyWith.fieldName(...)`
class _$CreateRunBodyCWProxyImpl implements _$CreateRunBodyCWProxy {
  const _$CreateRunBodyCWProxyImpl(this._value);

  final CreateRunBody _value;

  @override
  CreateRunBody config(AnalysisConfig? config) => this(config: config);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateRunBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateRunBody(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateRunBody call({Object? config = const $CopyWithPlaceholder()}) {
    return CreateRunBody(
      config: config == const $CopyWithPlaceholder()
          ? _value.config
          // ignore: cast_nullable_to_non_nullable
          : config as AnalysisConfig?,
    );
  }
}

extension $CreateRunBodyCopyWith on CreateRunBody {
  /// Returns a callable class that can be used as follows: `instanceOfCreateRunBody.copyWith(...)` or like so:`instanceOfCreateRunBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateRunBodyCWProxy get copyWith => _$CreateRunBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRunBody _$CreateRunBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CreateRunBody', json, ($checkedConvert) {
      final val = CreateRunBody(
        config: $checkedConvert(
          'config',
          (v) => v == null
              ? null
              : AnalysisConfig.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CreateRunBodyToJson(CreateRunBody instance) =>
    <String, dynamic>{'config': ?instance.config?.toJson()};
