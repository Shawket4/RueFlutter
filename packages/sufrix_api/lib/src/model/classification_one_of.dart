//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/cm_quadrant.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'classification_one_of.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ClassificationOneOf {
  /// Returns a new [ClassificationOneOf] instance.
  ClassificationOneOf({

    required  this.mode,

    required  this.quadrant,
  });

  @JsonKey(
    
    name: r'mode',
    required: true,
    includeIfNull: false,
  unknownEnumValue: ClassificationOneOfModeEnum.unknownDefaultOpenApi,
  )


  final ClassificationOneOfModeEnum mode;



  @JsonKey(
    
    name: r'quadrant',
    required: true,
    includeIfNull: false,
  unknownEnumValue: CmQuadrant.unknownDefaultOpenApi,
  )


  final CmQuadrant quadrant;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ClassificationOneOf &&
      other.mode == mode &&
      other.quadrant == quadrant;

    @override
    int get hashCode =>
        mode.hashCode +
        quadrant.hashCode;

  factory ClassificationOneOf.fromJson(Map<String, dynamic> json) => _$ClassificationOneOfFromJson(json);

  Map<String, dynamic> toJson() => _$ClassificationOneOfToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum ClassificationOneOfModeEnum {
@JsonValue(r'cm')
cm(r'cm'),
@JsonValue(r'unknown_default_open_api')
unknownDefaultOpenApi(r'unknown_default_open_api');

const ClassificationOneOfModeEnum(this.value);

final String value;

@override
String toString() => value;
}


