//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/user_role.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_public.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserPublic {
  /// Returns a new [UserPublic] instance.
  UserPublic({

     this.branchId,

     this.email,

    required  this.id,

    required  this.isActive,

    required  this.name,

     this.orgId,

     this.phone,

    required  this.role,
  });

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



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'is_active',
    required: true,
    includeIfNull: false,
  )


  final bool isActive;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'org_id',
    required: false,
    includeIfNull: false,
  )


  final String? orgId;



  @JsonKey(
    
    name: r'phone',
    required: false,
    includeIfNull: false,
  )


  final String? phone;



  @JsonKey(
    
    name: r'role',
    required: true,
    includeIfNull: false,
  unknownEnumValue: UserRole.unknownDefaultOpenApi,
  )


  final UserRole role;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UserPublic &&
      other.branchId == branchId &&
      other.email == email &&
      other.id == id &&
      other.isActive == isActive &&
      other.name == name &&
      other.orgId == orgId &&
      other.phone == phone &&
      other.role == role;

    @override
    int get hashCode =>
        (branchId == null ? 0 : branchId.hashCode) +
        (email == null ? 0 : email.hashCode) +
        id.hashCode +
        isActive.hashCode +
        name.hashCode +
        (orgId == null ? 0 : orgId.hashCode) +
        (phone == null ? 0 : phone.hashCode) +
        role.hashCode;

  factory UserPublic.fromJson(Map<String, dynamic> json) => _$UserPublicFromJson(json);

  Map<String, dynamic> toJson() => _$UserPublicToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

