//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_request_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OtpRequestResponse {
  /// Returns a new [OtpRequestResponse] instance.
  OtpRequestResponse({

    required  this.sent,
  });

  @JsonKey(
    
    name: r'sent',
    required: true,
    includeIfNull: false,
  )


  final bool sent;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OtpRequestResponse &&
      other.sent == sent;

    @override
    int get hashCode =>
        sent.hashCode;

  factory OtpRequestResponse.fromJson(Map<String, dynamic> json) => _$OtpRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OtpRequestResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

