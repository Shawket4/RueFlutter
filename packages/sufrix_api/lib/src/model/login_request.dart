//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LoginRequest {
  /// Returns a new [LoginRequest] instance.
  LoginRequest({

     this.branchId,

     this.email,

     this.name,

     this.orgId,

     this.password,

     this.pin,
  });

      /// Required for PIN login. The org is derived from this branch server-side.
  @JsonKey(
    
    name: r'branch_id',
    required: false,
    includeIfNull: false,
  )


  final String? branchId;



  @JsonKey(
    
    name: r'email',
    required: false,
    includeIfNull: false,
  )


  final String? email;



      /// Teller's display name (required for PIN login, unused otherwise).
  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'org_id',
    required: false,
    includeIfNull: false,
  )


  final String? orgId;



  @JsonKey(
    
    name: r'password',
    required: false,
    includeIfNull: false,
  )


  final String? password;



  @JsonKey(
    
    name: r'pin',
    required: false,
    includeIfNull: false,
  )


  final String? pin;





    @override
    bool operator ==(Object other) => identical(this, other) || other is LoginRequest &&
      other.branchId == branchId &&
      other.email == email &&
      other.name == name &&
      other.orgId == orgId &&
      other.password == password &&
      other.pin == pin;

    @override
    int get hashCode =>
        (branchId == null ? 0 : branchId.hashCode) +
        (email == null ? 0 : email.hashCode) +
        (name == null ? 0 : name.hashCode) +
        (orgId == null ? 0 : orgId.hashCode) +
        (password == null ? 0 : password.hashCode) +
        (pin == null ? 0 : pin.hashCode);

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

