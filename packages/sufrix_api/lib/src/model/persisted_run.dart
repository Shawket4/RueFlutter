//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/analysis_config.dart';
import 'package:sufrix_api/src/model/mode_summary.dart';
import 'package:sufrix_api/src/model/run_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'persisted_run.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PersistedRun {
  /// Returns a new [PersistedRun] instance.
  PersistedRun({

    required  this.branchId,

     this.completedAt,

    required  this.config,

     this.errorMessage,

    required  this.id,

    required  this.modeSummary,

    required  this.orgId,

    required  this.startedAt,

    required  this.status,

    required  this.windowDays,
  });

  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



  @JsonKey(
    
    name: r'completed_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? completedAt;



  @JsonKey(
    
    name: r'config',
    required: true,
    includeIfNull: false,
  )


  final AnalysisConfig config;



  @JsonKey(
    
    name: r'error_message',
    required: false,
    includeIfNull: false,
  )


  final String? errorMessage;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'mode_summary',
    required: true,
    includeIfNull: false,
  )


  final ModeSummary modeSummary;



  @JsonKey(
    
    name: r'org_id',
    required: true,
    includeIfNull: false,
  )


  final String orgId;



  @JsonKey(
    
    name: r'started_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime startedAt;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  unknownEnumValue: RunStatus.unknownDefaultOpenApi,
  )


  final RunStatus status;



  @JsonKey(
    
    name: r'window_days',
    required: true,
    includeIfNull: false,
  )


  final double windowDays;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PersistedRun &&
      other.branchId == branchId &&
      other.completedAt == completedAt &&
      other.config == config &&
      other.errorMessage == errorMessage &&
      other.id == id &&
      other.modeSummary == modeSummary &&
      other.orgId == orgId &&
      other.startedAt == startedAt &&
      other.status == status &&
      other.windowDays == windowDays;

    @override
    int get hashCode =>
        branchId.hashCode +
        (completedAt == null ? 0 : completedAt.hashCode) +
        config.hashCode +
        (errorMessage == null ? 0 : errorMessage.hashCode) +
        id.hashCode +
        modeSummary.hashCode +
        orgId.hashCode +
        startedAt.hashCode +
        status.hashCode +
        windowDays.hashCode;

  factory PersistedRun.fromJson(Map<String, dynamic> json) => _$PersistedRunFromJson(json);

  Map<String, dynamic> toJson() => _$PersistedRunToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

