//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/inventory_count_input.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'close_shift_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CloseShiftRequest {
  /// Returns a new [CloseShiftRequest] instance.
  CloseShiftRequest({

     this.cashNote,

     this.closedAt,

    required  this.closingCashDeclared,

    required  this.inventoryCounts,
  });

  @JsonKey(
    
    name: r'cash_note',
    required: false,
    includeIfNull: false,
  )


  final String? cashNote;



  @JsonKey(
    
    name: r'closed_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? closedAt;



  @JsonKey(
    
    name: r'closing_cash_declared',
    required: true,
    includeIfNull: false,
  )


  final int closingCashDeclared;



  @JsonKey(
    
    name: r'inventory_counts',
    required: true,
    includeIfNull: false,
  )


  final List<InventoryCountInput> inventoryCounts;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CloseShiftRequest &&
      other.cashNote == cashNote &&
      other.closedAt == closedAt &&
      other.closingCashDeclared == closingCashDeclared &&
      other.inventoryCounts == inventoryCounts;

    @override
    int get hashCode =>
        (cashNote == null ? 0 : cashNote.hashCode) +
        (closedAt == null ? 0 : closedAt.hashCode) +
        closingCashDeclared.hashCode +
        inventoryCounts.hashCode;

  factory CloseShiftRequest.fromJson(Map<String, dynamic> json) => _$CloseShiftRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CloseShiftRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

