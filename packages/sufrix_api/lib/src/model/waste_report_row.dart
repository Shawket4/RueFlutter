//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'waste_report_row.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class WasteReportRow {
  /// Returns a new [WasteReportRow] instance.
  WasteReportRow({

    required  this.ingredientName,

    required  this.orgIngredientId,

    required  this.reason,

    required  this.unit,

    required  this.wasteQty,

     this.wasteValue,
  });

  @JsonKey(
    
    name: r'ingredient_name',
    required: true,
    includeIfNull: false,
  )


  final String ingredientName;



  @JsonKey(
    
    name: r'org_ingredient_id',
    required: true,
    includeIfNull: false,
  )


  final String orgIngredientId;



  @JsonKey(
    
    name: r'reason',
    required: true,
    includeIfNull: false,
  )


  final String reason;



  @JsonKey(
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;



  @JsonKey(
    
    name: r'waste_qty',
    required: true,
    includeIfNull: false,
  )


  final double wasteQty;



  @JsonKey(
    
    name: r'waste_value',
    required: false,
    includeIfNull: false,
  )


  final int? wasteValue;





    @override
    bool operator ==(Object other) => identical(this, other) || other is WasteReportRow &&
      other.ingredientName == ingredientName &&
      other.orgIngredientId == orgIngredientId &&
      other.reason == reason &&
      other.unit == unit &&
      other.wasteQty == wasteQty &&
      other.wasteValue == wasteValue;

    @override
    int get hashCode =>
        ingredientName.hashCode +
        orgIngredientId.hashCode +
        reason.hashCode +
        unit.hashCode +
        wasteQty.hashCode +
        (wasteValue == null ? 0 : wasteValue.hashCode);

  factory WasteReportRow.fromJson(Map<String, dynamic> json) => _$WasteReportRowFromJson(json);

  Map<String, dynamic> toJson() => _$WasteReportRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

