//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'onboarding_step.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OnboardingStep {
  /// Returns a new [OnboardingStep] instance.
  OnboardingStep({

    required  this.count,

    required  this.done,

    required  this.key,

    required  this.required_,
  });

      /// Supporting count (branches created, items added, …).
  @JsonKey(
    
    name: r'count',
    required: true,
    includeIfNull: false,
  )


  final int count;



      /// True when the underlying data exists.
  @JsonKey(
    
    name: r'done',
    required: true,
    includeIfNull: false,
  )


  final bool done;



      /// Stable key the dashboard switches on — never localized.
  @JsonKey(
    
    name: r'key',
    required: true,
    includeIfNull: false,
  )


  final String key;



      /// Steps that are encouraged but not blocking (`required = false` never gates `can_complete`).
  @JsonKey(
    
    name: r'required',
    required: true,
    includeIfNull: false,
  )


  final bool required_;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OnboardingStep &&
      other.count == count &&
      other.done == done &&
      other.key == key &&
      other.required_ == required_;

    @override
    int get hashCode =>
        count.hashCode +
        done.hashCode +
        key.hashCode +
        required_.hashCode;

  factory OnboardingStep.fromJson(Map<String, dynamic> json) => _$OnboardingStepFromJson(json);

  Map<String, dynamic> toJson() => _$OnboardingStepToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

