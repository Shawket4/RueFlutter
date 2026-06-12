//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upsert_role_permission_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpsertRolePermissionRequest {
  /// Returns a new [UpsertRolePermissionRequest] instance.
  UpsertRolePermissionRequest({

    required  this.action,

    required  this.granted,

    required  this.resource,

    required  this.role,
  });

  @JsonKey(
    
    name: r'action',
    required: true,
    includeIfNull: false,
  )


  final String action;



  @JsonKey(
    
    name: r'granted',
    required: true,
    includeIfNull: false,
  )


  final bool granted;



  @JsonKey(
    
    name: r'resource',
    required: true,
    includeIfNull: false,
  )


  final String resource;



  @JsonKey(
    
    name: r'role',
    required: true,
    includeIfNull: false,
  )


  final String role;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpsertRolePermissionRequest &&
      other.action == action &&
      other.granted == granted &&
      other.resource == resource &&
      other.role == role;

    @override
    int get hashCode =>
        action.hashCode +
        granted.hashCode +
        resource.hashCode +
        role.hashCode;

  factory UpsertRolePermissionRequest.fromJson(Map<String, dynamic> json) => _$UpsertRolePermissionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpsertRolePermissionRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

