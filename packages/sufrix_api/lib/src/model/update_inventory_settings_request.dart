//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_inventory_settings_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateInventorySettingsRequest {
  /// Returns a new [UpdateInventorySettingsRequest] instance.
  UpdateInventorySettingsRequest({

    required  this.stocktakeVarianceThresholdPct,
  });

  @JsonKey(
    
    name: r'stocktake_variance_threshold_pct',
    required: true,
    includeIfNull: false,
  )


  final double stocktakeVarianceThresholdPct;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpdateInventorySettingsRequest &&
      other.stocktakeVarianceThresholdPct == stocktakeVarianceThresholdPct;

    @override
    int get hashCode =>
        stocktakeVarianceThresholdPct.hashCode;

  factory UpdateInventorySettingsRequest.fromJson(Map<String, dynamic> json) => _$UpdateInventorySettingsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateInventorySettingsRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

