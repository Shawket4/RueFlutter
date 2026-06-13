//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_count_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ItemCountInput {
  /// Returns a new [ItemCountInput] instance.
  ItemCountInput({

    required  this.countedQty,

     this.note,

    required  this.orgIngredientId,

     this.varianceReason,
  });

  @JsonKey(
    
    name: r'counted_qty',
    required: true,
    includeIfNull: false,
  )


  final double countedQty;



  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;



  @JsonKey(
    
    name: r'org_ingredient_id',
    required: true,
    includeIfNull: false,
  )


  final String orgIngredientId;



      /// Why the count differs from expected. One of: theft | spoilage | breakage | miscount | supplier_short | transfer_error | other. Required at finalize for rows whose difference exceeds the org's variance threshold.
  @JsonKey(
    
    name: r'variance_reason',
    required: false,
    includeIfNull: false,
  )


  final String? varianceReason;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ItemCountInput &&
      other.countedQty == countedQty &&
      other.note == note &&
      other.orgIngredientId == orgIngredientId &&
      other.varianceReason == varianceReason;

    @override
    int get hashCode =>
        countedQty.hashCode +
        (note == null ? 0 : note.hashCode) +
        orgIngredientId.hashCode +
        (varianceReason == null ? 0 : varianceReason.hashCode);

  factory ItemCountInput.fromJson(Map<String, dynamic> json) => _$ItemCountInputFromJson(json);

  Map<String, dynamic> toJson() => _$ItemCountInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

