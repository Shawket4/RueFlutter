//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_addon_item_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateAddonItemRequest {
  /// Returns a new [CreateAddonItemRequest] instance.
  CreateAddonItemRequest({

    required  this.addonType,

    required  this.defaultPrice,

    required  this.name,

     this.nameTranslations,

    required  this.orgId,
  });

  @JsonKey(
    
    name: r'addon_type',
    required: true,
    includeIfNull: false,
  )


  final String addonType;



  @JsonKey(
    
    name: r'default_price',
    required: true,
    includeIfNull: false,
  )


  final int defaultPrice;



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



  @JsonKey(
    
    name: r'org_id',
    required: true,
    includeIfNull: false,
  )


  final String orgId;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateAddonItemRequest &&
      other.addonType == addonType &&
      other.defaultPrice == defaultPrice &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.orgId == orgId;

    @override
    int get hashCode =>
        addonType.hashCode +
        defaultPrice.hashCode +
        name.hashCode +
        (nameTranslations == null ? 0 : nameTranslations.hashCode) +
        orgId.hashCode;

  factory CreateAddonItemRequest.fromJson(Map<String, dynamic> json) => _$CreateAddonItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAddonItemRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

