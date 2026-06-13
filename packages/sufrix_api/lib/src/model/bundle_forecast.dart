//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/triplet.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bundle_forecast.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BundleForecast {
  /// Returns a new [BundleForecast] instance.
  BundleForecast({

    required  this.expectedVelocity,

    required  this.haloUnitsX,

     this.incrementalCm,

    required  this.insideBundleUnitsX,

    required  this.totalUnitsUpliftX,
  });

  @JsonKey(
    
    name: r'expected_velocity',
    required: true,
    includeIfNull: false,
  )


  final Triplet expectedVelocity;



  @JsonKey(
    
    name: r'halo_units_x',
    required: true,
    includeIfNull: false,
  )


  final double haloUnitsX;



      /// `None` when any component is cost-missing — CM math is impossible.
  @JsonKey(
    
    name: r'incremental_cm',
    required: false,
    includeIfNull: false,
  )


  final Triplet? incrementalCm;



  @JsonKey(
    
    name: r'inside_bundle_units_x',
    required: true,
    includeIfNull: false,
  )


  final double insideBundleUnitsX;



  @JsonKey(
    
    name: r'total_units_uplift_x',
    required: true,
    includeIfNull: false,
  )


  final double totalUnitsUpliftX;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BundleForecast &&
      other.expectedVelocity == expectedVelocity &&
      other.haloUnitsX == haloUnitsX &&
      other.incrementalCm == incrementalCm &&
      other.insideBundleUnitsX == insideBundleUnitsX &&
      other.totalUnitsUpliftX == totalUnitsUpliftX;

    @override
    int get hashCode =>
        expectedVelocity.hashCode +
        haloUnitsX.hashCode +
        (incrementalCm == null ? 0 : incrementalCm.hashCode) +
        insideBundleUnitsX.hashCode +
        totalUnitsUpliftX.hashCode;

  factory BundleForecast.fromJson(Map<String, dynamic> json) => _$BundleForecastFromJson(json);

  Map<String, dynamic> toJson() => _$BundleForecastToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

