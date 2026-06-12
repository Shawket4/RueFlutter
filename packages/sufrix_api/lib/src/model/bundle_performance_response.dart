//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/component_popularity.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bundle_performance_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BundlePerformanceResponse {
  /// Returns a new [BundlePerformanceResponse] instance.
  BundlePerformanceResponse({

    required  this.componentPopularity,

    required  this.grossRevenue,

    required  this.netProfit,

    required  this.salesVolume,
  });

  @JsonKey(
    
    name: r'component_popularity',
    required: true,
    includeIfNull: false,
  )


  final List<ComponentPopularity> componentPopularity;



  @JsonKey(
    
    name: r'gross_revenue',
    required: true,
    includeIfNull: false,
  )


  final int grossRevenue;



  @JsonKey(
    
    name: r'net_profit',
    required: true,
    includeIfNull: false,
  )


  final int netProfit;



  @JsonKey(
    
    name: r'sales_volume',
    required: true,
    includeIfNull: false,
  )


  final int salesVolume;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BundlePerformanceResponse &&
      other.componentPopularity == componentPopularity &&
      other.grossRevenue == grossRevenue &&
      other.netProfit == netProfit &&
      other.salesVolume == salesVolume;

    @override
    int get hashCode =>
        componentPopularity.hashCode +
        grossRevenue.hashCode +
        netProfit.hashCode +
        salesVolume.hashCode;

  factory BundlePerformanceResponse.fromJson(Map<String, dynamic> json) => _$BundlePerformanceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BundlePerformanceResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

