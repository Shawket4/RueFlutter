//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'public_item_size.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PublicItemSize {
  /// Returns a new [PublicItemSize] instance.
  PublicItemSize({

    required  this.id,

    required  this.label,

    required  this.priceOverride,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'label',
    required: true,
    includeIfNull: false,
  )


  final String label;



  @JsonKey(
    
    name: r'price_override',
    required: true,
    includeIfNull: false,
  )


  final int priceOverride;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PublicItemSize &&
      other.id == id &&
      other.label == label &&
      other.priceOverride == priceOverride;

    @override
    int get hashCode =>
        id.hashCode +
        label.hashCode +
        priceOverride.hashCode;

  factory PublicItemSize.fromJson(Map<String, dynamic> json) => _$PublicItemSizeFromJson(json);

  Map<String, dynamic> toJson() => _$PublicItemSizeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

