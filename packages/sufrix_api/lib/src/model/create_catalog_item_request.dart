//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_catalog_item_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateCatalogItemRequest {
  /// Returns a new [CreateCatalogItemRequest] instance.
  CreateCatalogItemRequest({

    required  this.category,

     this.costPerUnit,

     this.description,

    required  this.name,

     this.supplierId,

    required  this.unit,
  });

  @JsonKey(
    
    name: r'category',
    required: true,
    includeIfNull: false,
  )


  final String category;



  @JsonKey(
    
    name: r'cost_per_unit',
    required: false,
    includeIfNull: false,
  )


  final double? costPerUnit;



  @JsonKey(
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



      /// Optional default supplier for reordering.
  @JsonKey(
    
    name: r'supplier_id',
    required: false,
    includeIfNull: false,
  )


  final String? supplierId;



  @JsonKey(
    
    name: r'unit',
    required: true,
    includeIfNull: false,
  )


  final String unit;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateCatalogItemRequest &&
      other.category == category &&
      other.costPerUnit == costPerUnit &&
      other.description == description &&
      other.name == name &&
      other.supplierId == supplierId &&
      other.unit == unit;

    @override
    int get hashCode =>
        category.hashCode +
        (costPerUnit == null ? 0 : costPerUnit.hashCode) +
        (description == null ? 0 : description.hashCode) +
        name.hashCode +
        (supplierId == null ? 0 : supplierId.hashCode) +
        unit.hashCode;

  factory CreateCatalogItemRequest.fromJson(Map<String, dynamic> json) => _$CreateCatalogItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCatalogItemRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

