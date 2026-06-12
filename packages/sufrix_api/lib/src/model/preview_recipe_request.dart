//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/preview_addon_input.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'preview_recipe_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PreviewRecipeRequest {
  /// Returns a new [PreviewRecipeRequest] instance.
  PreviewRecipeRequest({

    required  this.addons,

    required  this.menuItemId,

    required  this.optionalFieldIds,

     this.sizeLabel,
  });

  @JsonKey(
    
    name: r'addons',
    required: true,
    includeIfNull: false,
  )


  final List<PreviewAddonInput> addons;



  @JsonKey(
    
    name: r'menu_item_id',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;



  @JsonKey(
    
    name: r'optional_field_ids',
    required: true,
    includeIfNull: false,
  )


  final List<String> optionalFieldIds;



  @JsonKey(
    
    name: r'size_label',
    required: false,
    includeIfNull: false,
  )


  final String? sizeLabel;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PreviewRecipeRequest &&
      other.addons == addons &&
      other.menuItemId == menuItemId &&
      other.optionalFieldIds == optionalFieldIds &&
      other.sizeLabel == sizeLabel;

    @override
    int get hashCode =>
        addons.hashCode +
        menuItemId.hashCode +
        optionalFieldIds.hashCode +
        (sizeLabel == null ? 0 : sizeLabel.hashCode);

  factory PreviewRecipeRequest.fromJson(Map<String, dynamic> json) => _$PreviewRecipeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PreviewRecipeRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

