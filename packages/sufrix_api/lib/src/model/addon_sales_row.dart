//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'addon_sales_row.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AddonSalesRow {
  /// Returns a new [AddonSalesRow] instance.
  AddonSalesRow({

    required  this.addonItemId,

    required  this.addonName,

    required  this.addonNameTranslations,

    required  this.addonType,

    required  this.quantitySold,

    required  this.revenue,
  });

  @JsonKey(
    
    name: r'addon_item_id',
    required: true,
    includeIfNull: false,
  )


  final String addonItemId;



  @JsonKey(
    
    name: r'addon_name',
    required: true,
    includeIfNull: false,
  )


  final String addonName;



  @JsonKey(
    
    name: r'addon_name_translations',
    required: true,
    includeIfNull: false,
  )


  final Object addonNameTranslations;



  @JsonKey(
    
    name: r'addon_type',
    required: true,
    includeIfNull: false,
  )


  final String addonType;



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
    bool operator ==(Object other) => identical(this, other) || other is AddonSalesRow &&
      other.addonItemId == addonItemId &&
      other.addonName == addonName &&
      other.addonNameTranslations == addonNameTranslations &&
      other.addonType == addonType &&
      other.quantitySold == quantitySold &&
      other.revenue == revenue;

    @override
    int get hashCode =>
        addonItemId.hashCode +
        addonName.hashCode +
        addonNameTranslations.hashCode +
        addonType.hashCode +
        quantitySold.hashCode +
        revenue.hashCode;

  factory AddonSalesRow.fromJson(Map<String, dynamic> json) => _$AddonSalesRowFromJson(json);

  Map<String, dynamic> toJson() => _$AddonSalesRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

