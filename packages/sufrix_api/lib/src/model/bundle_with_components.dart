//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/bundle_component_hydrated.dart';
import 'package:sufrix_api/src/model/bundle_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bundle_with_components.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BundleWithComponents {
  /// Returns a new [BundleWithComponents] instance.
  BundleWithComponents({

     this.availableFromDate,

     this.availableFromTime,

     this.availableUntilDate,

     this.availableUntilTime,

    required  this.createdAt,

     this.createdBy,

     this.description,

    required  this.descriptionTranslations,

    required  this.id,

     this.imageUrl,

    required  this.name,

    required  this.nameTranslations,

    required  this.orgId,

    required  this.price,

    required  this.status,

    required  this.updatedAt,

    required  this.branchIds,

    required  this.components,

    required  this.computedCost,
  });

  @JsonKey(
    
    name: r'available_from_date',
    required: false,
    includeIfNull: false,
  )


  final DateTime? availableFromDate;



  @JsonKey(
    
    name: r'available_from_time',
    required: false,
    includeIfNull: false,
  )


  final String? availableFromTime;



  @JsonKey(
    
    name: r'available_until_date',
    required: false,
    includeIfNull: false,
  )


  final DateTime? availableUntilDate;



  @JsonKey(
    
    name: r'available_until_time',
    required: false,
    includeIfNull: false,
  )


  final String? availableUntilTime;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'created_by',
    required: false,
    includeIfNull: false,
  )


  final String? createdBy;



  @JsonKey(
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



  @JsonKey(
    
    name: r'description_translations',
    required: true,
    includeIfNull: true,
  )


  final Object? descriptionTranslations;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'image_url',
    required: false,
    includeIfNull: false,
  )


  final String? imageUrl;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'name_translations',
    required: true,
    includeIfNull: true,
  )


  final Object? nameTranslations;



  @JsonKey(
    
    name: r'org_id',
    required: true,
    includeIfNull: false,
  )


  final String orgId;



  @JsonKey(
    
    name: r'price',
    required: true,
    includeIfNull: false,
  )


  final int price;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  unknownEnumValue: BundleStatus.unknownDefaultOpenApi,
  )


  final BundleStatus status;



  @JsonKey(
    
    name: r'updated_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime updatedAt;



  @JsonKey(
    
    name: r'branch_ids',
    required: true,
    includeIfNull: false,
  )


  final List<String> branchIds;



  @JsonKey(
    
    name: r'components',
    required: true,
    includeIfNull: false,
  )


  final List<BundleComponentHydrated> components;



  @JsonKey(
    
    name: r'computed_cost',
    required: true,
    includeIfNull: false,
  )


  final int computedCost;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BundleWithComponents &&
      other.availableFromDate == availableFromDate &&
      other.availableFromTime == availableFromTime &&
      other.availableUntilDate == availableUntilDate &&
      other.availableUntilTime == availableUntilTime &&
      other.createdAt == createdAt &&
      other.createdBy == createdBy &&
      other.description == description &&
      other.descriptionTranslations == descriptionTranslations &&
      other.id == id &&
      other.imageUrl == imageUrl &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.orgId == orgId &&
      other.price == price &&
      other.status == status &&
      other.updatedAt == updatedAt &&
      other.branchIds == branchIds &&
      other.components == components &&
      other.computedCost == computedCost;

    @override
    int get hashCode =>
        availableFromDate.hashCode +
        availableFromTime.hashCode +
        availableUntilDate.hashCode +
        availableUntilTime.hashCode +
        createdAt.hashCode +
        createdBy.hashCode +
        description.hashCode +
        (descriptionTranslations == null ? 0 : descriptionTranslations.hashCode) +
        id.hashCode +
        imageUrl.hashCode +
        name.hashCode +
        (nameTranslations == null ? 0 : nameTranslations.hashCode) +
        orgId.hashCode +
        price.hashCode +
        status.hashCode +
        updatedAt.hashCode +
        branchIds.hashCode +
        components.hashCode +
        computedCost.hashCode;

  factory BundleWithComponents.fromJson(Map<String, dynamic> json) => _$BundleWithComponentsFromJson(json);

  Map<String, dynamic> toJson() => _$BundleWithComponentsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

