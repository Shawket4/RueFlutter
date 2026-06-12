//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu_engineering_row.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class MenuEngineeringRow {
  /// Returns a new [MenuEngineeringRow] instance.
  MenuEngineeringRow({

     this.categoryId,

     this.categoryName,

     this.class_,

    required  this.costMissingLines,

    required  this.itemName,

     this.itemProfit,

    required  this.menuItemId,

    required  this.popularityCategory,

    required  this.popularityPct,

     this.profitCategory,

    required  this.quantitySold,

    required  this.sales,

    required  this.sizeLabel,

     this.totalCost,

     this.totalProfit,
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



      /// star | workhorse | challenge | dog (Foodics names) — only for cost-tracked rows; `null` when cost is unknown.
  @JsonKey(
    
    name: r'class',
    required: false,
    includeIfNull: false,
  )


  final String? class_;



      /// Lines in the window whose cost could not be resolved.
  @JsonKey(
    
    name: r'cost_missing_lines',
    required: true,
    includeIfNull: false,
  )


  final int costMissingLines;



  @JsonKey(
    
    name: r'item_name',
    required: true,
    includeIfNull: false,
  )


  final String itemName;



      /// Average profit per unit, piastres (`(sales - cost) / qty`).
  @JsonKey(
    
    name: r'item_profit',
    required: false,
    includeIfNull: false,
  )


  final int? itemProfit;



  @JsonKey(
    
    name: r'menu_item_id',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;



      /// \"high\" | \"low\" — Kasavana-Smith 70% rule (0.70 / n).
  @JsonKey(
    
    name: r'popularity_category',
    required: true,
    includeIfNull: false,
  )


  final String popularityCategory;



      /// Share of units among rows in this report.
  @JsonKey(
    
    name: r'popularity_pct',
    required: true,
    includeIfNull: false,
  )


  final double popularityPct;



      /// \"high\" | \"low\" — vs weighted-average per-unit profit (cost-tracked rows only).
  @JsonKey(
    
    name: r'profit_category',
    required: false,
    includeIfNull: false,
  )


  final String? profitCategory;



      /// Units sold (standalone lines only — bundle lines are excluded so the per-unit economics stay clean; bundle performance has its own report).
  @JsonKey(
    
    name: r'quantity_sold',
    required: true,
    includeIfNull: false,
  )


  final int quantitySold;



      /// Revenue from those lines, piastres.
  @JsonKey(
    
    name: r'sales',
    required: true,
    includeIfNull: false,
  )


  final int sales;



      /// `\"one_size\"` for items without sizes.
  @JsonKey(
    
    name: r'size_label',
    required: true,
    includeIfNull: false,
  )


  final String sizeLabel;



      /// COGS from sale-time snapshots, piastres. `null` ⟺ at least one line in the window had unresolved cost.
  @JsonKey(
    
    name: r'total_cost',
    required: false,
    includeIfNull: false,
  )


  final int? totalCost;



      /// `sales - total_cost`, piastres.
  @JsonKey(
    
    name: r'total_profit',
    required: false,
    includeIfNull: false,
  )


  final int? totalProfit;





    @override
    bool operator ==(Object other) => identical(this, other) || other is MenuEngineeringRow &&
      other.categoryId == categoryId &&
      other.categoryName == categoryName &&
      other.class_ == class_ &&
      other.costMissingLines == costMissingLines &&
      other.itemName == itemName &&
      other.itemProfit == itemProfit &&
      other.menuItemId == menuItemId &&
      other.popularityCategory == popularityCategory &&
      other.popularityPct == popularityPct &&
      other.profitCategory == profitCategory &&
      other.quantitySold == quantitySold &&
      other.sales == sales &&
      other.sizeLabel == sizeLabel &&
      other.totalCost == totalCost &&
      other.totalProfit == totalProfit;

    @override
    int get hashCode =>
        (categoryId == null ? 0 : categoryId.hashCode) +
        (categoryName == null ? 0 : categoryName.hashCode) +
        (class_ == null ? 0 : class_.hashCode) +
        costMissingLines.hashCode +
        itemName.hashCode +
        (itemProfit == null ? 0 : itemProfit.hashCode) +
        menuItemId.hashCode +
        popularityCategory.hashCode +
        popularityPct.hashCode +
        (profitCategory == null ? 0 : profitCategory.hashCode) +
        quantitySold.hashCode +
        sales.hashCode +
        sizeLabel.hashCode +
        (totalCost == null ? 0 : totalCost.hashCode) +
        (totalProfit == null ? 0 : totalProfit.hashCode);

  factory MenuEngineeringRow.fromJson(Map<String, dynamic> json) => _$MenuEngineeringRowFromJson(json);

  Map<String, dynamic> toJson() => _$MenuEngineeringRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

