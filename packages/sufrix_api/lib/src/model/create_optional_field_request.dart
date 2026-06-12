//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_optional_field_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateOptionalFieldRequest {
  /// Returns a new [CreateOptionalFieldRequest] instance.
  CreateOptionalFieldRequest({

     this.displayOrder,

     this.ingredientName,

     this.ingredientUnit,

    required  this.name,

     this.nameTranslations,

     this.orgIngredientId,

     this.price,

     this.quantityUsed,

     this.sizeLabel,
  });

  @JsonKey(
    
    name: r'display_order',
    required: false,
    includeIfNull: false,
  )


  final int? displayOrder;



  @JsonKey(
    
    name: r'ingredient_name',
    required: false,
    includeIfNull: false,
  )


  final String? ingredientName;



  @JsonKey(
    
    name: r'ingredient_unit',
    required: false,
    includeIfNull: false,
  )


  final String? ingredientUnit;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'name_translations',
    required: false,
    includeIfNull: false,
  )


  final Object? nameTranslations;



  @JsonKey(
    
    name: r'org_ingredient_id',
    required: false,
    includeIfNull: false,
  )


  final String? orgIngredientId;



  @JsonKey(
    
    name: r'price',
    required: false,
    includeIfNull: false,
  )


  final int? price;



  @JsonKey(
    
    name: r'quantity_used',
    required: false,
    includeIfNull: false,
  )


  final double? quantityUsed;



  @JsonKey(
    
    name: r'size_label',
    required: false,
    includeIfNull: false,
  )


  final String? sizeLabel;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateOptionalFieldRequest &&
      other.displayOrder == displayOrder &&
      other.ingredientName == ingredientName &&
      other.ingredientUnit == ingredientUnit &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.orgIngredientId == orgIngredientId &&
      other.price == price &&
      other.quantityUsed == quantityUsed &&
      other.sizeLabel == sizeLabel;

    @override
    int get hashCode =>
        (displayOrder == null ? 0 : displayOrder.hashCode) +
        (ingredientName == null ? 0 : ingredientName.hashCode) +
        (ingredientUnit == null ? 0 : ingredientUnit.hashCode) +
        name.hashCode +
        (nameTranslations == null ? 0 : nameTranslations.hashCode) +
        (orgIngredientId == null ? 0 : orgIngredientId.hashCode) +
        (price == null ? 0 : price.hashCode) +
        (quantityUsed == null ? 0 : quantityUsed.hashCode) +
        (sizeLabel == null ? 0 : sizeLabel.hashCode);

  factory CreateOptionalFieldRequest.fromJson(Map<String, dynamic> json) => _$CreateOptionalFieldRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOptionalFieldRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

