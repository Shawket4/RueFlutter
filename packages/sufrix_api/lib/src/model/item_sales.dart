//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_sales.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ItemSales {
  /// Returns a new [ItemSales] instance.
  ItemSales({

    required  this.itemName,

    required  this.itemNameTranslations,

    required  this.menuItemId,

    required  this.quantitySold,

    required  this.revenue,
  });

  @JsonKey(
    
    name: r'item_name',
    required: true,
    includeIfNull: false,
  )


  final String itemName;



  @JsonKey(
    
    name: r'item_name_translations',
    required: true,
    includeIfNull: false,
  )


  final Object itemNameTranslations;



  @JsonKey(
    
    name: r'menu_item_id',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;



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
    bool operator ==(Object other) => identical(this, other) || other is ItemSales &&
      other.itemName == itemName &&
      other.itemNameTranslations == itemNameTranslations &&
      other.menuItemId == menuItemId &&
      other.quantitySold == quantitySold &&
      other.revenue == revenue;

    @override
    int get hashCode =>
        itemName.hashCode +
        itemNameTranslations.hashCode +
        menuItemId.hashCode +
        quantitySold.hashCode +
        revenue.hashCode;

  factory ItemSales.fromJson(Map<String, dynamic> json) => _$ItemSalesFromJson(json);

  Map<String, dynamic> toJson() => _$ItemSalesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

