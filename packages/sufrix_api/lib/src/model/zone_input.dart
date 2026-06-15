//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'zone_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ZoneInput {
  /// Returns a new [ZoneInput] instance.
  ZoneInput({

    required  this.branchId,

    required  this.fee,

     this.isActive,

    required  this.maxRoadDistanceMeters,

    required  this.name,

     this.nameTranslations,
  });

  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



  @JsonKey(
    
    name: r'fee',
    required: true,
    includeIfNull: false,
  )


  final int fee;



  @JsonKey(
    
    name: r'is_active',
    required: false,
    includeIfNull: false,
  )


  final bool? isActive;



  @JsonKey(
    
    name: r'max_road_distance_meters',
    required: true,
    includeIfNull: false,
  )


  final int maxRoadDistanceMeters;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'name_translations',
    required: false,
    includeIfNull: false,
  )


  final Object? nameTranslations;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ZoneInput &&
      other.branchId == branchId &&
      other.fee == fee &&
      other.isActive == isActive &&
      other.maxRoadDistanceMeters == maxRoadDistanceMeters &&
      other.name == name &&
      other.nameTranslations == nameTranslations;

    @override
    int get hashCode =>
        branchId.hashCode +
        fee.hashCode +
        isActive.hashCode +
        maxRoadDistanceMeters.hashCode +
        name.hashCode +
        nameTranslations.hashCode;

  factory ZoneInput.fromJson(Map<String, dynamic> json) => _$ZoneInputFromJson(json);

  Map<String, dynamic> toJson() => _$ZoneInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

