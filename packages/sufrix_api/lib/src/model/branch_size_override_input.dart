//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_size_override_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BranchSizeOverrideInput {
  /// Returns a new [BranchSizeOverrideInput] instance.
  BranchSizeOverrideInput({

    required  this.priceOverride,

    required  this.sizeLabel,
  });

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
    bool operator ==(Object other) => identical(this, other) || other is BranchSizeOverrideInput &&
      other.priceOverride == priceOverride &&
      other.sizeLabel == sizeLabel;

    @override
    int get hashCode =>
        priceOverride.hashCode +
        sizeLabel.hashCode;

  factory BranchSizeOverrideInput.fromJson(Map<String, dynamic> json) => _$BranchSizeOverrideInputFromJson(json);

  Map<String, dynamic> toJson() => _$BranchSizeOverrideInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

