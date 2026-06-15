//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'channel_menu_override.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ChannelMenuOverride {
  /// Returns a new [ChannelMenuOverride] instance.
  ChannelMenuOverride({

    required  this.branchId,

    required  this.channel,

     this.isAvailable,

    required  this.menuItemId,

     this.priceOverride,
  });

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
    
    name: r'menu_item_id',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;



  @JsonKey(
    
    name: r'price_override',
    required: false,
    includeIfNull: false,
  )


  final int? priceOverride;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ChannelMenuOverride &&
      other.branchId == branchId &&
      other.channel == channel &&
      other.isAvailable == isAvailable &&
      other.menuItemId == menuItemId &&
      other.priceOverride == priceOverride;

    @override
    int get hashCode =>
        branchId.hashCode +
        channel.hashCode +
        (isAvailable == null ? 0 : isAvailable.hashCode) +
        menuItemId.hashCode +
        (priceOverride == null ? 0 : priceOverride.hashCode);

  factory ChannelMenuOverride.fromJson(Map<String, dynamic> json) => _$ChannelMenuOverrideFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelMenuOverrideToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

