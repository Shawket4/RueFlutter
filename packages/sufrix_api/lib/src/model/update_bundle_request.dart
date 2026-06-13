//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/create_bundle_component_input.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_bundle_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateBundleRequest {
  /// Returns a new [UpdateBundleRequest] instance.
  UpdateBundleRequest({

     this.availableFromDate,

     this.availableFromTime,

     this.availableUntilDate,

     this.availableUntilTime,

     this.branchIds,

     this.components,

     this.description,

     this.descriptionTranslations,

     this.imageUrl,

     this.name,

     this.nameTranslations,

     this.price,
  });

  @JsonKey(
    
    name: r'available_from_date',
    required: false,
    includeIfNull: false,
  )


  final DateTime? availableFromDate;



      /// `null`  → clear the field (no start time restriction) omitted → keep the existing value a value → set to that time
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
    
    name: r'branch_ids',
    required: false,
    includeIfNull: false,
  )


  final List<String>? branchIds;



  @JsonKey(
    
    name: r'components',
    required: false,
    includeIfNull: false,
  )


  final List<CreateBundleComponentInput>? components;



  @JsonKey(
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



  @JsonKey(
    
    name: r'description_translations',
    required: false,
    includeIfNull: false,
  )


  final Object? descriptionTranslations;



  @JsonKey(
    
    name: r'image_url',
    required: false,
    includeIfNull: false,
  )


  final String? imageUrl;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'name_translations',
    required: false,
    includeIfNull: false,
  )


  final Object? nameTranslations;



  @JsonKey(
    
    name: r'price',
    required: false,
    includeIfNull: false,
  )


  final int? price;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpdateBundleRequest &&
      other.availableFromDate == availableFromDate &&
      other.availableFromTime == availableFromTime &&
      other.availableUntilDate == availableUntilDate &&
      other.availableUntilTime == availableUntilTime &&
      other.branchIds == branchIds &&
      other.components == components &&
      other.description == description &&
      other.descriptionTranslations == descriptionTranslations &&
      other.imageUrl == imageUrl &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.price == price;

    @override
    int get hashCode =>
        (availableFromDate == null ? 0 : availableFromDate.hashCode) +
        (availableFromTime == null ? 0 : availableFromTime.hashCode) +
        (availableUntilDate == null ? 0 : availableUntilDate.hashCode) +
        (availableUntilTime == null ? 0 : availableUntilTime.hashCode) +
        (branchIds == null ? 0 : branchIds.hashCode) +
        (components == null ? 0 : components.hashCode) +
        (description == null ? 0 : description.hashCode) +
        (descriptionTranslations == null ? 0 : descriptionTranslations.hashCode) +
        (imageUrl == null ? 0 : imageUrl.hashCode) +
        (name == null ? 0 : name.hashCode) +
        (nameTranslations == null ? 0 : nameTranslations.hashCode) +
        (price == null ? 0 : price.hashCode);

  factory UpdateBundleRequest.fromJson(Map<String, dynamic> json) => _$UpdateBundleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateBundleRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

