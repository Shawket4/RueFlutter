//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_delivery_settings.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BranchDeliverySettings {
  /// Returns a new [BranchDeliverySettings] instance.
  BranchDeliverySettings({

    required  this.branchId,

     this.inMallCloseTime,

    required  this.inMallEnabled,

    required  this.inMallFee,

     this.inMallOpenTime,

    required  this.inMallOverride,

     this.maxRoadDistanceMeters,

     this.outsideCloseTime,

    required  this.outsideEnabled,

     this.outsideOpenTime,

    required  this.outsideOverride,

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
    
    name: r'in_mall_override',
    required: true,
    includeIfNull: false,
  )


  final String inMallOverride;



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
    
    name: r'outside_override',
    required: true,
    includeIfNull: false,
  )


  final String outsideOverride;



  @JsonKey(
    
    name: r'prep_time_minutes',
    required: true,
    includeIfNull: false,
  )


  final int prepTimeMinutes;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BranchDeliverySettings &&
      other.branchId == branchId &&
      other.inMallCloseTime == inMallCloseTime &&
      other.inMallEnabled == inMallEnabled &&
      other.inMallFee == inMallFee &&
      other.inMallOpenTime == inMallOpenTime &&
      other.inMallOverride == inMallOverride &&
      other.maxRoadDistanceMeters == maxRoadDistanceMeters &&
      other.outsideCloseTime == outsideCloseTime &&
      other.outsideEnabled == outsideEnabled &&
      other.outsideOpenTime == outsideOpenTime &&
      other.outsideOverride == outsideOverride &&
      other.prepTimeMinutes == prepTimeMinutes;

    @override
    int get hashCode =>
        branchId.hashCode +
        (inMallCloseTime == null ? 0 : inMallCloseTime.hashCode) +
        inMallEnabled.hashCode +
        inMallFee.hashCode +
        (inMallOpenTime == null ? 0 : inMallOpenTime.hashCode) +
        inMallOverride.hashCode +
        (maxRoadDistanceMeters == null ? 0 : maxRoadDistanceMeters.hashCode) +
        (outsideCloseTime == null ? 0 : outsideCloseTime.hashCode) +
        outsideEnabled.hashCode +
        (outsideOpenTime == null ? 0 : outsideOpenTime.hashCode) +
        outsideOverride.hashCode +
        prepTimeMinutes.hashCode;

  factory BranchDeliverySettings.fromJson(Map<String, dynamic> json) => _$BranchDeliverySettingsFromJson(json);

  Map<String, dynamic> toJson() => _$BranchDeliverySettingsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

