//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/bundle_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bundle.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Bundle {
  /// Returns a new [Bundle] instance.
  Bundle({

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





    @override
    bool operator ==(Object other) => identical(this, other) || other is Bundle &&
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
      other.updatedAt == updatedAt;

    @override
    int get hashCode =>
        (availableFromDate == null ? 0 : availableFromDate.hashCode) +
        (availableFromTime == null ? 0 : availableFromTime.hashCode) +
        (availableUntilDate == null ? 0 : availableUntilDate.hashCode) +
        (availableUntilTime == null ? 0 : availableUntilTime.hashCode) +
        createdAt.hashCode +
        (createdBy == null ? 0 : createdBy.hashCode) +
        (description == null ? 0 : description.hashCode) +
        (descriptionTranslations == null ? 0 : descriptionTranslations.hashCode) +
        id.hashCode +
        (imageUrl == null ? 0 : imageUrl.hashCode) +
        name.hashCode +
        (nameTranslations == null ? 0 : nameTranslations.hashCode) +
        orgId.hashCode +
        price.hashCode +
        status.hashCode +
        updatedAt.hashCode;

  factory Bundle.fromJson(Map<String, dynamic> json) => _$BundleFromJson(json);

  Map<String, dynamic> toJson() => _$BundleToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

