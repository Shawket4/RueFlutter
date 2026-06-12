//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/payment_summary_row.dart';
import 'package:sufrix_api/src/model/shift.dart';
import 'package:sufrix_api/src/model/cash_movement_summary_row.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shift_report_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ShiftReportResponse {
  /// Returns a new [ShiftReportResponse] instance.
  ShiftReportResponse({

    required  this.cashMovements,

    required  this.cashMovementsIn,

    required  this.cashMovementsNet,

    required  this.cashMovementsOut,

    required  this.netPayments,

    required  this.paymentSummary,

    required  this.printedAt,

    required  this.shift,

    required  this.totalPayments,

    required  this.voidedAmount,
  });

  @JsonKey(
    
    name: r'cash_movements',
    required: true,
    includeIfNull: false,
  )


  final List<CashMovementSummaryRow> cashMovements;



  @JsonKey(
    
    name: r'cash_movements_in',
    required: true,
    includeIfNull: false,
  )


  final int cashMovementsIn;



      /// Net of all cash movements (in - out) as a signed integer
  @JsonKey(
    
    name: r'cash_movements_net',
    required: true,
    includeIfNull: false,
  )


  final int cashMovementsNet;



  @JsonKey(
    
    name: r'cash_movements_out',
    required: true,
    includeIfNull: false,
  )


  final int cashMovementsOut;



  @JsonKey(
    
    name: r'net_payments',
    required: true,
    includeIfNull: false,
  )


  final int netPayments;



  @JsonKey(
    
    name: r'payment_summary',
    required: true,
    includeIfNull: false,
  )


  final List<PaymentSummaryRow> paymentSummary;



  @JsonKey(
    
    name: r'printed_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime printedAt;



  @JsonKey(
    
    name: r'shift',
    required: true,
    includeIfNull: false,
  )


  final Shift shift;



  @JsonKey(
    
    name: r'total_payments',
    required: true,
    includeIfNull: false,
  )


  final int totalPayments;



  @JsonKey(
    
    name: r'voided_amount',
    required: true,
    includeIfNull: false,
  )


  final int voidedAmount;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ShiftReportResponse &&
      other.cashMovements == cashMovements &&
      other.cashMovementsIn == cashMovementsIn &&
      other.cashMovementsNet == cashMovementsNet &&
      other.cashMovementsOut == cashMovementsOut &&
      other.netPayments == netPayments &&
      other.paymentSummary == paymentSummary &&
      other.printedAt == printedAt &&
      other.shift == shift &&
      other.totalPayments == totalPayments &&
      other.voidedAmount == voidedAmount;

    @override
    int get hashCode =>
        cashMovements.hashCode +
        cashMovementsIn.hashCode +
        cashMovementsNet.hashCode +
        cashMovementsOut.hashCode +
        netPayments.hashCode +
        paymentSummary.hashCode +
        printedAt.hashCode +
        shift.hashCode +
        totalPayments.hashCode +
        voidedAmount.hashCode;

  factory ShiftReportResponse.fromJson(Map<String, dynamic> json) => _$ShiftReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftReportResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

