//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_addon_override.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BranchAddonOverride {
  /// Returns a new [BranchAddonOverride] instance.
  BranchAddonOverride({

    required  this.addonItemId,

    required  this.branchId,

    required  this.isAvailable,

     this.priceOverride,

    required  this.updatedAt,
  });

  @JsonKey(
    
    name: r'addon_item_id',
    required: true,
    includeIfNull: false,
  )


  final String addonItemId;



  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



      /// False disables the addon at this branch (excluded from the branch addon list).
  @JsonKey(
    
    name: r'is_available',
    required: true,
    includeIfNull: false,
  )


  final bool isAvailable;



      /// Branch price in piastres; null inherits the org default_price.
  @JsonKey(
    
    name: r'price_override',
    required: false,
    includeIfNull: false,
  )


  final int? priceOverride;



  @JsonKey(
    
    name: r'updated_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime updatedAt;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BranchAddonOverride &&
      other.addonItemId == addonItemId &&
      other.branchId == branchId &&
      other.isAvailable == isAvailable &&
      other.priceOverride == priceOverride &&
      other.updatedAt == updatedAt;

    @override
    int get hashCode =>
        addonItemId.hashCode +
        branchId.hashCode +
        isAvailable.hashCode +
        (priceOverride == null ? 0 : priceOverride.hashCode) +
        updatedAt.hashCode;

  factory BranchAddonOverride.fromJson(Map<String, dynamic> json) => _$BranchAddonOverrideFromJson(json);

  Map<String, dynamic> toJson() => _$BranchAddonOverrideToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

