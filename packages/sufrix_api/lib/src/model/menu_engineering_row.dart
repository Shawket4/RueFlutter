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

    required  this.class_,

    required  this.costMissingLines,

    required  this.itemName,

    required  this.itemProfit,

    required  this.menuItemId,

    required  this.popularityCategory,

    required  this.popularityPct,

    required  this.profitCategory,

    required  this.quantitySold,

    required  this.sales,

    required  this.sizeLabel,

    required  this.totalCost,

    required  this.totalProfit,
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



      /// star | workhorse | challenge | dog (Foodics names).
  @JsonKey(
    
    name: r'class',
    required: true,
    includeIfNull: false,
  )


  final String class_;



      /// Lines in the window whose sale-time cost could not be resolved. Always reports snapshot data quality, regardless of `cost_basis` — under `current`, an included row can still carry snapshot gaps.
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
    required: true,
    includeIfNull: false,
  )


  final int itemProfit;



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



      /// Share of units among the rows in this report (cost-tracked only).
  @JsonKey(
    
    name: r'popularity_pct',
    required: true,
    includeIfNull: false,
  )


  final double popularityPct;



      /// \"high\" | \"low\" — vs weighted-average per-unit profit.
  @JsonKey(
    
    name: r'profit_category',
    required: true,
    includeIfNull: false,
  )


  final String profitCategory;



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



      /// Recipe-scope COGS in piastres (additive addons excluded — they have their own revenue and their own report). Snapshot basis: `SUM(unit_cost × quantity)`; current basis: today's recipe rollup × quantity. Rows where this is unresolvable are excluded from the report, so it is always present.
  @JsonKey(
    
    name: r'total_cost',
    required: true,
    includeIfNull: false,
  )


  final int totalCost;



      /// `sales - total_cost`, piastres.
  @JsonKey(
    
    name: r'total_profit',
    required: true,
    includeIfNull: false,
  )


  final int totalProfit;





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
        class_.hashCode +
        costMissingLines.hashCode +
        itemName.hashCode +
        itemProfit.hashCode +
        menuItemId.hashCode +
        popularityCategory.hashCode +
        popularityPct.hashCode +
        profitCategory.hashCode +
        quantitySold.hashCode +
        sales.hashCode +
        sizeLabel.hashCode +
        totalCost.hashCode +
        totalProfit.hashCode;

  factory MenuEngineeringRow.fromJson(Map<String, dynamic> json) => _$MenuEngineeringRowFromJson(json);

  Map<String, dynamic> toJson() => _$MenuEngineeringRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

