//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_size.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ItemSize {
  /// Returns a new [ItemSize] instance.
  ItemSize({

    required  this.id,

    required  this.isActive,

    required  this.label,

    required  this.menuItemId,

    required  this.priceOverride,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'is_active',
    required: true,
    includeIfNull: false,
  )


  final bool isActive;



  @JsonKey(
    
    name: r'label',
    required: true,
    includeIfNull: false,
  )


  final String label;



  @JsonKey(
    
    name: r'menu_item_id',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;



  @JsonKey(
    
    name: r'price_override',
    required: true,
    includeIfNull: false,
  )


  final int priceOverride;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ItemSize &&
      other.id == id &&
      other.isActive == isActive &&
      other.label == label &&
      other.menuItemId == menuItemId &&
      other.priceOverride == priceOverride;

    @override
    int get hashCode =>
        id.hashCode +
        isActive.hashCode +
        label.hashCode +
        menuItemId.hashCode +
        priceOverride.hashCode;

  factory ItemSize.fromJson(Map<String, dynamic> json) => _$ItemSizeFromJson(json);

  Map<String, dynamic> toJson() => _$ItemSizeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

