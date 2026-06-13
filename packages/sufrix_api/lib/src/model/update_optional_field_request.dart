//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_optional_field_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateOptionalFieldRequest {
  /// Returns a new [UpdateOptionalFieldRequest] instance.
  UpdateOptionalFieldRequest({

     this.ingredientName,

     this.ingredientUnit,

     this.isActive,

     this.name,

     this.nameTranslations,

     this.orgIngredientId,

     this.price,

     this.quantityUsed,

     this.sizeLabel,
  });

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
    
    name: r'is_active',
    required: false,
    includeIfNull: false,
  )


  final bool? isActive;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



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
    bool operator ==(Object other) => identical(this, other) || other is UpdateOptionalFieldRequest &&
      other.ingredientName == ingredientName &&
      other.ingredientUnit == ingredientUnit &&
      other.isActive == isActive &&
      other.name == name &&
      other.nameTranslations == nameTranslations &&
      other.orgIngredientId == orgIngredientId &&
      other.price == price &&
      other.quantityUsed == quantityUsed &&
      other.sizeLabel == sizeLabel;

    @override
    int get hashCode =>
        (ingredientName == null ? 0 : ingredientName.hashCode) +
        (ingredientUnit == null ? 0 : ingredientUnit.hashCode) +
        (isActive == null ? 0 : isActive.hashCode) +
        (name == null ? 0 : name.hashCode) +
        (nameTranslations == null ? 0 : nameTranslations.hashCode) +
        (orgIngredientId == null ? 0 : orgIngredientId.hashCode) +
        (price == null ? 0 : price.hashCode) +
        (quantityUsed == null ? 0 : quantityUsed.hashCode) +
        (sizeLabel == null ? 0 : sizeLabel.hashCode);

  factory UpdateOptionalFieldRequest.fromJson(Map<String, dynamic> json) => _$UpdateOptionalFieldRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOptionalFieldRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

