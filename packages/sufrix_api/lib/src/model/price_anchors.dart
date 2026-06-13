//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price_anchors.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PriceAnchors {
  /// Returns a new [PriceAnchors] instance.
  PriceAnchors({

     this.costPlus,

    required  this.peerMedian,

    required  this.statusQuo,
  });

  @JsonKey(
    
    name: r'cost_plus',
    required: false,
    includeIfNull: false,
  )


  final double? costPlus;



  @JsonKey(
    
    name: r'peer_median',
    required: true,
    includeIfNull: false,
  )


  final double peerMedian;



  @JsonKey(
    
    name: r'status_quo',
    required: true,
    includeIfNull: false,
  )


  final double statusQuo;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PriceAnchors &&
      other.costPlus == costPlus &&
      other.peerMedian == peerMedian &&
      other.statusQuo == statusQuo;

    @override
    int get hashCode =>
        (costPlus == null ? 0 : costPlus.hashCode) +
        peerMedian.hashCode +
        statusQuo.hashCode;

  factory PriceAnchors.fromJson(Map<String, dynamic> json) => _$PriceAnchorsFromJson(json);

  Map<String, dynamic> toJson() => _$PriceAnchorsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

