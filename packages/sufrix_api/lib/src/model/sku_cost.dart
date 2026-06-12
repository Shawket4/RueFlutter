//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sku_cost.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SkuCost {
  /// Returns a new [SkuCost] instance.
  SkuCost({

     this.categoryId,

     this.cost,

    required  this.costMissing,

     this.foodCostPct,

    required  this.itemName,

     this.marginPct,

    required  this.menuItemId,

    required  this.price,

    required  this.sizeLabel,
  });

  @JsonKey(
    
    name: r'category_id',
    required: false,
    includeIfNull: false,
  )


  final String? categoryId;



      /// Recipe cost rollup in piastres. `null` ⟺ unknown (no recipe, or any ingredient unlinked / missing a cost).
  @JsonKey(
    
    name: r'cost',
    required: false,
    includeIfNull: false,
  )


  final int? cost;



  @JsonKey(
    
    name: r'cost_missing',
    required: true,
    includeIfNull: false,
  )


  final bool costMissing;



      /// `cost / price` when both known and price > 0.
  @JsonKey(
    
    name: r'food_cost_pct',
    required: false,
    includeIfNull: false,
  )


  final double? foodCostPct;



  @JsonKey(
    
    name: r'item_name',
    required: true,
    includeIfNull: false,
  )


  final String itemName;



      /// `(price - cost) / price` when both known and price > 0.
  @JsonKey(
    
    name: r'margin_pct',
    required: false,
    includeIfNull: false,
  )


  final double? marginPct;



  @JsonKey(
    
    name: r'menu_item_id',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;



      /// Current price in piastres for this SKU.
  @JsonKey(
    
    name: r'price',
    required: true,
    includeIfNull: false,
  )


  final int price;



      /// `\"one_size\"` when the item has no sizes.
  @JsonKey(
    
    name: r'size_label',
    required: true,
    includeIfNull: false,
  )


  final String sizeLabel;





    @override
    bool operator ==(Object other) => identical(this, other) || other is SkuCost &&
      other.categoryId == categoryId &&
      other.cost == cost &&
      other.costMissing == costMissing &&
      other.foodCostPct == foodCostPct &&
      other.itemName == itemName &&
      other.marginPct == marginPct &&
      other.menuItemId == menuItemId &&
      other.price == price &&
      other.sizeLabel == sizeLabel;

    @override
    int get hashCode =>
        (categoryId == null ? 0 : categoryId.hashCode) +
        (cost == null ? 0 : cost.hashCode) +
        costMissing.hashCode +
        (foodCostPct == null ? 0 : foodCostPct.hashCode) +
        itemName.hashCode +
        (marginPct == null ? 0 : marginPct.hashCode) +
        menuItemId.hashCode +
        price.hashCode +
        sizeLabel.hashCode;

  factory SkuCost.fromJson(Map<String, dynamic> json) => _$SkuCostFromJson(json);

  Map<String, dynamic> toJson() => _$SkuCostToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

