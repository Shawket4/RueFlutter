//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'preview_ingredient.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PreviewIngredient {
  /// Returns a new [PreviewIngredient] instance.
  PreviewIngredient({

    required  this.category,

    required  this.ingredientName,

     this.orgIngredientId,

    required  this.quantity,

    required  this.source_,

    required  this.unit,
  });

  @JsonKey(
    
    name: r'category',
    required: true,
    includeIfNull: false,
  )


  final String category;



  @JsonKey(
    
    name: r'ingredient_name',
    required: true,
    includeIfNull: false,
  )


  final String ingredientName;



  @JsonKey(
    
    name: r'org_ingredient_id',
    required: false,
    includeIfNull: false,
  )


  final String? orgIngredientId;



  @JsonKey(
    
    name: r'quantity',
    required: true,
    includeIfNull: false,
  )


  final double quantity;



  @JsonKey(
    
    name: r'source',
    required: true,
    includeIfNull: false,
  )


  final String source_;



  @JsonKey(
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PreviewIngredient &&
      other.category == category &&
      other.ingredientName == ingredientName &&
      other.orgIngredientId == orgIngredientId &&
      other.quantity == quantity &&
      other.source_ == source_ &&
      other.unit == unit;

    @override
    int get hashCode =>
        category.hashCode +
        ingredientName.hashCode +
        (orgIngredientId == null ? 0 : orgIngredientId.hashCode) +
        quantity.hashCode +
        source_.hashCode +
        unit.hashCode;

  factory PreviewIngredient.fromJson(Map<String, dynamic> json) => _$PreviewIngredientFromJson(json);

  Map<String, dynamic> toJson() => _$PreviewIngredientToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

