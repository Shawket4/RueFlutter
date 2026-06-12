//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'timeseries_point.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TimeseriesPoint {
  /// Returns a new [TimeseriesPoint] instance.
  TimeseriesPoint({

    required  this.discount,

    required  this.orders,

    required  this.period,

    required  this.revenue,

    required  this.revenueByMethod,

    required  this.tax,

    required  this.voided,
  });

  @JsonKey(
    
    name: r'discount',
    required: true,
    includeIfNull: false,
  )


  final int discount;



  @JsonKey(
    
    name: r'orders',
    required: true,
    includeIfNull: false,
  )


  final int orders;



  @JsonKey(
    
    name: r'period',
    required: true,
    includeIfNull: false,
  )


  final String period;



  @JsonKey(
    
    name: r'revenue',
    required: true,
    includeIfNull: false,
  )


  final int revenue;



  @JsonKey(
    
    name: r'revenue_by_method',
    required: true,
    includeIfNull: true,
  )


  final Object? revenueByMethod;



  @JsonKey(
    
    name: r'tax',
    required: true,
    includeIfNull: false,
  )


  final int tax;



  @JsonKey(
    
    name: r'voided',
    required: true,
    includeIfNull: false,
  )


  final int voided;





    @override
    bool operator ==(Object other) => identical(this, other) || other is TimeseriesPoint &&
      other.discount == discount &&
      other.orders == orders &&
      other.period == period &&
      other.revenue == revenue &&
      other.revenueByMethod == revenueByMethod &&
      other.tax == tax &&
      other.voided == voided;

    @override
    int get hashCode =>
        discount.hashCode +
        orders.hashCode +
        period.hashCode +
        revenue.hashCode +
        (revenueByMethod == null ? 0 : revenueByMethod.hashCode) +
        tax.hashCode +
        voided.hashCode;

  factory TimeseriesPoint.fromJson(Map<String, dynamic> json) => _$TimeseriesPointFromJson(json);

  Map<String, dynamic> toJson() => _$TimeseriesPointToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

