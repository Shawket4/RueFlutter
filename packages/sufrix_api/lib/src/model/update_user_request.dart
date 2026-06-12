//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/user_role.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_user_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateUserRequest {
  /// Returns a new [UpdateUserRequest] instance.
  UpdateUserRequest({

     this.email,

     this.isActive,

     this.name,

     this.password,

     this.phone,

     this.pin,

     this.role,
  });

  @JsonKey(
    
    name: r'email',
    required: false,
    includeIfNull: false,
  )


  final String? email;



  @JsonKey(
    
    name: r'is_active',
    required: false,
    includeIfNull: false,
  )


  final bool? isActive;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



      /// Plain-text new password. Server-side bcrypt-hashed.
  @JsonKey(
    
    name: r'password',
    required: false,
    includeIfNull: false,
  )


  final String? password;



  @JsonKey(
    
    name: r'phone',
    required: false,
    includeIfNull: false,
  )


  final String? phone;



  @JsonKey(
    
    name: r'pin',
    required: false,
    includeIfNull: false,
  )


  final String? pin;



      /// Only org-admins and above can change roles. Promoting to `super_admin` requires the caller to be a super-admin.
  @JsonKey(
    
    name: r'role',
    required: false,
    includeIfNull: false,
  unknownEnumValue: UserRole.unknownDefaultOpenApi,
  )


  final UserRole? role;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpdateUserRequest &&
      other.email == email &&
      other.isActive == isActive &&
      other.name == name &&
      other.password == password &&
      other.phone == phone &&
      other.pin == pin &&
      other.role == role;

    @override
    int get hashCode =>
        (email == null ? 0 : email.hashCode) +
        (isActive == null ? 0 : isActive.hashCode) +
        (name == null ? 0 : name.hashCode) +
        (password == null ? 0 : password.hashCode) +
        (phone == null ? 0 : phone.hashCode) +
        (pin == null ? 0 : pin.hashCode) +
        (role == null ? 0 : role.hashCode);

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) => _$UpdateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

