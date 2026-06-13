//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/decision_record.dart';
import 'package:sufrix_api/src/model/item_key.dart';
import 'package:sufrix_api/src/model/removal_recommendation.dart';
import 'package:sufrix_api/src/model/complementary_loss.dart';
import 'package:sufrix_api/src/model/absorbed_by.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'removal_scenario_record.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RemovalScenarioRecord {
  /// Returns a new [RemovalScenarioRecord] instance.
  RemovalScenarioRecord({

    required  this.absorbedBy,

    required  this.baselineCm,

    required  this.complementaryLosses,

    required  this.explanation,

    required  this.itemName,

    required  this.key,

    required  this.netCmChange,

    required  this.netCmChangeHi,

    required  this.netCmChangeLo,

    required  this.recommendation,

    required  this.branchId,

    required  this.createdAt,

     this.decision,

    required  this.id,

    required  this.runId,
  });

  @JsonKey(
    
    name: r'absorbed_by',
    required: true,
    includeIfNull: false,
  )


  final List<AbsorbedBy> absorbedBy;



  @JsonKey(
    
    name: r'baseline_cm',
    required: true,
    includeIfNull: false,
  )


  final double baselineCm;



  @JsonKey(
    
    name: r'complementary_losses',
    required: true,
    includeIfNull: false,
  )


  final List<ComplementaryLoss> complementaryLosses;



  @JsonKey(
    
    name: r'explanation',
    required: true,
    includeIfNull: false,
  )


  final String explanation;



  @JsonKey(
    
    name: r'item_name',
    required: true,
    includeIfNull: false,
  )


  final String itemName;



  @JsonKey(
    
    name: r'key',
    required: true,
    includeIfNull: false,
  )


  final ItemKey key;



  @JsonKey(
    
    name: r'net_cm_change',
    required: true,
    includeIfNull: false,
  )


  final double netCmChange;



  @JsonKey(
    
    name: r'net_cm_change_hi',
    required: true,
    includeIfNull: false,
  )


  final double netCmChangeHi;



  @JsonKey(
    
    name: r'net_cm_change_lo',
    required: true,
    includeIfNull: false,
  )


  final double netCmChangeLo;



  @JsonKey(
    
    name: r'recommendation',
    required: true,
    includeIfNull: false,
  unknownEnumValue: RemovalRecommendation.unknownDefaultOpenApi,
  )


  final RemovalRecommendation recommendation;



  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



  @JsonKey(
    
    name: r'created_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime createdAt;



  @JsonKey(
    
    name: r'decision',
    required: false,
    includeIfNull: false,
  )


  final DecisionRecord? decision;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'run_id',
    required: true,
    includeIfNull: false,
  )


  final String runId;





    @override
    bool operator ==(Object other) => identical(this, other) || other is RemovalScenarioRecord &&
      other.absorbedBy == absorbedBy &&
      other.baselineCm == baselineCm &&
      other.complementaryLosses == complementaryLosses &&
      other.explanation == explanation &&
      other.itemName == itemName &&
      other.key == key &&
      other.netCmChange == netCmChange &&
      other.netCmChangeHi == netCmChangeHi &&
      other.netCmChangeLo == netCmChangeLo &&
      other.recommendation == recommendation &&
      other.branchId == branchId &&
      other.createdAt == createdAt &&
      other.decision == decision &&
      other.id == id &&
      other.runId == runId;

    @override
    int get hashCode =>
        absorbedBy.hashCode +
        baselineCm.hashCode +
        complementaryLosses.hashCode +
        explanation.hashCode +
        itemName.hashCode +
        key.hashCode +
        netCmChange.hashCode +
        netCmChangeHi.hashCode +
        netCmChangeLo.hashCode +
        recommendation.hashCode +
        branchId.hashCode +
        createdAt.hashCode +
        (decision == null ? 0 : decision.hashCode) +
        id.hashCode +
        runId.hashCode;

  factory RemovalScenarioRecord.fromJson(Map<String, dynamic> json) => _$RemovalScenarioRecordFromJson(json);

  Map<String, dynamic> toJson() => _$RemovalScenarioRecordToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

