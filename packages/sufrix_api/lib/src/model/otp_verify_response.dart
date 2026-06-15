//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_verify_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OtpVerifyResponse {
  /// Returns a new [OtpVerifyResponse] instance.
  OtpVerifyResponse({

    required  this.deviceToken,
  });

  @JsonKey(
    
    name: r'device_token',
    required: true,
    includeIfNull: false,
  )


  final String deviceToken;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OtpVerifyResponse &&
      other.deviceToken == deviceToken;

    @override
    int get hashCode =>
        deviceToken.hashCode;

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) => _$OtpVerifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerifyResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

