//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'addon_cost.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AddonCost {
  /// Returns a new [AddonCost] instance.
  AddonCost({

    required  this.addonItemId,

    required  this.addonType,

     this.cost,

    required  this.costMissing,

     this.marginPct,

    required  this.name,

    required  this.price,
  });

  @JsonKey(
    
    name: r'addon_item_id',
    required: true,
    includeIfNull: false,
  )


  final String addonItemId;



  @JsonKey(
    
    name: r'addon_type',
    required: true,
    includeIfNull: false,
  )


  final String addonType;



      /// Ingredient cost rollup in piastres. `null` ⟺ unknown.
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



  @JsonKey(
    
    name: r'margin_pct',
    required: false,
    includeIfNull: false,
  )


  final double? marginPct;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



      /// Default price in piastres.
  @JsonKey(
    
    name: r'price',
    required: true,
    includeIfNull: false,
  )


  final int price;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AddonCost &&
      other.addonItemId == addonItemId &&
      other.addonType == addonType &&
      other.cost == cost &&
      other.costMissing == costMissing &&
      other.marginPct == marginPct &&
      other.name == name &&
      other.price == price;

    @override
    int get hashCode =>
        addonItemId.hashCode +
        addonType.hashCode +
        (cost == null ? 0 : cost.hashCode) +
        costMissing.hashCode +
        (marginPct == null ? 0 : marginPct.hashCode) +
        name.hashCode +
        price.hashCode;

  factory AddonCost.fromJson(Map<String, dynamic> json) => _$AddonCostFromJson(json);

  Map<String, dynamic> toJson() => _$AddonCostToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

