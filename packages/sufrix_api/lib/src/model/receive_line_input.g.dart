// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receive_line_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReceiveLineInputCWProxy {
  ReceiveLineInput lineId(String lineId);

  ReceiveLineInput quantityReceived(double quantityReceived);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReceiveLineInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReceiveLineInput(...).copyWith(id: 12, name: "My name")
  /// ````
  ReceiveLineInput call({String lineId, double quantityReceived});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReceiveLineInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReceiveLineInput.copyWith.fieldName(...)`
class _$ReceiveLineInputCWProxyImpl implements _$ReceiveLineInputCWProxy {
  const _$ReceiveLineInputCWProxyImpl(this._value);

  final ReceiveLineInput _value;

  @override
  ReceiveLineInput lineId(String lineId) => this(lineId: lineId);

  @override
  ReceiveLineInput quantityReceived(double quantityReceived) =>
      this(quantityReceived: quantityReceived);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReceiveLineInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReceiveLineInput(...).copyWith(id: 12, name: "My name")
  /// ````
  ReceiveLineInput call({
    Object? lineId = const $CopyWithPlaceholder(),
    Object? quantityReceived = const $CopyWithPlaceholder(),
  }) {
    return ReceiveLineInput(
      lineId: lineId == const $CopyWithPlaceholder()
          ? _value.lineId
          // ignore: cast_nullable_to_non_nullable
          : lineId as String,
      quantityReceived: quantityReceived == const $CopyWithPlaceholder()
          ? _value.quantityReceived
          // ignore: cast_nullable_to_non_nullable
          : quantityReceived as double,
    );
  }
}

extension $ReceiveLineInputCopyWith on ReceiveLineInput {
  /// Returns a callable class that can be used as follows: `instanceOfReceiveLineInput.copyWith(...)` or like so:`instanceOfReceiveLineInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReceiveLineInputCWProxy get copyWith => _$ReceiveLineInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiveLineInput _$ReceiveLineInputFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ReceiveLineInput',
      json,
      ($checkedConvert) {
        $checkKeys(json, requiredKeys: const ['line_id', 'quantity_received']);
        final val = ReceiveLineInput(
          lineId: $checkedConvert('line_id', (v) => v as String),
          quantityReceived: $checkedConvert(
            'quantity_received',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'lineId': 'line_id',
        'quantityReceived': 'quantity_received',
      },
    );

Map<String, dynamic> _$ReceiveLineInputToJson(ReceiveLineInput instance) =>
    <String, dynamic>{
      'line_id': instance.lineId,
      'quantity_received': instance.quantityReceived,
    };
