//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'permission_matrix.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PermissionMatrix {
  /// Returns a new [PermissionMatrix] instance.
  PermissionMatrix({

    required  this.action,

    required  this.effective,

    required  this.resource,

     this.roleDefault,

     this.userOverride,
  });

  @JsonKey(
    
    name: r'action',
    required: true,
    includeIfNull: false,
  )


  final String action;



  @JsonKey(
    
    name: r'effective',
    required: true,
    includeIfNull: false,
  )


  final bool effective;



  @JsonKey(
    
    name: r'resource',
    required: true,
    includeIfNull: false,
  )


  final String resource;



  @JsonKey(
    
    name: r'role_default',
    required: false,
    includeIfNull: false,
  )


  final bool? roleDefault;



  @JsonKey(
    
    name: r'user_override',
    required: false,
    includeIfNull: false,
  )


  final bool? userOverride;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PermissionMatrix &&
      other.action == action &&
      other.effective == effective &&
      other.resource == resource &&
      other.roleDefault == roleDefault &&
      other.userOverride == userOverride;

    @override
    int get hashCode =>
        action.hashCode +
        effective.hashCode +
        resource.hashCode +
        (roleDefault == null ? 0 : roleDefault.hashCode) +
        (userOverride == null ? 0 : userOverride.hashCode);

  factory PermissionMatrix.fromJson(Map<String, dynamic> json) => _$PermissionMatrixFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionMatrixToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

