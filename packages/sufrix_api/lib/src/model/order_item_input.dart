//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/addon_input.dart';
import 'package:sufrix_api/src/model/bundle_component_input.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrderItemInput {
  /// Returns a new [OrderItemInput] instance.
  OrderItemInput({

    required  this.addons,

     this.bundleComponents,

     this.bundleId,

     this.menuItemId,

     this.notes,

    required  this.optionalFieldIds,

    required  this.quantity,

     this.sizeLabel,

     this.unitPrice,
  });

  @JsonKey(
    
    name: r'addons',
    required: true,
    includeIfNull: false,
  )


  final List<AddonInput> addons;



  @JsonKey(
    
    name: r'bundle_components',
    required: false,
    includeIfNull: false,
  )


  final List<BundleComponentInput>? bundleComponents;



  @JsonKey(
    
    name: r'bundle_id',
    required: false,
    includeIfNull: false,
  )


  final String? bundleId;



  @JsonKey(
    
    name: r'menu_item_id',
    required: false,
    includeIfNull: false,
  )


  final String? menuItemId;



  @JsonKey(
    
    name: r'notes',
    required: false,
    includeIfNull: false,
  )


  final String? notes;



  @JsonKey(
    
    name: r'optional_field_ids',
    required: true,
    includeIfNull: false,
  )


  final List<String> optionalFieldIds;



  @JsonKey(
    
    name: r'quantity',
    required: true,
    includeIfNull: false,
  )


  final int quantity;



  @JsonKey(
    
    name: r'size_label',
    required: false,
    includeIfNull: false,
  )


  final String? sizeLabel;



      /// Charged unit price (piastres) the POS applied for this item/bundle line. When present it is RECORDED as the line's unit_price; absent → the server's expected (catalog + branch override) price is used. Recording what the customer was actually charged keeps the DB equal to the printed receipt even when the POS's synced menu/override prices are stale or it was offline at sale time.
  @JsonKey(
    
    name: r'unit_price',
    required: false,
    includeIfNull: false,
  )


  final int? unitPrice;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrderItemInput &&
      other.addons == addons &&
      other.bundleComponents == bundleComponents &&
      other.bundleId == bundleId &&
      other.menuItemId == menuItemId &&
      other.notes == notes &&
      other.optionalFieldIds == optionalFieldIds &&
      other.quantity == quantity &&
      other.sizeLabel == sizeLabel &&
      other.unitPrice == unitPrice;

    @override
    int get hashCode =>
        addons.hashCode +
        bundleComponents.hashCode +
        (bundleId == null ? 0 : bundleId.hashCode) +
        (menuItemId == null ? 0 : menuItemId.hashCode) +
        (notes == null ? 0 : notes.hashCode) +
        optionalFieldIds.hashCode +
        quantity.hashCode +
        (sizeLabel == null ? 0 : sizeLabel.hashCode) +
        (unitPrice == null ? 0 : unitPrice.hashCode);

  factory OrderItemInput.fromJson(Map<String, dynamic> json) => _$OrderItemInputFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

