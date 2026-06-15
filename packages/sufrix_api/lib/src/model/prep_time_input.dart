//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'prep_time_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PrepTimeInput {
  /// Returns a new [PrepTimeInput] instance.
  PrepTimeInput({

    required  this.extraPrepMinutes,
  });

      /// Minutes the teller adds on top of the branch base prep time. Must be a non-negative multiple of 5.
  @JsonKey(
    
    name: r'extra_prep_minutes',
    required: true,
    includeIfNull: false,
  )


  final int extraPrepMinutes;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PrepTimeInput &&
      other.extraPrepMinutes == extraPrepMinutes;

    @override
    int get hashCode =>
        extraPrepMinutes.hashCode;

  factory PrepTimeInput.fromJson(Map<String, dynamic> json) => _$PrepTimeInputFromJson(json);

  Map<String, dynamic> toJson() => _$PrepTimeInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

