//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_branch.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UserBranch {
  /// Returns a new [UserBranch] instance.
  UserBranch({

    required  this.branchId,

    required  this.branchName,
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





    @override
    bool operator ==(Object other) => identical(this, other) || other is UserBranch &&
      other.branchId == branchId &&
      other.branchName == branchName;

    @override
    int get hashCode =>
        branchId.hashCode +
        branchName.hashCode;

  factory UserBranch.fromJson(Map<String, dynamic> json) => _$UserBranchFromJson(json);

  Map<String, dynamic> toJson() => _$UserBranchToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

