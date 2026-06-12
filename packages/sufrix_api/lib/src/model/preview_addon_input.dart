//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'preview_addon_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PreviewAddonInput {
  /// Returns a new [PreviewAddonInput] instance.
  PreviewAddonInput({

    required  this.addonItemId,

     this.quantity,
  });

  @JsonKey(
    
    name: r'addon_item_id',
    required: true,
    includeIfNull: false,
  )


  final String addonItemId;



  @JsonKey(
    
    name: r'quantity',
    required: false,
    includeIfNull: false,
  )


  final int? quantity;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PreviewAddonInput &&
      other.addonItemId == addonItemId &&
      other.quantity == quantity;

    @override
    int get hashCode =>
        addonItemId.hashCode +
        quantity.hashCode;

  factory PreviewAddonInput.fromJson(Map<String, dynamic> json) => _$PreviewAddonInputFromJson(json);

  Map<String, dynamic> toJson() => _$PreviewAddonInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

