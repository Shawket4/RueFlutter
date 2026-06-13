//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/bundle_item_pair.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bundle_association.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BundleAssociation {
  /// Returns a new [BundleAssociation] instance.
  BundleAssociation({

    required  this.compositeScore,

    required  this.pairLifts,
  });

  @JsonKey(
    
    name: r'composite_score',
    required: true,
    includeIfNull: false,
  )


  final double compositeScore;



  @JsonKey(
    
    name: r'pair_lifts',
    required: true,
    includeIfNull: false,
  )


  final List<BundleItemPair> pairLifts;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BundleAssociation &&
      other.compositeScore == compositeScore &&
      other.pairLifts == pairLifts;

    @override
    int get hashCode =>
        compositeScore.hashCode +
        pairLifts.hashCode;

  factory BundleAssociation.fromJson(Map<String, dynamic> json) => _$BundleAssociationFromJson(json);

  Map<String, dynamic> toJson() => _$BundleAssociationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

