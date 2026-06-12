//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item_optional.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderItemOptional {
  /// Returns a new [OrderItemOptional] instance.
  OrderItemOptional({

     this.cost,

    required  this.fieldName,

    required  this.id,

     this.ingredientName,

     this.ingredientUnit,

    required  this.nameTranslations,

     this.optionalFieldId,

    required  this.orderItemId,

     this.orgIngredientId,

    required  this.price,

     this.quantityDeducted,
  });

      /// Ingredient cost per parent-item unit in piastres. `null` ⟺ unknown or no ingredient linked.
  @JsonKey(
    
    name: r'cost',
    required: false,
    includeIfNull: false,
  )


  final int? cost;



  @JsonKey(
    
    name: r'field_name',
    required: true,
    includeIfNull: false,
  )


  final String fieldName;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



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
    
    name: r'name_translations',
    required: true,
    includeIfNull: false,
  )


  final Object nameTranslations;



  @JsonKey(
    
    name: r'optional_field_id',
    required: false,
    includeIfNull: false,
  )


  final String? optionalFieldId;



  @JsonKey(
    
    name: r'order_item_id',
    required: true,
    includeIfNull: false,
  )


  final String orderItemId;



  @JsonKey(
    
    name: r'org_ingredient_id',
    required: false,
    includeIfNull: false,
  )


  final String? orgIngredientId;



  @JsonKey(
    
    name: r'price',
    required: true,
    includeIfNull: false,
  )


  final int price;



  @JsonKey(
    
    name: r'quantity_deducted',
    required: false,
    includeIfNull: false,
  )


  final double? quantityDeducted;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrderItemOptional &&
      other.cost == cost &&
      other.fieldName == fieldName &&
      other.id == id &&
      other.ingredientName == ingredientName &&
      other.ingredientUnit == ingredientUnit &&
      other.nameTranslations == nameTranslations &&
      other.optionalFieldId == optionalFieldId &&
      other.orderItemId == orderItemId &&
      other.orgIngredientId == orgIngredientId &&
      other.price == price &&
      other.quantityDeducted == quantityDeducted;

    @override
    int get hashCode =>
        (cost == null ? 0 : cost.hashCode) +
        fieldName.hashCode +
        id.hashCode +
        (ingredientName == null ? 0 : ingredientName.hashCode) +
        (ingredientUnit == null ? 0 : ingredientUnit.hashCode) +
        nameTranslations.hashCode +
        (optionalFieldId == null ? 0 : optionalFieldId.hashCode) +
        orderItemId.hashCode +
        (orgIngredientId == null ? 0 : orgIngredientId.hashCode) +
        price.hashCode +
        (quantityDeducted == null ? 0 : quantityDeducted.hashCode);

  factory OrderItemOptional.fromJson(Map<String, dynamic> json) => _$OrderItemOptionalFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemOptionalToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

