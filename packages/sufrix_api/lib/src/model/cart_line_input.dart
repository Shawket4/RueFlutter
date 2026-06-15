//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/addon_input.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_line_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CartLineInput {
  /// Returns a new [CartLineInput] instance.
  CartLineInput({

     this.addons,

    required  this.menuItemId,

     this.notes,

     this.optionalFieldIds,

    required  this.quantity,

     this.sizeLabel,
  });

  @JsonKey(
    
    name: r'addons',
    required: false,
    includeIfNull: false,
  )


  final List<AddonInput>? addons;



  @JsonKey(
    
    name: r'menu_item_id',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;



  @JsonKey(
    
    name: r'notes',
    required: false,
    includeIfNull: false,
  )


  final String? notes;



  @JsonKey(
    
    name: r'optional_field_ids',
    required: false,
    includeIfNull: false,
  )


  final List<String>? optionalFieldIds;



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





    @override
    bool operator ==(Object other) => identical(this, other) || other is CartLineInput &&
      other.addons == addons &&
      other.menuItemId == menuItemId &&
      other.notes == notes &&
      other.optionalFieldIds == optionalFieldIds &&
      other.quantity == quantity &&
      other.sizeLabel == sizeLabel;

    @override
    int get hashCode =>
        addons.hashCode +
        menuItemId.hashCode +
        (notes == null ? 0 : notes.hashCode) +
        optionalFieldIds.hashCode +
        quantity.hashCode +
        (sizeLabel == null ? 0 : sizeLabel.hashCode);

  factory CartLineInput.fromJson(Map<String, dynamic> json) => _$CartLineInputFromJson(json);

  Map<String, dynamic> toJson() => _$CartLineInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

