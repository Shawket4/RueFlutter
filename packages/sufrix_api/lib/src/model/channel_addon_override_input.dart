//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'channel_addon_override_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ChannelAddonOverrideInput {
  /// Returns a new [ChannelAddonOverrideInput] instance.
  ChannelAddonOverrideInput({

    required  this.addonItemId,

    required  this.branchId,

    required  this.channel,

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
    
    name: r'channel',
    required: true,
    includeIfNull: false,
  )


  final String channel;



  @JsonKey(
    
    name: r'is_available',
    required: false,
    includeIfNull: false,
  )


  final bool? isAvailable;



  @JsonKey(
    
    name: r'price_override',
    required: false,
    includeIfNull: false,
  )


  final int? priceOverride;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ChannelAddonOverrideInput &&
      other.addonItemId == addonItemId &&
      other.branchId == branchId &&
      other.channel == channel &&
      other.isAvailable == isAvailable &&
      other.priceOverride == priceOverride;

    @override
    int get hashCode =>
        addonItemId.hashCode +
        branchId.hashCode +
        channel.hashCode +
        (isAvailable == null ? 0 : isAvailable.hashCode) +
        (priceOverride == null ? 0 : priceOverride.hashCode);

  factory ChannelAddonOverrideInput.fromJson(Map<String, dynamic> json) => _$ChannelAddonOverrideInputFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelAddonOverrideInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

