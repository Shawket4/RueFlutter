//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_key.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ItemKey {
  /// Returns a new [ItemKey] instance.
  ItemKey({

    required  this.menuItemId,

    required  this.sizeLabel,
  });

  @JsonKey(
    
    name: r'menu_item_id',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;



  @JsonKey(
    
    name: r'size_label',
    required: true,
    includeIfNull: false,
  )


  final String sizeLabel;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ItemKey &&
      other.menuItemId == menuItemId &&
      other.sizeLabel == sizeLabel;

    @override
    int get hashCode =>
        menuItemId.hashCode +
        sizeLabel.hashCode;

  factory ItemKey.fromJson(Map<String, dynamic> json) => _$ItemKeyFromJson(json);

  Map<String, dynamic> toJson() => _$ItemKeyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

