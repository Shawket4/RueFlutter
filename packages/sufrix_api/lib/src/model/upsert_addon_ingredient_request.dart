//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upsert_addon_ingredient_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpsertAddonIngredientRequest {
  /// Returns a new [UpsertAddonIngredientRequest] instance.
  UpsertAddonIngredientRequest({

    required  this.ingredientName,

    required  this.ingredientUnit,

     this.orgIngredientId,

    required  this.quantityUsed,
  });

  @JsonKey(
    
    name: r'ingredient_name',
    required: true,
    includeIfNull: false,
  )


  final String ingredientName;



  @JsonKey(
    
    name: r'ingredient_unit',
    required: true,
    includeIfNull: false,
  )


  final String ingredientUnit;



  @JsonKey(
    
    name: r'org_ingredient_id',
    required: false,
    includeIfNull: false,
  )


  final String? orgIngredientId;



  @JsonKey(
    
    name: r'quantity_used',
    required: true,
    includeIfNull: false,
  )


  final double quantityUsed;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpsertAddonIngredientRequest &&
      other.ingredientName == ingredientName &&
      other.ingredientUnit == ingredientUnit &&
      other.orgIngredientId == orgIngredientId &&
      other.quantityUsed == quantityUsed;

    @override
    int get hashCode =>
        ingredientName.hashCode +
        ingredientUnit.hashCode +
        (orgIngredientId == null ? 0 : orgIngredientId.hashCode) +
        quantityUsed.hashCode;

  factory UpsertAddonIngredientRequest.fromJson(Map<String, dynamic> json) => _$UpsertAddonIngredientRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpsertAddonIngredientRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

