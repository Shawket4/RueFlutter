//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/onboarding_step.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'onboarding_status.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OnboardingStatus {
  /// Returns a new [OnboardingStatus] instance.
  OnboardingStatus({

    required  this.canComplete,

    required  this.completed,

     this.completedAt,

    required  this.orgId,

    required  this.recipeCoverage,

    required  this.steps,
  });

      /// True when every `required` step is done (the Finish button enabler).
  @JsonKey(
    
    name: r'can_complete',
    required: true,
    includeIfNull: false,
  )


  final bool canComplete;



      /// Persisted terminal flag — the dashboard routes into the wizard when this is false.
  @JsonKey(
    
    name: r'completed',
    required: true,
    includeIfNull: false,
  )


  final bool completed;



  @JsonKey(
    
    name: r'completed_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? completedAt;



  @JsonKey(
    
    name: r'org_id',
    required: true,
    includeIfNull: false,
  )


  final String orgId;



      /// Recipe coverage across active menu items (0..1) — drives the cost engine; surfaced separately because it's a percentage, not a bool.
  @JsonKey(
    
    name: r'recipe_coverage',
    required: true,
    includeIfNull: false,
  )


  final double recipeCoverage;



  @JsonKey(
    
    name: r'steps',
    required: true,
    includeIfNull: false,
  )


  final List<OnboardingStep> steps;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OnboardingStatus &&
      other.canComplete == canComplete &&
      other.completed == completed &&
      other.completedAt == completedAt &&
      other.orgId == orgId &&
      other.recipeCoverage == recipeCoverage &&
      other.steps == steps;

    @override
    int get hashCode =>
        canComplete.hashCode +
        completed.hashCode +
        (completedAt == null ? 0 : completedAt.hashCode) +
        orgId.hashCode +
        recipeCoverage.hashCode +
        steps.hashCode;

  factory OnboardingStatus.fromJson(Map<String, dynamic> json) => _$OnboardingStatusFromJson(json);

  Map<String, dynamic> toJson() => _$OnboardingStatusToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

