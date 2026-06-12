//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_movement_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CashMovementRequest {
  /// Returns a new [CashMovementRequest] instance.
  CashMovementRequest({

    required  this.amount,

    required  this.note,
  });

  @JsonKey(
    
    name: r'amount',
    required: true,
    includeIfNull: false,
  )


  final int amount;



  @JsonKey(
    
    name: r'note',
    required: true,
    includeIfNull: false,
  )


  final String note;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CashMovementRequest &&
      other.amount == amount &&
      other.note == note;

    @override
    int get hashCode =>
        amount.hashCode +
        note.hashCode;

  factory CashMovementRequest.fromJson(Map<String, dynamic> json) => _$CashMovementRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CashMovementRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

