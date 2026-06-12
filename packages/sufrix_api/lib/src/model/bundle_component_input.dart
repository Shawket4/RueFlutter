//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/addon_input.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bundle_component_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BundleComponentInput {
  /// Returns a new [BundleComponentInput] instance.
  BundleComponentInput({

     this.addons,

    required  this.itemId,

     this.optionalFieldIds,

    required  this.quantity,

     this.sizeLabel,
  });

  @JsonKey(
    
    name: r'addons',
    required: false,
    includeIfNull: false,
  )


  final List<AddonInput>? addons;



  @JsonKey(
    
    name: r'item_id',
    required: true,
    includeIfNull: false,
  )


  final String itemId;



  @JsonKey(
    
    name: r'optional_field_ids',
    required: false,
    includeIfNull: false,
  )


  final List<String>? optionalFieldIds;



  @JsonKey(
    
    name: r'quantity',
    required: true,
    includeIfNull: false,
  )


  final int quantity;



  @JsonKey(
    
    name: r'size_label',
    required: false,
    includeIfNull: false,
  )


  final String? sizeLabel;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BundleComponentInput &&
      other.addons == addons &&
      other.itemId == itemId &&
      other.optionalFieldIds == optionalFieldIds &&
      other.quantity == quantity &&
      other.sizeLabel == sizeLabel;

    @override
    int get hashCode =>
        addons.hashCode +
        itemId.hashCode +
        optionalFieldIds.hashCode +
        quantity.hashCode +
        (sizeLabel == null ? 0 : sizeLabel.hashCode);

  factory BundleComponentInput.fromJson(Map<String, dynamic> json) => _$BundleComponentInputFromJson(json);

  Map<String, dynamic> toJson() => _$BundleComponentInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

