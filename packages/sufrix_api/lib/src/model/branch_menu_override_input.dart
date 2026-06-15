//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/branch_size_override_input.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_menu_override_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BranchMenuOverrideInput {
  /// Returns a new [BranchMenuOverrideInput] instance.
  BranchMenuOverrideInput({

    required  this.branchId,

     this.isAvailable,

    required  this.menuItemId,

     this.priceOverride,

     this.sizes,
  });

  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



  @JsonKey(
    
    name: r'is_available',
    required: false,
    includeIfNull: false,
  )


  final bool? isAvailable;



  @JsonKey(
    
    name: r'menu_item_id',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;



      /// Branch price in piastres; null inherits the org catalog base_price.
  @JsonKey(
    
    name: r'price_override',
    required: false,
    includeIfNull: false,
  )


  final int? priceOverride;



      /// Per-size branch prices. `null`/omitted → leave existing size overrides untouched; a list → REPLACE the item's size overrides with exactly that set (empty clears them).
  @JsonKey(
    
    name: r'sizes',
    required: false,
    includeIfNull: false,
  )


  final List<BranchSizeOverrideInput>? sizes;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BranchMenuOverrideInput &&
      other.branchId == branchId &&
      other.isAvailable == isAvailable &&
      other.menuItemId == menuItemId &&
      other.priceOverride == priceOverride &&
      other.sizes == sizes;

    @override
    int get hashCode =>
        branchId.hashCode +
        isAvailable.hashCode +
        menuItemId.hashCode +
        (priceOverride == null ? 0 : priceOverride.hashCode) +
        (sizes == null ? 0 : sizes.hashCode);

  factory BranchMenuOverrideInput.fromJson(Map<String, dynamic> json) => _$BranchMenuOverrideInputFromJson(json);

  Map<String, dynamic> toJson() => _$BranchMenuOverrideInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

