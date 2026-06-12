//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bundle_component_hydrated.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BundleComponentHydrated {
  /// Returns a new [BundleComponentHydrated] instance.
  BundleComponentHydrated({

    required  this.bundleId,

    required  this.id,

    required  this.itemCost,

    required  this.itemId,

    required  this.itemName,

    required  this.itemPrice,

    required  this.position,

    required  this.quantity,
  });

  @JsonKey(
    
    name: r'bundle_id',
    required: true,
    includeIfNull: false,
  )


  final String bundleId;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'item_cost',
    required: true,
    includeIfNull: false,
  )


  final int itemCost;



  @JsonKey(
    
    name: r'item_id',
    required: true,
    includeIfNull: false,
  )


  final String itemId;



  @JsonKey(
    
    name: r'item_name',
    required: true,
    includeIfNull: false,
  )


  final String itemName;



  @JsonKey(
    
    name: r'item_price',
    required: true,
    includeIfNull: false,
  )


  final int itemPrice;



  @JsonKey(
    
    name: r'position',
    required: true,
    includeIfNull: false,
  )


  final int position;



  @JsonKey(
    
    name: r'quantity',
    required: true,
    includeIfNull: false,
  )


  final int quantity;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BundleComponentHydrated &&
      other.bundleId == bundleId &&
      other.id == id &&
      other.itemCost == itemCost &&
      other.itemId == itemId &&
      other.itemName == itemName &&
      other.itemPrice == itemPrice &&
      other.position == position &&
      other.quantity == quantity;

    @override
    int get hashCode =>
        bundleId.hashCode +
        id.hashCode +
        itemCost.hashCode +
        itemId.hashCode +
        itemName.hashCode +
        itemPrice.hashCode +
        position.hashCode +
        quantity.hashCode;

  factory BundleComponentHydrated.fromJson(Map<String, dynamic> json) => _$BundleComponentHydratedFromJson(json);

  Map<String, dynamic> toJson() => _$BundleComponentHydratedToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

