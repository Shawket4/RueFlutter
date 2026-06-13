//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/analysis_config.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_run_body.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateRunBody {
  /// Returns a new [CreateRunBody] instance.
  CreateRunBody({

     this.config,
  });

  @JsonKey(
    
    name: r'config',
    required: false,
    includeIfNull: false,
  )


  final AnalysisConfig? config;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateRunBody &&
      other.config == config;

    @override
    int get hashCode =>
        (config == null ? 0 : config.hashCode);

  factory CreateRunBody.fromJson(Map<String, dynamic> json) => _$CreateRunBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRunBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

