//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'channel_addon_override.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ChannelAddonOverride {
  /// Returns a new [ChannelAddonOverride] instance.
  ChannelAddonOverride({

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
    bool operator ==(Object other) => identical(this, other) || other is ChannelAddonOverride &&
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

  factory ChannelAddonOverride.fromJson(Map<String, dynamic> json) => _$ChannelAddonOverrideFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelAddonOverrideToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

