//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'component_popularity.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ComponentPopularity {
  /// Returns a new [ComponentPopularity] instance.
  ComponentPopularity({

    required  this.itemId,

    required  this.itemName,

    required  this.quantitySold,
  });

  @JsonKey(
    
    name: r'item_id',
    required: true,
    includeIfNull: false,
  )


  final String itemId;



  @JsonKey(
    
    name: r'item_name',
    required: true,
    includeIfNull: false,
  )


  final String itemName;



  @JsonKey(
    
    name: r'quantity_sold',
    required: true,
    includeIfNull: false,
  )


  final int quantitySold;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ComponentPopularity &&
      other.itemId == itemId &&
      other.itemName == itemName &&
      other.quantitySold == quantitySold;

    @override
    int get hashCode =>
        itemId.hashCode +
        itemName.hashCode +
        quantitySold.hashCode;

  factory ComponentPopularity.fromJson(Map<String, dynamic> json) => _$ComponentPopularityFromJson(json);

  Map<String, dynamic> toJson() => _$ComponentPopularityToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

