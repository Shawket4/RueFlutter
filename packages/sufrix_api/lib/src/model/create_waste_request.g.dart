// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_waste_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CreateWasteRequestCWProxy {
  CreateWasteRequest note(String? note);

  CreateWasteRequest orgIngredientId(String orgIngredientId);

  CreateWasteRequest quantity(double quantity);

  CreateWasteRequest reason(String reason);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateWasteRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateWasteRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateWasteRequest call({
    String? note,
    String orgIngredientId,
    double quantity,
    String reason,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCreateWasteRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCreateWasteRequest.copyWith.fieldName(...)`
class _$CreateWasteRequestCWProxyImpl implements _$CreateWasteRequestCWProxy {
  const _$CreateWasteRequestCWProxyImpl(this._value);

  final CreateWasteRequest _value;

  @override
  CreateWasteRequest note(String? note) => this(note: note);

  @override
  CreateWasteRequest orgIngredientId(String orgIngredientId) =>
      this(orgIngredientId: orgIngredientId);

  @override
  CreateWasteRequest quantity(double quantity) => this(quantity: quantity);

  @override
  CreateWasteRequest reason(String reason) => this(reason: reason);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CreateWasteRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CreateWasteRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  CreateWasteRequest call({
    Object? note = const $CopyWithPlaceholder(),
    Object? orgIngredientId = const $CopyWithPlaceholder(),
    Object? quantity = const $CopyWithPlaceholder(),
    Object? reason = const $CopyWithPlaceholder(),
  }) {
    return CreateWasteRequest(
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      orgIngredientId: orgIngredientId == const $CopyWithPlaceholder()
          ? _value.orgIngredientId
          // ignore: cast_nullable_to_non_nullable
          : orgIngredientId as String,
      quantity: quantity == const $CopyWithPlaceholder()
          ? _value.quantity
          // ignore: cast_nullable_to_non_nullable
          : quantity as double,
      reason: reason == const $CopyWithPlaceholder()
          ? _value.reason
          // ignore: cast_nullable_to_non_nullable
          : reason as String,
    );
  }
}

extension $CreateWasteRequestCopyWith on CreateWasteRequest {
  /// Returns a callable class that can be used as follows: `instanceOfCreateWasteRequest.copyWith(...)` or like so:`instanceOfCreateWasteRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CreateWasteRequestCWProxy get copyWith =>
      _$CreateWasteRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateWasteRequest _$CreateWasteRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CreateWasteRequest',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['org_ingredient_id', 'quantity', 'reason'],
        );
        final val = CreateWasteRequest(
          note: $checkedConvert('note', (v) => v as String?),
          orgIngredientId: $checkedConvert(
            'org_ingredient_id',
            (v) => v as String,
          ),
          quantity: $checkedConvert('quantity', (v) => (v is String ? double.parse(v) : (v as num).toDouble())),
          reason: $checkedConvert('reason', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'orgIngredientId': 'org_ingredient_id'},
    );

Map<String, dynamic> _$CreateWasteRequestToJson(CreateWasteRequest instance) =>
    <String, dynamic>{
      'note': ?instance.note,
      'org_ingredient_id': instance.orgIngredientId,
      'quantity': instance.quantity,
      'reason': instance.reason,
    };
