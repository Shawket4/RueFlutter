// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_split_input.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PaymentSplitInputCWProxy {
  PaymentSplitInput amount(int amount);

  PaymentSplitInput method(String method);

  PaymentSplitInput reference(String? reference);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaymentSplitInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaymentSplitInput(...).copyWith(id: 12, name: "My name")
  /// ````
  PaymentSplitInput call({int amount, String method, String? reference});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPaymentSplitInput.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPaymentSplitInput.copyWith.fieldName(...)`
class _$PaymentSplitInputCWProxyImpl implements _$PaymentSplitInputCWProxy {
  const _$PaymentSplitInputCWProxyImpl(this._value);

  final PaymentSplitInput _value;

  @override
  PaymentSplitInput amount(int amount) => this(amount: amount);

  @override
  PaymentSplitInput method(String method) => this(method: method);

  @override
  PaymentSplitInput reference(String? reference) => this(reference: reference);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PaymentSplitInput(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PaymentSplitInput(...).copyWith(id: 12, name: "My name")
  /// ````
  PaymentSplitInput call({
    Object? amount = const $CopyWithPlaceholder(),
    Object? method = const $CopyWithPlaceholder(),
    Object? reference = const $CopyWithPlaceholder(),
  }) {
    return PaymentSplitInput(
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as int,
      method: method == const $CopyWithPlaceholder()
          ? _value.method
          // ignore: cast_nullable_to_non_nullable
          : method as String,
      reference: reference == const $CopyWithPlaceholder()
          ? _value.reference
          // ignore: cast_nullable_to_non_nullable
          : reference as String?,
    );
  }
}

extension $PaymentSplitInputCopyWith on PaymentSplitInput {
  /// Returns a callable class that can be used as follows: `instanceOfPaymentSplitInput.copyWith(...)` or like so:`instanceOfPaymentSplitInput.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PaymentSplitInputCWProxy get copyWith =>
      _$PaymentSplitInputCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentSplitInput _$PaymentSplitInputFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PaymentSplitInput', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['amount', 'method']);
      final val = PaymentSplitInput(
        amount: $checkedConvert('amount', (v) => (v as num).toInt()),
        method: $checkedConvert('method', (v) => v as String),
        reference: $checkedConvert('reference', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$PaymentSplitInputToJson(PaymentSplitInput instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'method': instance.method,
      'reference': ?instance.reference,
    };
