//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_settings_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BranchSettingsInput {
  /// Returns a new [BranchSettingsInput] instance.
  BranchSettingsInput({

    required  this.branchId,

     this.inMallCloseTime,

    required  this.inMallEnabled,

    required  this.inMallFee,

     this.inMallOpenTime,

     this.maxRoadDistanceMeters,

     this.outsideCloseTime,

    required  this.outsideEnabled,

     this.outsideOpenTime,

    required  this.prepTimeMinutes,
  });

  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



  @JsonKey(
    
    name: r'in_mall_close_time',
    required: false,
    includeIfNull: false,
  )


  final String? inMallCloseTime;



  @JsonKey(
    
    name: r'in_mall_enabled',
    required: true,
    includeIfNull: false,
  )


  final bool inMallEnabled;



  @JsonKey(
    
    name: r'in_mall_fee',
    required: true,
    includeIfNull: false,
  )


  final int inMallFee;



  @JsonKey(
    
    name: r'in_mall_open_time',
    required: false,
    includeIfNull: false,
  )


  final String? inMallOpenTime;



  @JsonKey(
    
    name: r'max_road_distance_meters',
    required: false,
    includeIfNull: false,
  )


  final int? maxRoadDistanceMeters;



  @JsonKey(
    
    name: r'outside_close_time',
    required: false,
    includeIfNull: false,
  )


  final String? outsideCloseTime;



  @JsonKey(
    
    name: r'outside_enabled',
    required: true,
    includeIfNull: false,
  )


  final bool outsideEnabled;



  @JsonKey(
    
    name: r'outside_open_time',
    required: false,
    includeIfNull: false,
  )


  final String? outsideOpenTime;



  @JsonKey(
    
    name: r'prep_time_minutes',
    required: true,
    includeIfNull: false,
  )


  final int prepTimeMinutes;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BranchSettingsInput &&
      other.branchId == branchId &&
      other.inMallCloseTime == inMallCloseTime &&
      other.inMallEnabled == inMallEnabled &&
      other.inMallFee == inMallFee &&
      other.inMallOpenTime == inMallOpenTime &&
      other.maxRoadDistanceMeters == maxRoadDistanceMeters &&
      other.outsideCloseTime == outsideCloseTime &&
      other.outsideEnabled == outsideEnabled &&
      other.outsideOpenTime == outsideOpenTime &&
      other.prepTimeMinutes == prepTimeMinutes;

    @override
    int get hashCode =>
        branchId.hashCode +
        (inMallCloseTime == null ? 0 : inMallCloseTime.hashCode) +
        inMallEnabled.hashCode +
        inMallFee.hashCode +
        (inMallOpenTime == null ? 0 : inMallOpenTime.hashCode) +
        (maxRoadDistanceMeters == null ? 0 : maxRoadDistanceMeters.hashCode) +
        (outsideCloseTime == null ? 0 : outsideCloseTime.hashCode) +
        outsideEnabled.hashCode +
        (outsideOpenTime == null ? 0 : outsideOpenTime.hashCode) +
        prepTimeMinutes.hashCode;

  factory BranchSettingsInput.fromJson(Map<String, dynamic> json) => _$BranchSettingsInputFromJson(json);

  Map<String, dynamic> toJson() => _$BranchSettingsInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

