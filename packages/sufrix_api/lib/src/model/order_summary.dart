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

     this.deliveryOrders,

     this.deliveryRevenue,

    required  this.discounts,

     this.inMallFees,

     this.inMallOrders,

     this.inMallRevenue,

     this.outsideFees,

     this.outsideOrders,

     this.outsideRevenue,

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



      /// Count of completed delivery orders.
  @JsonKey(
    
    name: r'delivery_orders',
    required: false,
    includeIfNull: false,
  )


  final int? deliveryOrders;



      /// Gross revenue (total_amount) of completed delivery orders.
  @JsonKey(
    
    name: r'delivery_revenue',
    required: false,
    includeIfNull: false,
  )


  final int? deliveryRevenue;



  @JsonKey(
    
    name: r'discounts',
    required: true,
    includeIfNull: false,
  )


  final int discounts;



  @JsonKey(
    
    name: r'in_mall_fees',
    required: false,
    includeIfNull: false,
  )


  final int? inMallFees;



      /// In-mall channel: order count / gross revenue / delivery fees.
  @JsonKey(
    
    name: r'in_mall_orders',
    required: false,
    includeIfNull: false,
  )


  final int? inMallOrders;



  @JsonKey(
    
    name: r'in_mall_revenue',
    required: false,
    includeIfNull: false,
  )


  final int? inMallRevenue;



  @JsonKey(
    
    name: r'outside_fees',
    required: false,
    includeIfNull: false,
  )


  final int? outsideFees;



      /// Outside channel: order count / gross revenue / delivery fees.
  @JsonKey(
    
    name: r'outside_orders',
    required: false,
    includeIfNull: false,
  )


  final int? outsideOrders;



  @JsonKey(
    
    name: r'outside_revenue',
    required: false,
    includeIfNull: false,
  )


  final int? outsideRevenue;



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
      other.deliveryOrders == deliveryOrders &&
      other.deliveryRevenue == deliveryRevenue &&
      other.discounts == discounts &&
      other.inMallFees == inMallFees &&
      other.inMallOrders == inMallOrders &&
      other.inMallRevenue == inMallRevenue &&
      other.outsideFees == outsideFees &&
      other.outsideOrders == outsideOrders &&
      other.outsideRevenue == outsideRevenue &&
      other.revenue == revenue &&
      other.tips == tips &&
      other.voided == voided;

    @override
    int get hashCode =>
        completed.hashCode +
        deliveryFees.hashCode +
        deliveryOrders.hashCode +
        deliveryRevenue.hashCode +
        discounts.hashCode +
        inMallFees.hashCode +
        inMallOrders.hashCode +
        inMallRevenue.hashCode +
        outsideFees.hashCode +
        outsideOrders.hashCode +
        outsideRevenue.hashCode +
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

