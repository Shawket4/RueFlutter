//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_addon_item.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PublicAddonItem {
  /// Returns a new [PublicAddonItem] instance.
  PublicAddonItem({

    required  this.defaultPrice,

    required  this.id,

    required  this.name,

    required  this.nameTranslations,
  });

  @JsonKey(
    
    name: r'default_price',
    required: true,
    includeIfNull: false,
  )


  final int defaultPrice;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'name_translations',
    required: true,
    includeIfNull: false,
  )


  final Object nameTranslations;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PublicAddonItem &&
      other.defaultPrice == defaultPrice &&
      other.id == id &&
      other.name == name &&
      other.nameTranslations == nameTranslations;

    @override
    int get hashCode =>
        defaultPrice.hashCode +
        id.hashCode +
        name.hashCode +
        nameTranslations.hashCode;

  factory PublicAddonItem.fromJson(Map<String, dynamic> json) => _$PublicAddonItemFromJson(json);

  Map<String, dynamic> toJson() => _$PublicAddonItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

