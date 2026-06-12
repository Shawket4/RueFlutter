//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/shift.dart';
import 'package:sufrix_api/src/model/inventory_count_row.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'close_shift_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CloseShiftResponse {
  /// Returns a new [CloseShiftResponse] instance.
  CloseShiftResponse({

    required  this.inventoryCounts,

    required  this.shift,
  });

  @JsonKey(
    
    name: r'inventory_counts',
    required: true,
    includeIfNull: false,
  )


  final List<InventoryCountRow> inventoryCounts;



  @JsonKey(
    
    name: r'shift',
    required: true,
    includeIfNull: false,
  )


  final Shift shift;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CloseShiftResponse &&
      other.inventoryCounts == inventoryCounts &&
      other.shift == shift;

    @override
    int get hashCode =>
        inventoryCounts.hashCode +
        shift.hashCode;

  factory CloseShiftResponse.fromJson(Map<String, dynamic> json) => _$CloseShiftResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CloseShiftResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

