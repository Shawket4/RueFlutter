//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_movement_summary_row.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CashMovementSummaryRow {
  /// Returns a new [CashMovementSummaryRow] instance.
  CashMovementSummaryRow({

    required  this.amount,

    required  this.createdAt,

    required  this.movedByName,

    required  this.note,
  });

  @JsonKey(
    
    name: r'amount',
    required: true,
    includeIfNull: false,
  )


  final int amount;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'moved_by_name',
    required: true,
    includeIfNull: false,
  )


  final String movedByName;



  @JsonKey(
    
    name: r'note',
    required: true,
    includeIfNull: false,
  )


  final String note;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CashMovementSummaryRow &&
      other.amount == amount &&
      other.createdAt == createdAt &&
      other.movedByName == movedByName &&
      other.note == note;

    @override
    int get hashCode =>
        amount.hashCode +
        createdAt.hashCode +
        movedByName.hashCode +
        note.hashCode;

  factory CashMovementSummaryRow.fromJson(Map<String, dynamic> json) => _$CashMovementSummaryRowFromJson(json);

  Map<String, dynamic> toJson() => _$CashMovementSummaryRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

