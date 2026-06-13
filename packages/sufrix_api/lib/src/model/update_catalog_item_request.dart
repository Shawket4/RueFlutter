//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_catalog_item_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateCatalogItemRequest {
  /// Returns a new [UpdateCatalogItemRequest] instance.
  UpdateCatalogItemRequest({

     this.category,

     this.costPerUnit,

     this.description,

     this.isActive,

     this.name,

     this.supplierId,

     this.unit,
  });

  @JsonKey(
    
    name: r'category',
    required: false,
    includeIfNull: false,
  )


  final String? category;



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



      /// Set/replace the default supplier. (Omitted = unchanged; clearing to none is not supported via this field.)
  @JsonKey(
    
    name: r'supplier_id',
    required: false,
    includeIfNull: false,
  )


  final String? supplierId;



  @JsonKey(
    
    name: r'unit',
    required: false,
    includeIfNull: false,
  )


  final String? unit;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpdateCatalogItemRequest &&
      other.category == category &&
      other.costPerUnit == costPerUnit &&
      other.description == description &&
      other.isActive == isActive &&
      other.name == name &&
      other.supplierId == supplierId &&
      other.unit == unit;

    @override
    int get hashCode =>
        (category == null ? 0 : category.hashCode) +
        (costPerUnit == null ? 0 : costPerUnit.hashCode) +
        (description == null ? 0 : description.hashCode) +
        (isActive == null ? 0 : isActive.hashCode) +
        (name == null ? 0 : name.hashCode) +
        (supplierId == null ? 0 : supplierId.hashCode) +
        (unit == null ? 0 : unit.hashCode);

  factory UpdateCatalogItemRequest.fromJson(Map<String, dynamic> json) => _$UpdateCatalogItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateCatalogItemRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

