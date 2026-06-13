// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_stocktake_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateStocktakeRequestCWProxy {
  CreateStocktakeRequest note(String? note);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateStocktakeRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateStocktakeRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateStocktakeRequest call({String? note});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateStocktakeRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateStocktakeRequest.copyWith.fieldName(...)`
class _$CreateStocktakeRequestCWProxyImpl
    implements _$CreateStocktakeRequestCWProxy {
  const _$CreateStocktakeRequestCWProxyImpl(this._value);

  final CreateStocktakeRequest _value;

  @override
  CreateStocktakeRequest note(String? note) => this(note: note);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateStocktakeRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateStocktakeRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateStocktakeRequest call({Object? note = const $CopyWithPlaceholder()}) {
    return CreateStocktakeRequest(
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
    );
  }
}

extension $CreateStocktakeRequestCopyWith on CreateStocktakeRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreateStocktakeRequest.copyWith(...)` or like so:`instanceOfCreateStocktakeRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateStocktakeRequestCWProxy get copyWith =>
      _$CreateStocktakeRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateStocktakeRequest _$CreateStocktakeRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('CreateStocktakeRequest', json, ($checkedConvert) {
  final val = CreateStocktakeRequest(
    note: $checkedConvert('note', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$CreateStocktakeRequestToJson(
  CreateStocktakeRequest instance,
) => <String, dynamic>{'note': ?instance.note};
