//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/revenue_class.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'classification_one_of1.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ClassificationOneOf1 {
  /// Returns a new [ClassificationOneOf1] instance.
  ClassificationOneOf1({

    required  this.class_,

    required  this.mode,
  });

  @JsonKey(
    
    name: r'class',
    required: true,
    includeIfNull: false,
  unknownEnumValue: RevenueClass.unknownDefaultOpenApi,
  )


  final RevenueClass class_;



  @JsonKey(
    
    name: r'mode',
    required: true,
    includeIfNull: false,
  unknownEnumValue: ClassificationOneOf1ModeEnum.unknownDefaultOpenApi,
  )


  final ClassificationOneOf1ModeEnum mode;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ClassificationOneOf1 &&
      other.class_ == class_ &&
      other.mode == mode;

    @override
    int get hashCode =>
        class_.hashCode +
        mode.hashCode;

  factory ClassificationOneOf1.fromJson(Map<String, dynamic> json) => _$ClassificationOneOf1FromJson(json);

  Map<String, dynamic> toJson() => _$ClassificationOneOf1ToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum ClassificationOneOf1ModeEnum {
@JsonValue(r'revenue')
revenue(r'revenue'),
@JsonValue(r'unknown_default_open_api')
unknownDefaultOpenApi(r'unknown_default_open_api');

const ClassificationOneOf1ModeEnum(this.value);

final String value;

@override
String toString() => value;
}


