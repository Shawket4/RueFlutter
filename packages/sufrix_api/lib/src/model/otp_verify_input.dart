//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_verify_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OtpVerifyInput {
  /// Returns a new [OtpVerifyInput] instance.
  OtpVerifyInput({

    required  this.code,

    required  this.phone,
  });

  @JsonKey(
    
    name: r'code',
    required: true,
    includeIfNull: false,
  )


  final String code;



  @JsonKey(
    
    name: r'phone',
    required: true,
    includeIfNull: false,
  )


  final String phone;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OtpVerifyInput &&
      other.code == code &&
      other.phone == phone;

    @override
    int get hashCode =>
        code.hashCode +
        phone.hashCode;

  factory OtpVerifyInput.fromJson(Map<String, dynamic> json) => _$OtpVerifyInputFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerifyInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

