//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'addon_slot.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AddonSlot {
  /// Returns a new [AddonSlot] instance.
  AddonSlot({

    required  this.addonType,

    required  this.createdAt,

    required  this.displayOrder,

    required  this.id,

    required  this.isRequired,

     this.label,

    required  this.labelTranslations,

     this.maxSelections,

    required  this.menuItemId,

    required  this.minSelections,
  });

  @JsonKey(
    
    name: r'addon_type',
    required: true,
    includeIfNull: false,
  )


  final String addonType;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'display_order',
    required: true,
    includeIfNull: false,
  )


  final int displayOrder;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'is_required',
    required: true,
    includeIfNull: false,
  )


  final bool isRequired;



  @JsonKey(
    
    name: r'label',
    required: false,
    includeIfNull: false,
  )


  final String? label;



  @JsonKey(
    
    name: r'label_translations',
    required: true,
    includeIfNull: false,
  )


  final Object labelTranslations;



  @JsonKey(
    
    name: r'max_selections',
    required: false,
    includeIfNull: false,
  )


  final int? maxSelections;



  @JsonKey(
    
    name: r'menu_item_id',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;



  @JsonKey(
    
    name: r'min_selections',
    required: true,
    includeIfNull: false,
  )


  final int minSelections;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AddonSlot &&
      other.addonType == addonType &&
      other.createdAt == createdAt &&
      other.displayOrder == displayOrder &&
      other.id == id &&
      other.isRequired == isRequired &&
      other.label == label &&
      other.labelTranslations == labelTranslations &&
      other.maxSelections == maxSelections &&
      other.menuItemId == menuItemId &&
      other.minSelections == minSelections;

    @override
    int get hashCode =>
        addonType.hashCode +
        createdAt.hashCode +
        displayOrder.hashCode +
        id.hashCode +
        isRequired.hashCode +
        (label == null ? 0 : label.hashCode) +
        labelTranslations.hashCode +
        (maxSelections == null ? 0 : maxSelections.hashCode) +
        menuItemId.hashCode +
        minSelections.hashCode;

  factory AddonSlot.fromJson(Map<String, dynamic> json) => _$AddonSlotFromJson(json);

  Map<String, dynamic> toJson() => _$AddonSlotToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

