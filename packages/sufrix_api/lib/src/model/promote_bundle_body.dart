//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'promote_bundle_body.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PromoteBundleBody {
  /// Returns a new [PromoteBundleBody] instance.
  PromoteBundleBody({

    required  this.bundleId,
  });

  @JsonKey(
    
    name: r'bundle_id',
    required: true,
    includeIfNull: false,
  )


  final String bundleId;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PromoteBundleBody &&
      other.bundleId == bundleId;

    @override
    int get hashCode =>
        bundleId.hashCode;

  factory PromoteBundleBody.fromJson(Map<String, dynamic> json) => _$PromoteBundleBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PromoteBundleBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

