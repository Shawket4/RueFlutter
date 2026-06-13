//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calibration_point.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CalibrationPoint {
  /// Returns a new [CalibrationPoint] instance.
  CalibrationPoint({

    required  this.classificationMode,

    required  this.decidedAt,

    required  this.itemName,

    required  this.menuItemId,

    required  this.predictedDeltaPct,

    required  this.previousPrice,

    required  this.realizedAt,

    required  this.realizedDeltaPct,

    required  this.realizedPrice,

    required  this.sizeLabel,

    required  this.suggestedPrice,

    required  this.suggestionId,
  });

      /// Classification at suggestion time: \"cm\" or \"revenue\"
  @JsonKey(
    
    name: r'classification_mode',
    required: true,
    includeIfNull: false,
  )


  final String classificationMode;



  @JsonKey(
    
    name: r'decided_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime decidedAt;



  @JsonKey(
    
    name: r'item_name',
    required: true,
    includeIfNull: false,
  )


  final String itemName;



  @JsonKey(
    
    name: r'menu_item_id',
    required: true,
    includeIfNull: false,
  )


  final String menuItemId;



  @JsonKey(
    
    name: r'predicted_delta_pct',
    required: true,
    includeIfNull: false,
  )


  final double predictedDeltaPct;



  @JsonKey(
    
    name: r'previous_price',
    required: true,
    includeIfNull: false,
  )


  final int previousPrice;



  @JsonKey(
    
    name: r'realized_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime realizedAt;



  @JsonKey(
    
    name: r'realized_delta_pct',
    required: true,
    includeIfNull: false,
  )


  final double realizedDeltaPct;



  @JsonKey(
    
    name: r'realized_price',
    required: true,
    includeIfNull: false,
  )


  final int realizedPrice;



  @JsonKey(
    
    name: r'size_label',
    required: true,
    includeIfNull: false,
  )


  final String sizeLabel;



  @JsonKey(
    
    name: r'suggested_price',
    required: true,
    includeIfNull: false,
  )


  final int suggestedPrice;



  @JsonKey(
    
    name: r'suggestion_id',
    required: true,
    includeIfNull: false,
  )


  final String suggestionId;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CalibrationPoint &&
      other.classificationMode == classificationMode &&
      other.decidedAt == decidedAt &&
      other.itemName == itemName &&
      other.menuItemId == menuItemId &&
      other.predictedDeltaPct == predictedDeltaPct &&
      other.previousPrice == previousPrice &&
      other.realizedAt == realizedAt &&
      other.realizedDeltaPct == realizedDeltaPct &&
      other.realizedPrice == realizedPrice &&
      other.sizeLabel == sizeLabel &&
      other.suggestedPrice == suggestedPrice &&
      other.suggestionId == suggestionId;

    @override
    int get hashCode =>
        classificationMode.hashCode +
        decidedAt.hashCode +
        itemName.hashCode +
        menuItemId.hashCode +
        predictedDeltaPct.hashCode +
        previousPrice.hashCode +
        realizedAt.hashCode +
        realizedDeltaPct.hashCode +
        realizedPrice.hashCode +
        sizeLabel.hashCode +
        suggestedPrice.hashCode +
        suggestionId.hashCode;

  factory CalibrationPoint.fromJson(Map<String, dynamic> json) => _$CalibrationPointFromJson(json);

  Map<String, dynamic> toJson() => _$CalibrationPointToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

