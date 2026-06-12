//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resolve_branch_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ResolveBranchRequest {
  /// Returns a new [ResolveBranchRequest] instance.
  ResolveBranchRequest({

    required  this.latitude,

    required  this.longitude,

    required  this.orgId,
  });

      /// Device GPS latitude (WGS-84).
  @JsonKey(
    
    name: r'latitude',
    required: true,
    includeIfNull: false,
  )


  final double latitude;



      /// Device GPS longitude (WGS-84).
  @JsonKey(
    
    name: r'longitude',
    required: true,
    includeIfNull: false,
  )


  final double longitude;



      /// Organization to search within.
  @JsonKey(
    
    name: r'org_id',
    required: true,
    includeIfNull: false,
  )


  final String orgId;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ResolveBranchRequest &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.orgId == orgId;

    @override
    int get hashCode =>
        latitude.hashCode +
        longitude.hashCode +
        orgId.hashCode;

  factory ResolveBranchRequest.fromJson(Map<String, dynamic> json) => _$ResolveBranchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResolveBranchRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

