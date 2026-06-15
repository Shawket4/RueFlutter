//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_addon_override_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BranchAddonOverrideInput {
  /// Returns a new [BranchAddonOverrideInput] instance.
  BranchAddonOverrideInput({

    required  this.addonItemId,

    required  this.branchId,

     this.isAvailable,

     this.priceOverride,
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



  @JsonKey(
    
    name: r'is_available',
    required: false,
    includeIfNull: false,
  )


  final bool? isAvailable;



      /// Branch price in piastres; null inherits the org default_price.
  @JsonKey(
    
    name: r'price_override',
    required: false,
    includeIfNull: false,
  )


  final int? priceOverride;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BranchAddonOverrideInput &&
      other.addonItemId == addonItemId &&
      other.branchId == branchId &&
      other.isAvailable == isAvailable &&
      other.priceOverride == priceOverride;

    @override
    int get hashCode =>
        addonItemId.hashCode +
        branchId.hashCode +
        isAvailable.hashCode +
        (priceOverride == null ? 0 : priceOverride.hashCode);

  factory BranchAddonOverrideInput.fromJson(Map<String, dynamic> json) => _$BranchAddonOverrideInputFromJson(json);

  Map<String, dynamic> toJson() => _$BranchAddonOverrideInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

