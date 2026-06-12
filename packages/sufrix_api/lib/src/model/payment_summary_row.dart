//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_summary_row.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PaymentSummaryRow {
  /// Returns a new [PaymentSummaryRow] instance.
  PaymentSummaryRow({

    required  this.isCash,

    required  this.orderCount,

    required  this.paymentMethod,

    required  this.total,
  });

  @JsonKey(
    
    name: r'is_cash',
    required: true,
    includeIfNull: false,
  )


  final bool isCash;



  @JsonKey(
    
    name: r'order_count',
    required: true,
    includeIfNull: false,
  )


  final int orderCount;



  @JsonKey(
    
    name: r'payment_method',
    required: true,
    includeIfNull: false,
  )


  final String paymentMethod;



  @JsonKey(
    
    name: r'total',
    required: true,
    includeIfNull: false,
  )


  final int total;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PaymentSummaryRow &&
      other.isCash == isCash &&
      other.orderCount == orderCount &&
      other.paymentMethod == paymentMethod &&
      other.total == total;

    @override
    int get hashCode =>
        isCash.hashCode +
        orderCount.hashCode +
        paymentMethod.hashCode +
        total.hashCode;

  factory PaymentSummaryRow.fromJson(Map<String, dynamic> json) => _$PaymentSummaryRowFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentSummaryRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

