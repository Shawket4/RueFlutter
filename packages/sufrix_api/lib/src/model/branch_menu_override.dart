//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/branch_size_override.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_menu_override.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BranchMenuOverride {
  /// Returns a new [BranchMenuOverride] instance.
  BranchMenuOverride({

    required  this.branchId,

    required  this.isAvailable,

    required  this.menuItemId,

     this.priceOverride,

     this.sizes,

    required  this.updatedAt,
  });

  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



      /// False disables the item at this branch (excluded from the branch menu).
  @JsonKey(
    
    name: r'is_available',
    required: true,
    includeIfNull: false,
  )


  final bool isAvailable;



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



      /// Per-size branch prices for this item (empty when none). Availability is item-level.
  @JsonKey(
    
    name: r'sizes',
    required: false,
    includeIfNull: false,
  )


  final List<BranchSizeOverride>? sizes;



  @JsonKey(
    
    name: r'updated_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime updatedAt;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BranchMenuOverride &&
      other.branchId == branchId &&
      other.isAvailable == isAvailable &&
      other.menuItemId == menuItemId &&
      other.priceOverride == priceOverride &&
      other.sizes == sizes &&
      other.updatedAt == updatedAt;

    @override
    int get hashCode =>
        branchId.hashCode +
        isAvailable.hashCode +
        menuItemId.hashCode +
        (priceOverride == null ? 0 : priceOverride.hashCode) +
        sizes.hashCode +
        updatedAt.hashCode;

  factory BranchMenuOverride.fromJson(Map<String, dynamic> json) => _$BranchMenuOverrideFromJson(json);

  Map<String, dynamic> toJson() => _$BranchMenuOverrideToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

