//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mode_summary.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ModeSummary {
  /// Returns a new [ModeSummary] instance.
  ModeSummary({

    required  this.itemsCmTracked,

    required  this.itemsInsufficient,

    required  this.itemsRevenueOnly,

    required  this.itemsTotal,
  });

          // minimum: 0
  @JsonKey(
    
    name: r'items_cm_tracked',
    required: true,
    includeIfNull: false,
  )


  final int itemsCmTracked;



          // minimum: 0
  @JsonKey(
    
    name: r'items_insufficient',
    required: true,
    includeIfNull: false,
  )


  final int itemsInsufficient;



          // minimum: 0
  @JsonKey(
    
    name: r'items_revenue_only',
    required: true,
    includeIfNull: false,
  )


  final int itemsRevenueOnly;



          // minimum: 0
  @JsonKey(
    
    name: r'items_total',
    required: true,
    includeIfNull: false,
  )


  final int itemsTotal;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ModeSummary &&
      other.itemsCmTracked == itemsCmTracked &&
      other.itemsInsufficient == itemsInsufficient &&
      other.itemsRevenueOnly == itemsRevenueOnly &&
      other.itemsTotal == itemsTotal;

    @override
    int get hashCode =>
        itemsCmTracked.hashCode +
        itemsInsufficient.hashCode +
        itemsRevenueOnly.hashCode +
        itemsTotal.hashCode;

  factory ModeSummary.fromJson(Map<String, dynamic> json) => _$ModeSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$ModeSummaryToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

