// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_branch.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PublicBranchCWProxy {
  PublicBranch code(String code);

  PublicBranch id(String id);

  PublicBranch inMallEnabled(bool inMallEnabled);

  PublicBranch inMallOpenNow(bool inMallOpenNow);

  PublicBranch name(String name);

  PublicBranch outsideEnabled(bool outsideEnabled);

  PublicBranch outsideOpenNow(bool outsideOpenNow);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PublicBranch(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PublicBranch(...).copyWith(id: 12, name: "My name")
  /// ````
  PublicBranch call({
    String code,
    String id,
    bool inMallEnabled,
    bool inMallOpenNow,
    String name,
    bool outsideEnabled,
    bool outsideOpenNow,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPublicBranch.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPublicBranch.copyWith.fieldName(...)`
class _$PublicBranchCWProxyImpl implements _$PublicBranchCWProxy {
  const _$PublicBranchCWProxyImpl(this._value);

  final PublicBranch _value;

  @override
  PublicBranch code(String code) => this(code: code);

  @override
  PublicBranch id(String id) => this(id: id);

  @override
  PublicBranch inMallEnabled(bool inMallEnabled) =>
      this(inMallEnabled: inMallEnabled);

  @override
  PublicBranch inMallOpenNow(bool inMallOpenNow) =>
      this(inMallOpenNow: inMallOpenNow);

  @override
  PublicBranch name(String name) => this(name: name);

  @override
  PublicBranch outsideEnabled(bool outsideEnabled) =>
      this(outsideEnabled: outsideEnabled);

  @override
  PublicBranch outsideOpenNow(bool outsideOpenNow) =>
      this(outsideOpenNow: outsideOpenNow);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PublicBranch(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PublicBranch(...).copyWith(id: 12, name: "My name")
  /// ````
  PublicBranch call({
    Object? code = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? inMallEnabled = const $CopyWithPlaceholder(),
    Object? inMallOpenNow = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? outsideEnabled = const $CopyWithPlaceholder(),
    Object? outsideOpenNow = const $CopyWithPlaceholder(),
  }) {
    return PublicBranch(
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      inMallEnabled: inMallEnabled == const $CopyWithPlaceholder()
          ? _value.inMallEnabled
          // ignore: cast_nullable_to_non_nullable
          : inMallEnabled as bool,
      inMallOpenNow: inMallOpenNow == const $CopyWithPlaceholder()
          ? _value.inMallOpenNow
          // ignore: cast_nullable_to_non_nullable
          : inMallOpenNow as bool,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      outsideEnabled: outsideEnabled == const $CopyWithPlaceholder()
          ? _value.outsideEnabled
          // ignore: cast_nullable_to_non_nullable
          : outsideEnabled as bool,
      outsideOpenNow: outsideOpenNow == const $CopyWithPlaceholder()
          ? _value.outsideOpenNow
          // ignore: cast_nullable_to_non_nullable
          : outsideOpenNow as bool,
    );
  }
}

extension $PublicBranchCopyWith on PublicBranch {
  /// Returns a callable class that can be used as follows: `instanceOfPublicBranch.copyWith(...)` or like so:`instanceOfPublicBranch.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PublicBranchCWProxy get copyWith => _$PublicBranchCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicBranch _$PublicBranchFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PublicBranch',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'code',
            'id',
            'in_mall_enabled',
            'in_mall_open_now',
            'name',
            'outside_enabled',
            'outside_open_now',
          ],
        );
        final val = PublicBranch(
          code: $checkedConvert('code', (v) => v as String),
          id: $checkedConvert('id', (v) => v as String),
          inMallEnabled: $checkedConvert('in_mall_enabled', (v) => v as bool),
          inMallOpenNow: $checkedConvert('in_mall_open_now', (v) => v as bool),
          name: $checkedConvert('name', (v) => v as String),
          outsideEnabled: $checkedConvert('outside_enabled', (v) => v as bool),
          outsideOpenNow: $checkedConvert('outside_open_now', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {
        'inMallEnabled': 'in_mall_enabled',
        'inMallOpenNow': 'in_mall_open_now',
        'outsideEnabled': 'outside_enabled',
        'outsideOpenNow': 'outside_open_now',
      },
    );

Map<String, dynamic> _$PublicBranchToJson(PublicBranch instance) =>
    <String, dynamic>{
      'code': instance.code,
      'id': instance.id,
      'in_mall_enabled': instance.inMallEnabled,
      'in_mall_open_now': instance.inMallOpenNow,
      'name': instance.name,
      'outside_enabled': instance.outsideEnabled,
      'outside_open_now': instance.outsideOpenNow,
    };
