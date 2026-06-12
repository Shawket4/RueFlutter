//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/branch_comparison.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'org_comparison_report.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrgComparisonReport {
  /// Returns a new [OrgComparisonReport] instance.
  OrgComparisonReport({

    required  this.branches,

     this.from,

    required  this.orgId,

     this.to,
  });

  @JsonKey(
    
    name: r'branches',
    required: true,
    includeIfNull: false,
  )


  final List<BranchComparison> branches;



  @JsonKey(
    
    name: r'from',
    required: false,
    includeIfNull: false,
  )


  final DateTime? from;



  @JsonKey(
    
    name: r'org_id',
    required: true,
    includeIfNull: false,
  )


  final String orgId;



  @JsonKey(
    
    name: r'to',
    required: false,
    includeIfNull: false,
  )


  final DateTime? to;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrgComparisonReport &&
      other.branches == branches &&
      other.from == from &&
      other.orgId == orgId &&
      other.to == to;

    @override
    int get hashCode =>
        branches.hashCode +
        (from == null ? 0 : from.hashCode) +
        orgId.hashCode +
        (to == null ? 0 : to.hashCode);

  factory OrgComparisonReport.fromJson(Map<String, dynamic> json) => _$OrgComparisonReportFromJson(json);

  Map<String, dynamic> toJson() => _$OrgComparisonReportToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

