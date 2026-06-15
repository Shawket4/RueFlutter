//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'addon_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AddonInput {
  /// Returns a new [AddonInput] instance.
  AddonInput({

    required  this.addonItemId,

     this.quantity,

     this.unitPrice,
  });

  @JsonKey(
    
    name: r'addon_item_id',
    required: true,
    includeIfNull: false,
  )


  final String addonItemId;



  @JsonKey(
    
    name: r'quantity',
    required: false,
    includeIfNull: false,
  )


  final int? quantity;



      /// Charged unit price (piastres) the POS applied for this addon. When present it is RECORDED as the addon's unit_price; absent → the server's expected (catalog) price is used. Bundle-component addons ignore this (server-priced).
  @JsonKey(
    
    name: r'unit_price',
    required: false,
    includeIfNull: false,
  )


  final int? unitPrice;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AddonInput &&
      other.addonItemId == addonItemId &&
      other.quantity == quantity &&
      other.unitPrice == unitPrice;

    @override
    int get hashCode =>
        addonItemId.hashCode +
        quantity.hashCode +
        (unitPrice == null ? 0 : unitPrice.hashCode);

  factory AddonInput.fromJson(Map<String, dynamic> json) => _$AddonInputFromJson(json);

  Map<String, dynamic> toJson() => _$AddonInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

