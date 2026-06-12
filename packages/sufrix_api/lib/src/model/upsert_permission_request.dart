//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upsert_permission_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpsertPermissionRequest {
  /// Returns a new [UpsertPermissionRequest] instance.
  UpsertPermissionRequest({

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
    bool operator ==(Object other) => identical(this, other) || other is UpsertPermissionRequest &&
      other.action == action &&
      other.granted == granted &&
      other.resource == resource;

    @override
    int get hashCode =>
        action.hashCode +
        granted.hashCode +
        resource.hashCode;

  factory UpsertPermissionRequest.fromJson(Map<String, dynamic> json) => _$UpsertPermissionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpsertPermissionRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

