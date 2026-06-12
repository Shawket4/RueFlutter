//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_org.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PublicOrg {
  /// Returns a new [PublicOrg] instance.
  PublicOrg({

     this.address,

     this.branchCount,

    required  this.createdAt,

     this.logoUrl,

    required  this.name,
  });

  @JsonKey(
    
    name: r'address',
    required: false,
    includeIfNull: false,
  )


  final String? address;



  @JsonKey(
    
    name: r'branch_count',
    required: false,
    includeIfNull: false,
  )


  final int? branchCount;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'logo_url',
    required: false,
    includeIfNull: false,
  )


  final String? logoUrl;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PublicOrg &&
      other.address == address &&
      other.branchCount == branchCount &&
      other.createdAt == createdAt &&
      other.logoUrl == logoUrl &&
      other.name == name;

    @override
    int get hashCode =>
        (address == null ? 0 : address.hashCode) +
        (branchCount == null ? 0 : branchCount.hashCode) +
        createdAt.hashCode +
        (logoUrl == null ? 0 : logoUrl.hashCode) +
        name.hashCode;

  factory PublicOrg.fromJson(Map<String, dynamic> json) => _$PublicOrgFromJson(json);

  Map<String, dynamic> toJson() => _$PublicOrgToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

