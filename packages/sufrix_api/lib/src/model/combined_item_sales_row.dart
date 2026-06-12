//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'combined_item_sales_row.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CombinedItemSalesRow {
  /// Returns a new [CombinedItemSalesRow] instance.
  CombinedItemSalesRow({

    required  this.bundleQty,

     this.itemId,

    required  this.itemName,

    required  this.itemNameTranslations,

    required  this.standaloneQty,

    required  this.totalQty,
  });

  @JsonKey(
    
    name: r'bundle_qty',
    required: true,
    includeIfNull: false,
  )


  final int bundleQty;



  @JsonKey(
    
    name: r'item_id',
    required: false,
    includeIfNull: false,
  )


  final String? itemId;



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
    
    name: r'standalone_qty',
    required: true,
    includeIfNull: false,
  )


  final int standaloneQty;



  @JsonKey(
    
    name: r'total_qty',
    required: true,
    includeIfNull: false,
  )


  final int totalQty;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CombinedItemSalesRow &&
      other.bundleQty == bundleQty &&
      other.itemId == itemId &&
      other.itemName == itemName &&
      other.itemNameTranslations == itemNameTranslations &&
      other.standaloneQty == standaloneQty &&
      other.totalQty == totalQty;

    @override
    int get hashCode =>
        bundleQty.hashCode +
        (itemId == null ? 0 : itemId.hashCode) +
        itemName.hashCode +
        itemNameTranslations.hashCode +
        standaloneQty.hashCode +
        totalQty.hashCode;

  factory CombinedItemSalesRow.fromJson(Map<String, dynamic> json) => _$CombinedItemSalesRowFromJson(json);

  Map<String, dynamic> toJson() => _$CombinedItemSalesRowToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

