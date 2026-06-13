//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_addon_slot_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateAddonSlotRequest {
  /// Returns a new [CreateAddonSlotRequest] instance.
  CreateAddonSlotRequest({

     this.addonType,

     this.isRequired,

     this.label,

     this.labelTranslations,

     this.maxSelections,

     this.minSelections,
  });

  @JsonKey(
    
    name: r'addon_type',
    required: false,
    includeIfNull: false,
  )


  final String? addonType;



  @JsonKey(
    
    name: r'is_required',
    required: false,
    includeIfNull: false,
  )


  final bool? isRequired;



  @JsonKey(
    
    name: r'label',
    required: false,
    includeIfNull: false,
  )


  final String? label;



  @JsonKey(
    
    name: r'label_translations',
    required: false,
    includeIfNull: false,
  )


  final Object? labelTranslations;



  @JsonKey(
    
    name: r'max_selections',
    required: false,
    includeIfNull: false,
  )


  final int? maxSelections;



  @JsonKey(
    
    name: r'min_selections',
    required: false,
    includeIfNull: false,
  )


  final int? minSelections;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateAddonSlotRequest &&
      other.addonType == addonType &&
      other.isRequired == isRequired &&
      other.label == label &&
      other.labelTranslations == labelTranslations &&
      other.maxSelections == maxSelections &&
      other.minSelections == minSelections;

    @override
    int get hashCode =>
        (addonType == null ? 0 : addonType.hashCode) +
        (isRequired == null ? 0 : isRequired.hashCode) +
        (label == null ? 0 : label.hashCode) +
        (labelTranslations == null ? 0 : labelTranslations.hashCode) +
        (maxSelections == null ? 0 : maxSelections.hashCode) +
        (minSelections == null ? 0 : minSelections.hashCode);

  factory CreateAddonSlotRequest.fromJson(Map<String, dynamic> json) => _$CreateAddonSlotRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAddonSlotRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

