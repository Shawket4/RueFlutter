//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/shift.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shift_pre_fill.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ShiftPreFill {
  /// Returns a new [ShiftPreFill] instance.
  ShiftPreFill({

    required  this.hasOpenShift,

     this.openShift,

    required  this.suggestedOpeningCash,
  });

  @JsonKey(
    
    name: r'has_open_shift',
    required: true,
    includeIfNull: false,
  )


  final bool hasOpenShift;



  @JsonKey(
    
    name: r'open_shift',
    required: false,
    includeIfNull: false,
  )


  final Shift? openShift;



  @JsonKey(
    
    name: r'suggested_opening_cash',
    required: true,
    includeIfNull: false,
  )


  final int suggestedOpeningCash;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ShiftPreFill &&
      other.hasOpenShift == hasOpenShift &&
      other.openShift == openShift &&
      other.suggestedOpeningCash == suggestedOpeningCash;

    @override
    int get hashCode =>
        hasOpenShift.hashCode +
        (openShift == null ? 0 : openShift.hashCode) +
        suggestedOpeningCash.hashCode;

  factory ShiftPreFill.fromJson(Map<String, dynamic> json) => _$ShiftPreFillFromJson(json);

  Map<String, dynamic> toJson() => _$ShiftPreFillToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

