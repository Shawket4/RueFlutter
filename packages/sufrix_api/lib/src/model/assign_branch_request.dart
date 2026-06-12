//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assign_branch_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AssignBranchRequest {
  /// Returns a new [AssignBranchRequest] instance.
  AssignBranchRequest({

    required  this.branchId,
  });

  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AssignBranchRequest &&
      other.branchId == branchId;

    @override
    int get hashCode =>
        branchId.hashCode;

  factory AssignBranchRequest.fromJson(Map<String, dynamic> json) => _$AssignBranchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AssignBranchRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

