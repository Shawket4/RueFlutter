//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/user_public.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LoginResponse {
  /// Returns a new [LoginResponse] instance.
  LoginResponse({

    required  this.currencyCode,

    required  this.taxRate,

    required  this.token,

    required  this.user,
  });

  @JsonKey(
    
    name: r'currency_code',
    required: true,
    includeIfNull: false,
  )


  final String currencyCode;



      /// Org tax rate as a decimal (e.g. 0.14 = 14% VAT); 0.0 when no org. Mirrors /auth/me so the POS has it immediately after login.
  @JsonKey(
    
    name: r'tax_rate',
    required: true,
    includeIfNull: false,
  )


  final double taxRate;



      /// JWT to send as `Authorization: Bearer <token>` on subsequent requests.
  @JsonKey(
    
    name: r'token',
    required: true,
    includeIfNull: false,
  )


  final String token;



  @JsonKey(
    
    name: r'user',
    required: true,
    includeIfNull: false,
  )


  final UserPublic user;





    @override
    bool operator ==(Object other) => identical(this, other) || other is LoginResponse &&
      other.currencyCode == currencyCode &&
      other.taxRate == taxRate &&
      other.token == token &&
      other.user == user;

    @override
    int get hashCode =>
        currencyCode.hashCode +
        taxRate.hashCode +
        token.hashCode +
        user.hashCode;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

