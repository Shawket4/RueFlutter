//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_run_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateRunResponse {
  /// Returns a new [CreateRunResponse] instance.
  CreateRunResponse({

    required  this.runId,
  });

  @JsonKey(
    
    name: r'run_id',
    required: true,
    includeIfNull: false,
  )


  final String runId;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateRunResponse &&
      other.runId == runId;

    @override
    int get hashCode =>
        runId.hashCode;

  factory CreateRunResponse.fromJson(Map<String, dynamic> json) => _$CreateRunResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRunResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

