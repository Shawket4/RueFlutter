//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/public_category.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_menu_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PublicMenuResponse {
  /// Returns a new [PublicMenuResponse] instance.
  PublicMenuResponse({

    required  this.categories,

     this.logoUrl,

    required  this.orgId,

    required  this.orgName,
  });

  @JsonKey(
    
    name: r'categories',
    required: true,
    includeIfNull: false,
  )


  final List<PublicCategory> categories;



  @JsonKey(
    
    name: r'logo_url',
    required: false,
    includeIfNull: false,
  )


  final String? logoUrl;



  @JsonKey(
    
    name: r'org_id',
    required: true,
    includeIfNull: false,
  )


  final String orgId;



  @JsonKey(
    
    name: r'org_name',
    required: true,
    includeIfNull: false,
  )


  final String orgName;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PublicMenuResponse &&
      other.categories == categories &&
      other.logoUrl == logoUrl &&
      other.orgId == orgId &&
      other.orgName == orgName;

    @override
    int get hashCode =>
        categories.hashCode +
        (logoUrl == null ? 0 : logoUrl.hashCode) +
        orgId.hashCode +
        orgName.hashCode;

  factory PublicMenuResponse.fromJson(Map<String, dynamic> json) => _$PublicMenuResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PublicMenuResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

