//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quote_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class QuoteResponse {
  /// Returns a new [QuoteResponse] instance.
  QuoteResponse({

     this.distanceMeters,

     this.fee,

    required  this.status,

     this.zoneId,

     this.zoneName,
  });

  @JsonKey(
    
    name: r'distance_meters',
    required: false,
    includeIfNull: false,
  )


  final int? distanceMeters;



  @JsonKey(
    
    name: r'fee',
    required: false,
    includeIfNull: false,
  )


  final int? fee;



      /// \"ok\" | \"out_of_range\" | \"unavailable\"
  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final String status;



  @JsonKey(
    
    name: r'zone_id',
    required: false,
    includeIfNull: false,
  )


  final String? zoneId;



  @JsonKey(
    
    name: r'zone_name',
    required: false,
    includeIfNull: false,
  )


  final String? zoneName;





    @override
    bool operator ==(Object other) => identical(this, other) || other is QuoteResponse &&
      other.distanceMeters == distanceMeters &&
      other.fee == fee &&
      other.status == status &&
      other.zoneId == zoneId &&
      other.zoneName == zoneName;

    @override
    int get hashCode =>
        (distanceMeters == null ? 0 : distanceMeters.hashCode) +
        (fee == null ? 0 : fee.hashCode) +
        status.hashCode +
        (zoneId == null ? 0 : zoneId.hashCode) +
        (zoneName == null ? 0 : zoneName.hashCode);

  factory QuoteResponse.fromJson(Map<String, dynamic> json) => _$QuoteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

