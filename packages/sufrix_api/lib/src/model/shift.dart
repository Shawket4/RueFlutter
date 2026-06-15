//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shift.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Shift {
  /// Returns a new [Shift] instance.
  Shift({

    required  this.branchId,

     this.branchName,

     this.cashDiscrepancy,

     this.closedAt,

     this.closedBy,

     this.closingCashDeclared,

     this.closingCashSystem,

     this.forceCloseReason,

     this.forceClosedAt,

     this.forceClosedBy,

    required  this.id,

     this.notes,

    required  this.openedAt,

    required  this.openingCash,

     this.openingCashEditReason,

     this.openingCashOriginal,

    required  this.openingCashWasEdited,

    required  this.status,

    required  this.tellerId,

    required  this.tellerName,
  });

  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



      /// Branch label — only populated by the shifts list (so the \"All branches\" view can show which branch each shift belongs to). Other shift endpoints leave it `null`.
  @JsonKey(
    
    name: r'branch_name',
    required: false,
    includeIfNull: false,
  )


  final String? branchName;



  @JsonKey(
    
    name: r'cash_discrepancy',
    required: false,
    includeIfNull: false,
  )


  final int? cashDiscrepancy;



  @JsonKey(
    
    name: r'closed_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? closedAt;



  @JsonKey(
    
    name: r'closed_by',
    required: false,
    includeIfNull: false,
  )


  final String? closedBy;



  @JsonKey(
    
    name: r'closing_cash_declared',
    required: false,
    includeIfNull: false,
  )


  final int? closingCashDeclared;



  @JsonKey(
    
    name: r'closing_cash_system',
    required: false,
    includeIfNull: false,
  )


  final int? closingCashSystem;



  @JsonKey(
    
    name: r'force_close_reason',
    required: false,
    includeIfNull: false,
  )


  final String? forceCloseReason;



  @JsonKey(
    
    name: r'force_closed_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? forceClosedAt;



  @JsonKey(
    
    name: r'force_closed_by',
    required: false,
    includeIfNull: false,
  )


  final String? forceClosedBy;



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
    
    name: r'opened_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime openedAt;



  @JsonKey(
    
    name: r'opening_cash',
    required: true,
    includeIfNull: false,
  )


  final int openingCash;



  @JsonKey(
    
    name: r'opening_cash_edit_reason',
    required: false,
    includeIfNull: false,
  )


  final String? openingCashEditReason;



  @JsonKey(
    
    name: r'opening_cash_original',
    required: false,
    includeIfNull: false,
  )


  final int? openingCashOriginal;



  @JsonKey(
    
    name: r'opening_cash_was_edited',
    required: true,
    includeIfNull: false,
  )


  final bool openingCashWasEdited;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final String status;



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





    @override
    bool operator ==(Object other) => identical(this, other) || other is Shift &&
      other.branchId == branchId &&
      other.branchName == branchName &&
      other.cashDiscrepancy == cashDiscrepancy &&
      other.closedAt == closedAt &&
      other.closedBy == closedBy &&
      other.closingCashDeclared == closingCashDeclared &&
      other.closingCashSystem == closingCashSystem &&
      other.forceCloseReason == forceCloseReason &&
      other.forceClosedAt == forceClosedAt &&
      other.forceClosedBy == forceClosedBy &&
      other.id == id &&
      other.notes == notes &&
      other.openedAt == openedAt &&
      other.openingCash == openingCash &&
      other.openingCashEditReason == openingCashEditReason &&
      other.openingCashOriginal == openingCashOriginal &&
      other.openingCashWasEdited == openingCashWasEdited &&
      other.status == status &&
      other.tellerId == tellerId &&
      other.tellerName == tellerName;

    @override
    int get hashCode =>
        branchId.hashCode +
        (branchName == null ? 0 : branchName.hashCode) +
        (cashDiscrepancy == null ? 0 : cashDiscrepancy.hashCode) +
        (closedAt == null ? 0 : closedAt.hashCode) +
        (closedBy == null ? 0 : closedBy.hashCode) +
        (closingCashDeclared == null ? 0 : closingCashDeclared.hashCode) +
        (closingCashSystem == null ? 0 : closingCashSystem.hashCode) +
        (forceCloseReason == null ? 0 : forceCloseReason.hashCode) +
        (forceClosedAt == null ? 0 : forceClosedAt.hashCode) +
        (forceClosedBy == null ? 0 : forceClosedBy.hashCode) +
        id.hashCode +
        (notes == null ? 0 : notes.hashCode) +
        openedAt.hashCode +
        openingCash.hashCode +
        (openingCashEditReason == null ? 0 : openingCashEditReason.hashCode) +
        (openingCashOriginal == null ? 0 : openingCashOriginal.hashCode) +
        openingCashWasEdited.hashCode +
        status.hashCode +
        tellerId.hashCode +
        tellerName.hashCode;

  factory Shift.fromJson(Map<String, dynamic> json) => _$ShiftFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

