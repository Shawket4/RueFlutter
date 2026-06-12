//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upsert_addon_override_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpsertAddonOverrideRequest {
  /// Returns a new [UpsertAddonOverrideRequest] instance.
  UpsertAddonOverrideRequest({

    required  this.addonItemId,

     this.comboAddonItemId,

    required  this.ingredientName,

    required  this.ingredientUnit,

     this.orgIngredientId,

    required  this.quantityUsed,

     this.replacesOrgIngredientId,

     this.sizeLabel,
  });

  @JsonKey(
    
    name: r'addon_item_id',
    required: true,
    includeIfNull: false,
  )


  final String addonItemId;



  @JsonKey(
    
    name: r'combo_addon_item_id',
    required: false,
    includeIfNull: false,
  )


  final String? comboAddonItemId;



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



  @JsonKey(
    
    name: r'replaces_org_ingredient_id',
    required: false,
    includeIfNull: false,
  )


  final String? replacesOrgIngredientId;



  @JsonKey(
    
    name: r'size_label',
    required: false,
    includeIfNull: false,
  )


  final String? sizeLabel;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpsertAddonOverrideRequest &&
      other.addonItemId == addonItemId &&
      other.comboAddonItemId == comboAddonItemId &&
      other.ingredientName == ingredientName &&
      other.ingredientUnit == ingredientUnit &&
      other.orgIngredientId == orgIngredientId &&
      other.quantityUsed == quantityUsed &&
      other.replacesOrgIngredientId == replacesOrgIngredientId &&
      other.sizeLabel == sizeLabel;

    @override
    int get hashCode =>
        addonItemId.hashCode +
        (comboAddonItemId == null ? 0 : comboAddonItemId.hashCode) +
        ingredientName.hashCode +
        ingredientUnit.hashCode +
        (orgIngredientId == null ? 0 : orgIngredientId.hashCode) +
        quantityUsed.hashCode +
        (replacesOrgIngredientId == null ? 0 : replacesOrgIngredientId.hashCode) +
        (sizeLabel == null ? 0 : sizeLabel.hashCode);

  factory UpsertAddonOverrideRequest.fromJson(Map<String, dynamic> json) => _$UpsertAddonOverrideRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpsertAddonOverrideRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

