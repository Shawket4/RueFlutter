//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_bundle_component_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateBundleComponentInput {
  /// Returns a new [CreateBundleComponentInput] instance.
  CreateBundleComponentInput({

    required  this.itemId,

     this.position,

    required  this.quantity,
  });

  @JsonKey(
    
    name: r'item_id',
    required: true,
    includeIfNull: false,
  )


  final String itemId;



  @JsonKey(
    
    name: r'position',
    required: false,
    includeIfNull: false,
  )


  final int? position;



  @JsonKey(
    
    name: r'quantity',
    required: true,
    includeIfNull: false,
  )


  final int quantity;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateBundleComponentInput &&
      other.itemId == itemId &&
      other.position == position &&
      other.quantity == quantity;

    @override
    int get hashCode =>
        itemId.hashCode +
        (position == null ? 0 : position.hashCode) +
        quantity.hashCode;

  factory CreateBundleComponentInput.fromJson(Map<String, dynamic> json) => _$CreateBundleComponentInputFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBundleComponentInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

