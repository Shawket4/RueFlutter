//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/public_addon_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_addon_slot.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PublicAddonSlot {
  /// Returns a new [PublicAddonSlot] instance.
  PublicAddonSlot({

    required  this.addonItems,

    required  this.addonType,

    required  this.id,

    required  this.isRequired,

     this.label,

    required  this.labelTranslations,

     this.maxSelections,

    required  this.minSelections,
  });

  @JsonKey(
    
    name: r'addon_items',
    required: true,
    includeIfNull: false,
  )


  final List<PublicAddonItem> addonItems;



  @JsonKey(
    
    name: r'addon_type',
    required: true,
    includeIfNull: false,
  )


  final String addonType;



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
    
    name: r'min_selections',
    required: true,
    includeIfNull: false,
  )


  final int minSelections;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PublicAddonSlot &&
      other.addonItems == addonItems &&
      other.addonType == addonType &&
      other.id == id &&
      other.isRequired == isRequired &&
      other.label == label &&
      other.labelTranslations == labelTranslations &&
      other.maxSelections == maxSelections &&
      other.minSelections == minSelections;

    @override
    int get hashCode =>
        addonItems.hashCode +
        addonType.hashCode +
        id.hashCode +
        isRequired.hashCode +
        (label == null ? 0 : label.hashCode) +
        labelTranslations.hashCode +
        (maxSelections == null ? 0 : maxSelections.hashCode) +
        minSelections.hashCode;

  factory PublicAddonSlot.fromJson(Map<String, dynamic> json) => _$PublicAddonSlotFromJson(json);

  Map<String, dynamic> toJson() => _$PublicAddonSlotToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

