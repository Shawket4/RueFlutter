//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_request_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OtpRequestInput {
  /// Returns a new [OtpRequestInput] instance.
  OtpRequestInput({

    required  this.phone,
  });

  @JsonKey(
    
    name: r'phone',
    required: true,
    includeIfNull: false,
  )


  final String phone;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OtpRequestInput &&
      other.phone == phone;

    @override
    int get hashCode =>
        phone.hashCode;

  factory OtpRequestInput.fromJson(Map<String, dynamic> json) => _$OtpRequestInputFromJson(json);

  Map<String, dynamic> toJson() => _$OtpRequestInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

