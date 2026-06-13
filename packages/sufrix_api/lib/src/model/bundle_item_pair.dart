//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/item_key.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bundle_item_pair.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BundleItemPair {
  /// Returns a new [BundleItemPair] instance.
  BundleItemPair({

    required  this.confidenceAb,

    required  this.itemA,

    required  this.itemB,

    required  this.lift,

    required  this.support,
  });

      /// Directional: P(item_b in basket | item_a in basket), item_a = focus.
  @JsonKey(
    
    name: r'confidence_ab',
    required: true,
    includeIfNull: false,
  )


  final double confidenceAb;



  @JsonKey(
    
    name: r'item_a',
    required: true,
    includeIfNull: false,
  )


  final ItemKey itemA;



  @JsonKey(
    
    name: r'item_b',
    required: true,
    includeIfNull: false,
  )


  final ItemKey itemB;



  @JsonKey(
    
    name: r'lift',
    required: true,
    includeIfNull: false,
  )


  final double lift;



  @JsonKey(
    
    name: r'support',
    required: true,
    includeIfNull: false,
  )


  final double support;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BundleItemPair &&
      other.confidenceAb == confidenceAb &&
      other.itemA == itemA &&
      other.itemB == itemB &&
      other.lift == lift &&
      other.support == support;

    @override
    int get hashCode =>
        confidenceAb.hashCode +
        itemA.hashCode +
        itemB.hashCode +
        lift.hashCode +
        support.hashCode;

  factory BundleItemPair.fromJson(Map<String, dynamic> json) => _$BundleItemPairFromJson(json);

  Map<String, dynamic> toJson() => _$BundleItemPairToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

