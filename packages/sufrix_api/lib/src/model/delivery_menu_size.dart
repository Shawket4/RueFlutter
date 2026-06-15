//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_menu_size.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DeliveryMenuSize {
  /// Returns a new [DeliveryMenuSize] instance.
  DeliveryMenuSize({

    required  this.label,

    required  this.price,
  });

  @JsonKey(
    
    name: r'label',
    required: true,
    includeIfNull: false,
  )


  final String label;



  @JsonKey(
    
    name: r'price',
    required: true,
    includeIfNull: false,
  )


  final int price;





    @override
    bool operator ==(Object other) => identical(this, other) || other is DeliveryMenuSize &&
      other.label == label &&
      other.price == price;

    @override
    int get hashCode =>
        label.hashCode +
        price.hashCode;

  factory DeliveryMenuSize.fromJson(Map<String, dynamic> json) => _$DeliveryMenuSizeFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryMenuSizeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

