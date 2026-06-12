//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/printer_brand.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_branch_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateBranchRequest {
  /// Returns a new [UpdateBranchRequest] instance.
  UpdateBranchRequest({

     this.address,

     this.geoRadiusMeters,

     this.isActive,

     this.latitude,

     this.longitude,

     this.name,

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



  @JsonKey(
    
    name: r'geo_radius_meters',
    required: false,
    includeIfNull: false,
  )


  final int? geoRadiusMeters;



  @JsonKey(
    
    name: r'is_active',
    required: false,
    includeIfNull: false,
  )


  final bool? isActive;



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
    required: false,
    includeIfNull: false,
  )


  final String? name;



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



  @JsonKey(
    
    name: r'timezone',
    required: false,
    includeIfNull: false,
  )


  final String? timezone;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpdateBranchRequest &&
      other.address == address &&
      other.geoRadiusMeters == geoRadiusMeters &&
      other.isActive == isActive &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.name == name &&
      other.phone == phone &&
      other.printerBrand == printerBrand &&
      other.printerIp == printerIp &&
      other.printerPort == printerPort &&
      other.timezone == timezone;

    @override
    int get hashCode =>
        (address == null ? 0 : address.hashCode) +
        (geoRadiusMeters == null ? 0 : geoRadiusMeters.hashCode) +
        (isActive == null ? 0 : isActive.hashCode) +
        (latitude == null ? 0 : latitude.hashCode) +
        (longitude == null ? 0 : longitude.hashCode) +
        (name == null ? 0 : name.hashCode) +
        (phone == null ? 0 : phone.hashCode) +
        (printerBrand == null ? 0 : printerBrand.hashCode) +
        (printerIp == null ? 0 : printerIp.hashCode) +
        (printerPort == null ? 0 : printerPort.hashCode) +
        (timezone == null ? 0 : timezone.hashCode);

  factory UpdateBranchRequest.fromJson(Map<String, dynamic> json) => _$UpdateBranchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateBranchRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

