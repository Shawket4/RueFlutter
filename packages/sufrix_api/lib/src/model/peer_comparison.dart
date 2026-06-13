//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/peer_position.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'peer_comparison.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PeerComparison {
  /// Returns a new [PeerComparison] instance.
  PeerComparison({

     this.medianCmPerUnitPeers,

    required  this.medianEffectivePricePeers,

     this.medianMarginPctPeers,

    required  this.sameCategoryCount,

    required  this.yourPosition,
  });

  @JsonKey(
    
    name: r'median_cm_per_unit_peers',
    required: false,
    includeIfNull: false,
  )


  final double? medianCmPerUnitPeers;



  @JsonKey(
    
    name: r'median_effective_price_peers',
    required: true,
    includeIfNull: false,
  )


  final double medianEffectivePricePeers;



      /// Only set when this item is CM-tracked AND peers are CM-tracked too.
  @JsonKey(
    
    name: r'median_margin_pct_peers',
    required: false,
    includeIfNull: false,
  )


  final double? medianMarginPctPeers;



          // minimum: 0
  @JsonKey(
    
    name: r'same_category_count',
    required: true,
    includeIfNull: false,
  )


  final int sameCategoryCount;



  @JsonKey(
    
    name: r'your_position',
    required: true,
    includeIfNull: false,
  unknownEnumValue: PeerPosition.unknownDefaultOpenApi,
  )


  final PeerPosition yourPosition;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PeerComparison &&
      other.medianCmPerUnitPeers == medianCmPerUnitPeers &&
      other.medianEffectivePricePeers == medianEffectivePricePeers &&
      other.medianMarginPctPeers == medianMarginPctPeers &&
      other.sameCategoryCount == sameCategoryCount &&
      other.yourPosition == yourPosition;

    @override
    int get hashCode =>
        (medianCmPerUnitPeers == null ? 0 : medianCmPerUnitPeers.hashCode) +
        medianEffectivePricePeers.hashCode +
        (medianMarginPctPeers == null ? 0 : medianMarginPctPeers.hashCode) +
        sameCategoryCount.hashCode +
        yourPosition.hashCode;

  factory PeerComparison.fromJson(Map<String, dynamic> json) => _$PeerComparisonFromJson(json);

  Map<String, dynamic> toJson() => _$PeerComparisonToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

