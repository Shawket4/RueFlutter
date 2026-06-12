//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/user_permission_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_permissions_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthPermissionsResponse {
  /// Returns a new [AuthPermissionsResponse] instance.
  AuthPermissionsResponse({

    required  this.permissions,
  });

  @JsonKey(
    
    name: r'permissions',
    required: true,
    includeIfNull: false,
  )


  final List<UserPermissionItem> permissions;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AuthPermissionsResponse &&
      other.permissions == permissions;

    @override
    int get hashCode =>
        permissions.hashCode;

  factory AuthPermissionsResponse.fromJson(Map<String, dynamic> json) => _$AuthPermissionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthPermissionsResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

