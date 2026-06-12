//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'org_ingredient.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrgIngredient {
  /// Returns a new [OrgIngredient] instance.
  OrgIngredient({

    required  this.category,

    required  this.costPerUnit,

    required  this.createdAt,

     this.description,

    required  this.id,

    required  this.isActive,

    required  this.name,

    required  this.orgId,

    required  this.unit,

    required  this.updatedAt,
  });

  @JsonKey(
    
    name: r'category',
    required: true,
    includeIfNull: false,
  )


  final String category;



  @JsonKey(
    
    name: r'cost_per_unit',
    required: true,
    includeIfNull: false,
  )


  final double costPerUnit;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'is_active',
    required: true,
    includeIfNull: false,
  )


  final bool isActive;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'org_id',
    required: true,
    includeIfNull: false,
  )


  final String orgId;



  @JsonKey(
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;



  @JsonKey(
    
    name: r'updated_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime updatedAt;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrgIngredient &&
      other.category == category &&
      other.costPerUnit == costPerUnit &&
      other.createdAt == createdAt &&
      other.description == description &&
      other.id == id &&
      other.isActive == isActive &&
      other.name == name &&
      other.orgId == orgId &&
      other.unit == unit &&
      other.updatedAt == updatedAt;

    @override
    int get hashCode =>
        category.hashCode +
        costPerUnit.hashCode +
        createdAt.hashCode +
        (description == null ? 0 : description.hashCode) +
        id.hashCode +
        isActive.hashCode +
        name.hashCode +
        orgId.hashCode +
        unit.hashCode +
        updatedAt.hashCode;

  factory OrgIngredient.fromJson(Map<String, dynamic> json) => _$OrgIngredientFromJson(json);

  Map<String, dynamic> toJson() => _$OrgIngredientToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

