//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/printer_brand.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Branch {
  /// Returns a new [Branch] instance.
  Branch({

     this.address,

    required  this.createdAt,

     this.geoRadiusMeters,

    required  this.id,

    required  this.isActive,

     this.latitude,

     this.longitude,

    required  this.name,

    required  this.orgId,

     this.orgLogoUrl,

     this.phone,

     this.printerBrand,

     this.printerIp,

     this.printerPort,

    required  this.timezone,

    required  this.updatedAt,
  });

  @JsonKey(
    
    name: r'address',
    required: false,
    includeIfNull: false,
  )


  final String? address;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



      /// Radius in meters within which this branch is considered a match. Defaults to 200.
  @JsonKey(
    
    name: r'geo_radius_meters',
    required: false,
    includeIfNull: false,
  )


  final int? geoRadiusMeters;



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



      /// WGS-84 latitude for geofenced branch resolution.
  @JsonKey(
    
    name: r'latitude',
    required: false,
    includeIfNull: false,
  )


  final double? latitude;



      /// WGS-84 longitude for geofenced branch resolution.
  @JsonKey(
    
    name: r'longitude',
    required: false,
    includeIfNull: false,
  )


  final double? longitude;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'org_id',
    required: true,
    includeIfNull: false,
  )


  final String orgId;



      /// Convenience field — populated from the parent org's `logo_url`.
  @JsonKey(
    
    name: r'org_logo_url',
    required: false,
    includeIfNull: false,
  )


  final String? orgLogoUrl;



  @JsonKey(
    
    name: r'phone',
    required: false,
    includeIfNull: false,
  )


  final String? phone;



  @JsonKey(
    
    name: r'printer_brand',
    required: false,
    includeIfNull: false,
  unknownEnumValue: PrinterBrand.unknownDefaultOpenApi,
  )


  final PrinterBrand? printerBrand;



  @JsonKey(
    
    name: r'printer_ip',
    required: false,
    includeIfNull: false,
  )


  final String? printerIp;



  @JsonKey(
    
    name: r'printer_port',
    required: false,
    includeIfNull: false,
  )


  final int? printerPort;



      /// Effective IANA timezone name for this branch, resolved as `branch.timezone → org.timezone → Africa/Cairo`. Always present; clients should format all of this branch's timestamps in this zone.
  @JsonKey(
    
    name: r'timezone',
    required: true,
    includeIfNull: false,
  )


  final String timezone;



  @JsonKey(
    
    name: r'updated_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime updatedAt;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Branch &&
      other.address == address &&
      other.createdAt == createdAt &&
      other.geoRadiusMeters == geoRadiusMeters &&
      other.id == id &&
      other.isActive == isActive &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.name == name &&
      other.orgId == orgId &&
      other.orgLogoUrl == orgLogoUrl &&
      other.phone == phone &&
      other.printerBrand == printerBrand &&
      other.printerIp == printerIp &&
      other.printerPort == printerPort &&
      other.timezone == timezone &&
      other.updatedAt == updatedAt;

    @override
    int get hashCode =>
        (address == null ? 0 : address.hashCode) +
        createdAt.hashCode +
        (geoRadiusMeters == null ? 0 : geoRadiusMeters.hashCode) +
        id.hashCode +
        isActive.hashCode +
        (latitude == null ? 0 : latitude.hashCode) +
        (longitude == null ? 0 : longitude.hashCode) +
        name.hashCode +
        orgId.hashCode +
        (orgLogoUrl == null ? 0 : orgLogoUrl.hashCode) +
        (phone == null ? 0 : phone.hashCode) +
        (printerBrand == null ? 0 : printerBrand.hashCode) +
        (printerIp == null ? 0 : printerIp.hashCode) +
        (printerPort == null ? 0 : printerPort.hashCode) +
        timezone.hashCode +
        updatedAt.hashCode;

  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);

  Map<String, dynamic> toJson() => _$BranchToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

