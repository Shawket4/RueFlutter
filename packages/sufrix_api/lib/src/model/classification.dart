//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/classification_one_of.dart';
import 'package:sufrix_api/src/model/revenue_class.dart';
import 'package:sufrix_api/src/model/classification_one_of1.dart';
import 'package:sufrix_api/src/model/classification_one_of2.dart';
import 'package:sufrix_api/src/model/cm_quadrant.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'classification.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Classification {
  /// Returns a new [Classification] instance.
  Classification({

    required  this.mode,

    required  this.quadrant,

    required  this.class_,
  });

  @JsonKey(
    
    name: r'mode',
    required: true,
    includeIfNull: false,
  unknownEnumValue: ClassificationModeEnum.unknownDefaultOpenApi,
  )


  final ClassificationModeEnum mode;



  @JsonKey(
    
    name: r'quadrant',
    required: true,
    includeIfNull: false,
  unknownEnumValue: CmQuadrant.unknownDefaultOpenApi,
  )


  final CmQuadrant quadrant;



  @JsonKey(
    
    name: r'class',
    required: true,
    includeIfNull: false,
  unknownEnumValue: RevenueClass.unknownDefaultOpenApi,
  )


  final RevenueClass class_;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Classification &&
      other.mode == mode &&
      other.quadrant == quadrant &&
      other.class_ == class_;

    @override
    int get hashCode =>
        mode.hashCode +
        quadrant.hashCode +
        class_.hashCode;

  factory Classification.fromJson(Map<String, dynamic> json) => _$ClassificationFromJson(json);

  Map<String, dynamic> toJson() => _$ClassificationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum ClassificationModeEnum {
@JsonValue(r'insufficient')
insufficient(r'insufficient'),
@JsonValue(r'unknown_default_open_api')
unknownDefaultOpenApi(r'unknown_default_open_api');

const ClassificationModeEnum(this.value);

final String value;

@override
String toString() => value;
}


