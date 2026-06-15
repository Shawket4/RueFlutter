//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_size_override.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BranchSizeOverride {
  /// Returns a new [BranchSizeOverride] instance.
  BranchSizeOverride({

    required  this.priceOverride,

    required  this.sizeLabel,
  });

      /// Branch price for this size in piastres.
  @JsonKey(
    
    name: r'price_override',
    required: true,
    includeIfNull: false,
  )


  final int priceOverride;



  @JsonKey(
    
    name: r'size_label',
    required: true,
    includeIfNull: false,
  )


  final String sizeLabel;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BranchSizeOverride &&
      other.priceOverride == priceOverride &&
      other.sizeLabel == sizeLabel;

    @override
    int get hashCode =>
        priceOverride.hashCode +
        sizeLabel.hashCode;

  factory BranchSizeOverride.fromJson(Map<String, dynamic> json) => _$BranchSizeOverrideFromJson(json);

  Map<String, dynamic> toJson() => _$BranchSizeOverrideToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

