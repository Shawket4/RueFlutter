//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_split_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PaymentSplitInput {
  /// Returns a new [PaymentSplitInput] instance.
  PaymentSplitInput({

    required  this.amount,

    required  this.method,

     this.reference,
  });

  @JsonKey(
    
    name: r'amount',
    required: true,
    includeIfNull: false,
  )


  final int amount;



  @JsonKey(
    
    name: r'method',
    required: true,
    includeIfNull: false,
  )


  final String method;



  @JsonKey(
    
    name: r'reference',
    required: false,
    includeIfNull: false,
  )


  final String? reference;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PaymentSplitInput &&
      other.amount == amount &&
      other.method == method &&
      other.reference == reference;

    @override
    int get hashCode =>
        amount.hashCode +
        method.hashCode +
        (reference == null ? 0 : reference.hashCode);

  factory PaymentSplitInput.fromJson(Map<String, dynamic> json) => _$PaymentSplitInputFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentSplitInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

