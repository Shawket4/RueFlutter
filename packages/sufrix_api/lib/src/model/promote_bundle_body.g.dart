// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promote_bundle_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PromoteBundleBodyCWProxy {
  PromoteBundleBody bundleId(String bundleId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PromoteBundleBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PromoteBundleBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PromoteBundleBody call({String bundleId});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPromoteBundleBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPromoteBundleBody.copyWith.fieldName(...)`
class _$PromoteBundleBodyCWProxyImpl implements _$PromoteBundleBodyCWProxy {
  const _$PromoteBundleBodyCWProxyImpl(this._value);

  final PromoteBundleBody _value;

  @override
  PromoteBundleBody bundleId(String bundleId) => this(bundleId: bundleId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PromoteBundleBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PromoteBundleBody(...).copyWith(id: 12, name: "My name")
  /// ````
  PromoteBundleBody call({Object? bundleId = const $CopyWithPlaceholder()}) {
    return PromoteBundleBody(
      bundleId: bundleId == const $CopyWithPlaceholder()
          ? _value.bundleId
          // ignore: cast_nullable_to_non_nullable
          : bundleId as String,
    );
  }
}

extension $PromoteBundleBodyCopyWith on PromoteBundleBody {
  /// Returns a callable class that can be used as follows: `instanceOfPromoteBundleBody.copyWith(...)` or like so:`instanceOfPromoteBundleBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PromoteBundleBodyCWProxy get copyWith =>
      _$PromoteBundleBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoteBundleBody _$PromoteBundleBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PromoteBundleBody', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['bundle_id']);
      final val = PromoteBundleBody(
        bundleId: $checkedConvert('bundle_id', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'bundleId': 'bundle_id'});

Map<String, dynamic> _$PromoteBundleBodyToJson(PromoteBundleBody instance) =>
    <String, dynamic>{'bundle_id': instance.bundleId};
