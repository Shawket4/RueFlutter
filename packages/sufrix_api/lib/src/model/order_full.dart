//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/order_item_full.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_full.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderFull {
  /// Returns a new [OrderFull] instance.
  OrderFull({

     this.amountTendered,

    required  this.branchId,

     this.changeGiven,

    required  this.createdAt,

     this.customerName,

    required  this.discountAmount,

     this.discountId,

     this.discountType,

    required  this.discountValue,

    required  this.id,

     this.notes,

    required  this.orderNumber,

     this.orderRef,

    required  this.paymentMethod,

    required  this.shiftId,

    required  this.status,

    required  this.subtotal,

    required  this.taxAmount,

    required  this.tellerId,

    required  this.tellerName,

     this.tipAmount,

     this.tipPaymentMethod,

    required  this.totalAmount,

     this.voidNote,

     this.voidReason,

     this.voidedAt,

     this.voidedBy,

    required  this.items,

     this.warnings,
  });

  @JsonKey(
    
    name: r'amount_tendered',
    required: false,
    includeIfNull: false,
  )


  final int? amountTendered;



  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



  @JsonKey(
    
    name: r'change_given',
    required: false,
    includeIfNull: false,
  )


  final int? changeGiven;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'customer_name',
    required: false,
    includeIfNull: false,
  )


  final String? customerName;



  @JsonKey(
    
    name: r'discount_amount',
    required: true,
    includeIfNull: false,
  )


  final int discountAmount;



  @JsonKey(
    
    name: r'discount_id',
    required: false,
    includeIfNull: false,
  )


  final String? discountId;



  @JsonKey(
    
    name: r'discount_type',
    required: false,
    includeIfNull: false,
  )


  final String? discountType;



  @JsonKey(
    
    name: r'discount_value',
    required: true,
    includeIfNull: false,
  )


  final int discountValue;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'notes',
    required: false,
    includeIfNull: false,
  )


  final String? notes;



  @JsonKey(
    
    name: r'order_number',
    required: true,
    includeIfNull: false,
  )


  final int orderNumber;



      /// Human-readable, org-unique reference (e.g. \"DT-260614-0042\"). Additive alongside the per-shift order_number. Optional only during the rollout window before the historical backfill runs; never null afterwards.
  @JsonKey(
    
    name: r'order_ref',
    required: false,
    includeIfNull: false,
  )


  final String? orderRef;



  @JsonKey(
    
    name: r'payment_method',
    required: true,
    includeIfNull: false,
  )


  final String paymentMethod;



  @JsonKey(
    
    name: r'shift_id',
    required: true,
    includeIfNull: false,
  )


  final String shiftId;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final String status;



  @JsonKey(
    
    name: r'subtotal',
    required: true,
    includeIfNull: false,
  )


  final int subtotal;



  @JsonKey(
    
    name: r'tax_amount',
    required: true,
    includeIfNull: false,
  )


  final int taxAmount;



  @JsonKey(
    
    name: r'teller_id',
    required: true,
    includeIfNull: false,
  )


  final String tellerId;



  @JsonKey(
    
    name: r'teller_name',
    required: true,
    includeIfNull: false,
  )


  final String tellerName;



  @JsonKey(
    
    name: r'tip_amount',
    required: false,
    includeIfNull: false,
  )


  final int? tipAmount;



  @JsonKey(
    
    name: r'tip_payment_method',
    required: false,
    includeIfNull: false,
  )


  final String? tipPaymentMethod;



  @JsonKey(
    
    name: r'total_amount',
    required: true,
    includeIfNull: false,
  )


  final int totalAmount;



  @JsonKey(
    
    name: r'void_note',
    required: false,
    includeIfNull: false,
  )


  final String? voidNote;



  @JsonKey(
    
    name: r'void_reason',
    required: false,
    includeIfNull: false,
  )


  final String? voidReason;



  @JsonKey(
    
    name: r'voided_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? voidedAt;



  @JsonKey(
    
    name: r'voided_by',
    required: false,
    includeIfNull: false,
  )


  final String? voidedBy;



  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<OrderItemFull> items;



      /// Non-fatal warnings raised while placing the order — currently used to flag ingredients that were oversold (stock driven below zero). Empty for reads/refunds.
  @JsonKey(
    
    name: r'warnings',
    required: false,
    includeIfNull: false,
  )


  final List<String>? warnings;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrderFull &&
      other.amountTendered == amountTendered &&
      other.branchId == branchId &&
      other.changeGiven == changeGiven &&
      other.createdAt == createdAt &&
      other.customerName == customerName &&
      other.discountAmount == discountAmount &&
      other.discountId == discountId &&
      other.discountType == discountType &&
      other.discountValue == discountValue &&
      other.id == id &&
      other.notes == notes &&
      other.orderNumber == orderNumber &&
      other.orderRef == orderRef &&
      other.paymentMethod == paymentMethod &&
      other.shiftId == shiftId &&
      other.status == status &&
      other.subtotal == subtotal &&
      other.taxAmount == taxAmount &&
      other.tellerId == tellerId &&
      other.tellerName == tellerName &&
      other.tipAmount == tipAmount &&
      other.tipPaymentMethod == tipPaymentMethod &&
      other.totalAmount == totalAmount &&
      other.voidNote == voidNote &&
      other.voidReason == voidReason &&
      other.voidedAt == voidedAt &&
      other.voidedBy == voidedBy &&
      other.items == items &&
      other.warnings == warnings;

    @override
    int get hashCode =>
        amountTendered.hashCode +
        branchId.hashCode +
        changeGiven.hashCode +
        createdAt.hashCode +
        customerName.hashCode +
        discountAmount.hashCode +
        discountId.hashCode +
        discountType.hashCode +
        discountValue.hashCode +
        id.hashCode +
        notes.hashCode +
        orderNumber.hashCode +
        orderRef.hashCode +
        paymentMethod.hashCode +
        shiftId.hashCode +
        status.hashCode +
        subtotal.hashCode +
        taxAmount.hashCode +
        tellerId.hashCode +
        tellerName.hashCode +
        tipAmount.hashCode +
        tipPaymentMethod.hashCode +
        totalAmount.hashCode +
        voidNote.hashCode +
        voidReason.hashCode +
        voidedAt.hashCode +
        voidedBy.hashCode +
        items.hashCode +
        warnings.hashCode;

  factory OrderFull.fromJson(Map<String, dynamic> json) => _$OrderFullFromJson(json);

  Map<String, dynamic> toJson() => _$OrderFullToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

