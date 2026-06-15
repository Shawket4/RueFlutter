//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_summary.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderSummary {
  /// Returns a new [OrderSummary] instance.
  OrderSummary({

    required  this.completed,

     this.deliveryFees,

    required  this.discounts,

    required  this.revenue,

    required  this.tips,

    required  this.voided,
  });

  @JsonKey(
    
    name: r'completed',
    required: true,
    includeIfNull: false,
  )


  final int completed;



      /// Total delivery charges (piastres) across completed orders in scope. Lets the dashboard surface delivery revenue separately from item sales.
  @JsonKey(
    
    name: r'delivery_fees',
    required: false,
    includeIfNull: false,
  )


  final int? deliveryFees;



  @JsonKey(
    
    name: r'discounts',
    required: true,
    includeIfNull: false,
  )


  final int discounts;



  @JsonKey(
    
    name: r'revenue',
    required: true,
    includeIfNull: false,
  )


  final int revenue;



  @JsonKey(
    
    name: r'tips',
    required: true,
    includeIfNull: false,
  )


  final int tips;



  @JsonKey(
    
    name: r'voided',
    required: true,
    includeIfNull: false,
  )


  final int voided;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrderSummary &&
      other.completed == completed &&
      other.deliveryFees == deliveryFees &&
      other.discounts == discounts &&
      other.revenue == revenue &&
      other.tips == tips &&
      other.voided == voided;

    @override
    int get hashCode =>
        completed.hashCode +
        deliveryFees.hashCode +
        discounts.hashCode +
        revenue.hashCode +
        tips.hashCode +
        voided.hashCode;

  factory OrderSummary.fromJson(Map<String, dynamic> json) => _$OrderSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$OrderSummaryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

