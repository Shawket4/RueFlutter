//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/printer_brand.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_branch_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateBranchRequest {
  /// Returns a new [CreateBranchRequest] instance.
  CreateBranchRequest({

     this.address,

     this.geoRadiusMeters,

     this.latitude,

     this.longitude,

    required  this.name,

    required  this.orgId,

     this.phone,

     this.printerBrand,

     this.printerIp,

     this.printerPort,

     this.timezone,
  });

  @JsonKey(
    
    name: r'address',
    required: false,
    includeIfNull: false,
  )


  final String? address;



      /// Geofence radius in meters. Defaults to 200.
  @JsonKey(
    
    name: r'geo_radius_meters',
    required: false,
    includeIfNull: false,
  )


  final int? geoRadiusMeters;



  @JsonKey(
    
    name: r'latitude',
    required: false,
    includeIfNull: false,
  )


  final double? latitude;



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



      /// TCP port for the receipt printer. Defaults to `9100` if absent.
  @JsonKey(
    
    name: r'printer_port',
    required: false,
    includeIfNull: false,
  )


  final int? printerPort;



      /// IANA timezone name. Defaults to `Africa/Cairo` if absent.
  @JsonKey(
    
    name: r'timezone',
    required: false,
    includeIfNull: false,
  )


  final String? timezone;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateBranchRequest &&
      other.address == address &&
      other.geoRadiusMeters == geoRadiusMeters &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.name == name &&
      other.orgId == orgId &&
      other.phone == phone &&
      other.printerBrand == printerBrand &&
      other.printerIp == printerIp &&
      other.printerPort == printerPort &&
      other.timezone == timezone;

    @override
    int get hashCode =>
        (address == null ? 0 : address.hashCode) +
        (geoRadiusMeters == null ? 0 : geoRadiusMeters.hashCode) +
        (latitude == null ? 0 : latitude.hashCode) +
        (longitude == null ? 0 : longitude.hashCode) +
        name.hashCode +
        orgId.hashCode +
        (phone == null ? 0 : phone.hashCode) +
        (printerBrand == null ? 0 : printerBrand.hashCode) +
        (printerIp == null ? 0 : printerIp.hashCode) +
        (printerPort == null ? 0 : printerPort.hashCode) +
        (timezone == null ? 0 : timezone.hashCode);

  factory CreateBranchRequest.fromJson(Map<String, dynamic> json) => _$CreateBranchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBranchRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

