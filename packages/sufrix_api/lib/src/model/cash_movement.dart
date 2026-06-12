//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_movement.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CashMovement {
  /// Returns a new [CashMovement] instance.
  CashMovement({

    required  this.amount,

    required  this.createdAt,

    required  this.id,

    required  this.movedBy,

    required  this.movedByName,

    required  this.note,

    required  this.shiftId,
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
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'moved_by',
    required: true,
    includeIfNull: false,
  )


  final String movedBy;



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



  @JsonKey(
    
    name: r'shift_id',
    required: true,
    includeIfNull: false,
  )


  final String shiftId;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CashMovement &&
      other.amount == amount &&
      other.createdAt == createdAt &&
      other.id == id &&
      other.movedBy == movedBy &&
      other.movedByName == movedByName &&
      other.note == note &&
      other.shiftId == shiftId;

    @override
    int get hashCode =>
        amount.hashCode +
        createdAt.hashCode +
        id.hashCode +
        movedBy.hashCode +
        movedByName.hashCode +
        note.hashCode +
        shiftId.hashCode;

  factory CashMovement.fromJson(Map<String, dynamic> json) => _$CashMovementFromJson(json);

  Map<String, dynamic> toJson() => _$CashMovementToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

