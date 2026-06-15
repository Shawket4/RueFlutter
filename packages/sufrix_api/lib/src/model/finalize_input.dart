//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'finalize_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class FinalizeInput {
  /// Returns a new [FinalizeInput] instance.
  FinalizeInput({

    required  this.paymentMethod,

    required  this.shiftId,
  });

      /// The actual method the customer paid (overrides the hint). Must be an org method.
  @JsonKey(
    
    name: r'payment_method',
    required: true,
    includeIfNull: false,
  )


  final String paymentMethod;



  @JsonKey(
    
    name: r'shift_id',
    required: true,
    includeIfNull: false,
  )


  final String shiftId;





    @override
    bool operator ==(Object other) => identical(this, other) || other is FinalizeInput &&
      other.paymentMethod == paymentMethod &&
      other.shiftId == shiftId;

    @override
    int get hashCode =>
        paymentMethod.hashCode +
        shiftId.hashCode;

  factory FinalizeInput.fromJson(Map<String, dynamic> json) => _$FinalizeInputFromJson(json);

  Map<String, dynamic> toJson() => _$FinalizeInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

