// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_transfer_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateTransferRequestCWProxy {
  UpdateTransferRequest note(String? note);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateTransferRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateTransferRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateTransferRequest call({String? note});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateTransferRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateTransferRequest.copyWith.fieldName(...)`
class _$UpdateTransferRequestCWProxyImpl
    implements _$UpdateTransferRequestCWProxy {
  const _$UpdateTransferRequestCWProxyImpl(this._value);

  final UpdateTransferRequest _value;

  @override
  UpdateTransferRequest note(String? note) => this(note: note);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateTransferRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateTransferRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateTransferRequest call({Object? note = const $CopyWithPlaceholder()}) {
    return UpdateTransferRequest(
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
    );
  }
}

extension $UpdateTransferRequestCopyWith on UpdateTransferRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateTransferRequest.copyWith(...)` or like so:`instanceOfUpdateTransferRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateTransferRequestCWProxy get copyWith =>
      _$UpdateTransferRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTransferRequest _$UpdateTransferRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('UpdateTransferRequest', json, ($checkedConvert) {
  final val = UpdateTransferRequest(
    note: $checkedConvert('note', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$UpdateTransferRequestToJson(
  UpdateTransferRequest instance,
) => <String, dynamic>{'note': ?instance.note};
