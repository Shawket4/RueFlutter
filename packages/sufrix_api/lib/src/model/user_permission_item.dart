//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_permission_item.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserPermissionItem {
  /// Returns a new [UserPermissionItem] instance.
  UserPermissionItem({

    required  this.action,

    required  this.granted,

    required  this.resource,
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





    @override
    bool operator ==(Object other) => identical(this, other) || other is UserPermissionItem &&
      other.action == action &&
      other.granted == granted &&
      other.resource == resource;

    @override
    int get hashCode =>
        action.hashCode +
        granted.hashCode +
        resource.hashCode;

  factory UserPermissionItem.fromJson(Map<String, dynamic> json) => _$UserPermissionItemFromJson(json);

  Map<String, dynamic> toJson() => _$UserPermissionItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

