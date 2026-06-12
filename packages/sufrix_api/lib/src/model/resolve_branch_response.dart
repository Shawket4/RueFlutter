//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resolve_branch_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ResolveBranchResponse {
  /// Returns a new [ResolveBranchResponse] instance.
  ResolveBranchResponse({

    required  this.branchId,

    required  this.branchName,

    required  this.distanceMeters,
  });

  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



  @JsonKey(
    
    name: r'branch_name',
    required: true,
    includeIfNull: false,
  )


  final String branchName;



      /// Straight-line distance from the supplied coordinates to the branch, in metres.
  @JsonKey(
    
    name: r'distance_meters',
    required: true,
    includeIfNull: false,
  )


  final double distanceMeters;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ResolveBranchResponse &&
      other.branchId == branchId &&
      other.branchName == branchName &&
      other.distanceMeters == distanceMeters;

    @override
    int get hashCode =>
        branchId.hashCode +
        branchName.hashCode +
        distanceMeters.hashCode;

  factory ResolveBranchResponse.fromJson(Map<String, dynamic> json) => _$ResolveBranchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResolveBranchResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

