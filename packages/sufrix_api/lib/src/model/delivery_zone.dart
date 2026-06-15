//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_zone.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DeliveryZone {
  /// Returns a new [DeliveryZone] instance.
  DeliveryZone({

    required  this.branchId,

    required  this.fee,

    required  this.id,

    required  this.isActive,

    required  this.maxRoadDistanceMeters,

    required  this.name,

    required  this.nameTranslations,
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
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'is_active',
    required: true,
    includeIfNull: false,
  )


  final bool isActive;



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
    required: true,
    includeIfNull: false,
  )


  final Object nameTranslations;





    @override
    bool operator ==(Object other) => identical(this, other) || other is DeliveryZone &&
      other.branchId == branchId &&
      other.fee == fee &&
      other.id == id &&
      other.isActive == isActive &&
      other.maxRoadDistanceMeters == maxRoadDistanceMeters &&
      other.name == name &&
      other.nameTranslations == nameTranslations;

    @override
    int get hashCode =>
        branchId.hashCode +
        fee.hashCode +
        id.hashCode +
        isActive.hashCode +
        maxRoadDistanceMeters.hashCode +
        name.hashCode +
        nameTranslations.hashCode;

  factory DeliveryZone.fromJson(Map<String, dynamic> json) => _$DeliveryZoneFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryZoneToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

