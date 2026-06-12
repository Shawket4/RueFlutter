// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_shift_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OpenShiftRequestCWProxy {
  OpenShiftRequest editReason(String? editReason);

  OpenShiftRequest id(String? id);

  OpenShiftRequest openedAt(DateTime? openedAt);

  OpenShiftRequest openingCash(int openingCash);

  OpenShiftRequest openingCashEdited(bool? openingCashEdited);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OpenShiftRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OpenShiftRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  OpenShiftRequest call({
    String? editReason,
    String? id,
    DateTime? openedAt,
    int openingCash,
    bool? openingCashEdited,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOpenShiftRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOpenShiftRequest.copyWith.fieldName(...)`
class _$OpenShiftRequestCWProxyImpl implements _$OpenShiftRequestCWProxy {
  const _$OpenShiftRequestCWProxyImpl(this._value);

  final OpenShiftRequest _value;

  @override
  OpenShiftRequest editReason(String? editReason) =>
      this(editReason: editReason);

  @override
  OpenShiftRequest id(String? id) => this(id: id);

  @override
  OpenShiftRequest openedAt(DateTime? openedAt) => this(openedAt: openedAt);

  @override
  OpenShiftRequest openingCash(int openingCash) =>
      this(openingCash: openingCash);

  @override
  OpenShiftRequest openingCashEdited(bool? openingCashEdited) =>
      this(openingCashEdited: openingCashEdited);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OpenShiftRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OpenShiftRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  OpenShiftRequest call({
    Object? editReason = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? openedAt = const $CopyWithPlaceholder(),
    Object? openingCash = const $CopyWithPlaceholder(),
    Object? openingCashEdited = const $CopyWithPlaceholder(),
  }) {
    return OpenShiftRequest(
      editReason: editReason == const $CopyWithPlaceholder()
          ? _value.editReason
          // ignore: cast_nullable_to_non_nullable
          : editReason as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      openedAt: openedAt == const $CopyWithPlaceholder()
          ? _value.openedAt
          // ignore: cast_nullable_to_non_nullable
          : openedAt as DateTime?,
      openingCash: openingCash == const $CopyWithPlaceholder()
          ? _value.openingCash
          // ignore: cast_nullable_to_non_nullable
          : openingCash as int,
      openingCashEdited: openingCashEdited == const $CopyWithPlaceholder()
          ? _value.openingCashEdited
          // ignore: cast_nullable_to_non_nullable
          : openingCashEdited as bool?,
    );
  }
}

extension $OpenShiftRequestCopyWith on OpenShiftRequest {
  /// Returns a callable class that can be used as follows: `instanceOfOpenShiftRequest.copyWith(...)` or like so:`instanceOfOpenShiftRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$OpenShiftRequestCWProxy get copyWith => _$OpenShiftRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenShiftRequest _$OpenShiftRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'OpenShiftRequest',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['opening_cash']);
        final val = OpenShiftRequest(
          editReason: $checkedConvert('edit_reason', (v) => v as String?),
          id: $checkedConvert('id', (v) => v as String?),
          openedAt: $checkedConvert(
            'opened_at',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          openingCash: $checkedConvert(
            'opening_cash',
            (v) => (v as num).toInt(),
          ),
          openingCashEdited: $checkedConvert(
            'opening_cash_edited',
            (v) => v as bool?,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'editReason': 'edit_reason',
        'openedAt': 'opened_at',
        'openingCash': 'opening_cash',
        'openingCashEdited': 'opening_cash_edited',
      },
    );

Map<String, dynamic> _$OpenShiftRequestToJson(OpenShiftRequest instance) =>
    <String, dynamic>{
      'edit_reason': ?instance.editReason,
      'id': ?instance.id,
      'opened_at': ?instance.openedAt?.toIso8601String(),
      'opening_cash': instance.openingCash,
      'opening_cash_edited': ?instance.openingCashEdited,
    };
