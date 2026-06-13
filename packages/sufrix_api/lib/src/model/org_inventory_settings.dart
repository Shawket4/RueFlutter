//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'org_inventory_settings.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class OrgInventorySettings {
  /// Returns a new [OrgInventorySettings] instance.
  OrgInventorySettings({

    required  this.stocktakeVarianceThresholdPct,
  });

      /// Stock-count variance tolerance (percent). A counted row whose |difference| is at least this percent of expected is flagged and needs a reason.
  @JsonKey(
    
    name: r'stocktake_variance_threshold_pct',
    required: true,
    includeIfNull: false,
  )


  final double stocktakeVarianceThresholdPct;





    @override
    bool operator ==(Object other) => identical(this, other) || other is OrgInventorySettings &&
      other.stocktakeVarianceThresholdPct == stocktakeVarianceThresholdPct;

    @override
    int get hashCode =>
        stocktakeVarianceThresholdPct.hashCode;

  factory OrgInventorySettings.fromJson(Map<String, dynamic> json) => _$OrgInventorySettingsFromJson(json);

  Map<String, dynamic> toJson() => _$OrgInventorySettingsToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

