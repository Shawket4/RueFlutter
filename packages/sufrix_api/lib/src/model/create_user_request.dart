//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/user_role.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_user_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateUserRequest {
  /// Returns a new [CreateUserRequest] instance.
  CreateUserRequest({

     this.branchIds,

     this.email,

    required  this.name,

    required  this.orgId,

     this.password,

     this.phone,

     this.pin,

    required  this.role,
  });

      /// Branches to assign the new user to immediately. Branch managers can only assign to branches they themselves are assigned to.
  @JsonKey(
    
    name: r'branch_ids',
    required: false,
    includeIfNull: false,
  )


  final List<String>? branchIds;



      /// Required for admins and managers; ignored for tellers.
  @JsonKey(
    
    name: r'email',
    required: false,
    includeIfNull: false,
  )


  final String? email;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'org_id',
    required: true,
    includeIfNull: false,
  )


  final String orgId;



      /// Required when `role` is anything other than `teller`. Plain text; hashed server-side with bcrypt before storage.
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



      /// Required when `role = teller`. 4–6 ASCII digits.
  @JsonKey(
    
    name: r'pin',
    required: false,
    includeIfNull: false,
  )


  final String? pin;



  @JsonKey(
    
    name: r'role',
    required: true,
    includeIfNull: false,
  unknownEnumValue: UserRole.unknownDefaultOpenApi,
  )


  final UserRole role;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateUserRequest &&
      other.branchIds == branchIds &&
      other.email == email &&
      other.name == name &&
      other.orgId == orgId &&
      other.password == password &&
      other.phone == phone &&
      other.pin == pin &&
      other.role == role;

    @override
    int get hashCode =>
        (branchIds == null ? 0 : branchIds.hashCode) +
        (email == null ? 0 : email.hashCode) +
        name.hashCode +
        orgId.hashCode +
        (password == null ? 0 : password.hashCode) +
        (phone == null ? 0 : phone.hashCode) +
        (pin == null ? 0 : pin.hashCode) +
        role.hashCode;

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) => _$CreateUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

