//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_addon_item_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateAddonItemRequest {
  /// Returns a new [UpdateAddonItemRequest] instance.
  UpdateAddonItemRequest({

     this.addonType,

     this.defaultPrice,

     this.isActive,

     this.name,

     this.nameTranslations,
  });

  @JsonKey(
    
    name: r'addon_type',
    required: false,
    includeIfNull: false,
  )


  final String? addonType;



  @JsonKey(
    
    name: r'default_price',
    required: false,
    includeIfNull: false,
  )


  final int? defaultPrice;



  @JsonKey(
    
    name: r'is_active',
    required: false,
    includeIfNull: false,
  )


  final bool? isActive;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'name_translations',
    required: false,
    includeIfNull: false,
  )


  final Object? nameTranslations;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpdateAddonItemRequest &&
      other.addonType == addonType &&
      other.defaultPrice == defaultPrice &&
      other.isActive == isActive &&
      other.name == name &&
      other.nameTranslations == nameTranslations;

    @override
    int get hashCode =>
        (addonType == null ? 0 : addonType.hashCode) +
        (defaultPrice == null ? 0 : defaultPrice.hashCode) +
        (isActive == null ? 0 : isActive.hashCode) +
        (name == null ? 0 : name.hashCode) +
        (nameTranslations == null ? 0 : nameTranslations.hashCode);

  factory UpdateAddonItemRequest.fromJson(Map<String, dynamic> json) => _$UpdateAddonItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAddonItemRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

