//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'classification_one_of2.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ClassificationOneOf2 {
  /// Returns a new [ClassificationOneOf2] instance.
  ClassificationOneOf2({

    required  this.mode,
  });

  @JsonKey(
    
    name: r'mode',
    required: true,
    includeIfNull: false,
  unknownEnumValue: ClassificationOneOf2ModeEnum.unknownDefaultOpenApi,
  )


  final ClassificationOneOf2ModeEnum mode;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ClassificationOneOf2 &&
      other.mode == mode;

    @override
    int get hashCode =>
        mode.hashCode;

  factory ClassificationOneOf2.fromJson(Map<String, dynamic> json) => _$ClassificationOneOf2FromJson(json);

  Map<String, dynamic> toJson() => _$ClassificationOneOf2ToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum ClassificationOneOf2ModeEnum {
@JsonValue(r'insufficient')
insufficient(r'insufficient'),
@JsonValue(r'unknown_default_open_api')
unknownDefaultOpenApi(r'unknown_default_open_api');

const ClassificationOneOf2ModeEnum(this.value);

final String value;

@override
String toString() => value;
}


