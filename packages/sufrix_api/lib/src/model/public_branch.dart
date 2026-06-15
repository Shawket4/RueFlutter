//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_branch.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PublicBranch {
  /// Returns a new [PublicBranch] instance.
  PublicBranch({

    required  this.code,

    required  this.id,

    required  this.inMallEnabled,

    required  this.inMallOpenNow,

    required  this.name,

    required  this.outsideEnabled,

    required  this.outsideOpenNow,
  });

  @JsonKey(
    
    name: r'code',
    required: true,
    includeIfNull: false,
  )


  final String code;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'in_mall_enabled',
    required: true,
    includeIfNull: false,
  )


  final bool inMallEnabled;



      /// Effective-open right now (enabled + open shift + override + window).
  @JsonKey(
    
    name: r'in_mall_open_now',
    required: true,
    includeIfNull: false,
  )


  final bool inMallOpenNow;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'outside_enabled',
    required: true,
    includeIfNull: false,
  )


  final bool outsideEnabled;



  @JsonKey(
    
    name: r'outside_open_now',
    required: true,
    includeIfNull: false,
  )


  final bool outsideOpenNow;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PublicBranch &&
      other.code == code &&
      other.id == id &&
      other.inMallEnabled == inMallEnabled &&
      other.inMallOpenNow == inMallOpenNow &&
      other.name == name &&
      other.outsideEnabled == outsideEnabled &&
      other.outsideOpenNow == outsideOpenNow;

    @override
    int get hashCode =>
        code.hashCode +
        id.hashCode +
        inMallEnabled.hashCode +
        inMallOpenNow.hashCode +
        name.hashCode +
        outsideEnabled.hashCode +
        outsideOpenNow.hashCode;

  factory PublicBranch.fromJson(Map<String, dynamic> json) => _$PublicBranchFromJson(json);

  Map<String, dynamic> toJson() => _$PublicBranchToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

