//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/item_sales.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_sales.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CategorySales {
  /// Returns a new [CategorySales] instance.
  CategorySales({

     this.categoryId,

     this.categoryName,

    required  this.categoryNameTranslations,

    required  this.itemCount,

    required  this.items,

    required  this.quantitySold,

    required  this.revenue,
  });

  @JsonKey(
    
    name: r'category_id',
    required: false,
    includeIfNull: false,
  )


  final String? categoryId;



  @JsonKey(
    
    name: r'category_name',
    required: false,
    includeIfNull: false,
  )


  final String? categoryName;



  @JsonKey(
    
    name: r'category_name_translations',
    required: true,
    includeIfNull: false,
  )


  final Object categoryNameTranslations;



  @JsonKey(
    
    name: r'item_count',
    required: true,
    includeIfNull: false,
  )


  final int itemCount;



  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<ItemSales> items;



  @JsonKey(
    
    name: r'quantity_sold',
    required: true,
    includeIfNull: false,
  )


  final int quantitySold;



  @JsonKey(
    
    name: r'revenue',
    required: true,
    includeIfNull: false,
  )


  final int revenue;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CategorySales &&
      other.categoryId == categoryId &&
      other.categoryName == categoryName &&
      other.categoryNameTranslations == categoryNameTranslations &&
      other.itemCount == itemCount &&
      other.items == items &&
      other.quantitySold == quantitySold &&
      other.revenue == revenue;

    @override
    int get hashCode =>
        (categoryId == null ? 0 : categoryId.hashCode) +
        (categoryName == null ? 0 : categoryName.hashCode) +
        categoryNameTranslations.hashCode +
        itemCount.hashCode +
        items.hashCode +
        quantitySold.hashCode +
        revenue.hashCode;

  factory CategorySales.fromJson(Map<String, dynamic> json) => _$CategorySalesFromJson(json);

  Map<String, dynamic> toJson() => _$CategorySalesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

