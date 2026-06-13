//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/decision.dart';
import 'package:sufrix_api/src/model/suggestion_kind.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'decision_record.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DecisionRecord {
  /// Returns a new [DecisionRecord] instance.
  DecisionRecord({

    required  this.branchId,

    required  this.decidedAt,

    required  this.decidedBy,

    required  this.decision,

    required  this.id,

     this.notes,

    required  this.suggestionId,

    required  this.suggestionKind,
  });

  @JsonKey(
    
    name: r'branch_id',
    required: true,
    includeIfNull: false,
  )


  final String branchId;



  @JsonKey(
    
    name: r'decided_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime decidedAt;



  @JsonKey(
    
    name: r'decided_by',
    required: true,
    includeIfNull: false,
  )


  final String decidedBy;



  @JsonKey(
    
    name: r'decision',
    required: true,
    includeIfNull: false,
  unknownEnumValue: Decision.unknownDefaultOpenApi,
  )


  final Decision decision;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'notes',
    required: false,
    includeIfNull: false,
  )


  final String? notes;



  @JsonKey(
    
    name: r'suggestion_id',
    required: true,
    includeIfNull: false,
  )


  final String suggestionId;



  @JsonKey(
    
    name: r'suggestion_kind',
    required: true,
    includeIfNull: false,
  unknownEnumValue: SuggestionKind.unknownDefaultOpenApi,
  )


  final SuggestionKind suggestionKind;





    @override
    bool operator ==(Object other) => identical(this, other) || other is DecisionRecord &&
      other.branchId == branchId &&
      other.decidedAt == decidedAt &&
      other.decidedBy == decidedBy &&
      other.decision == decision &&
      other.id == id &&
      other.notes == notes &&
      other.suggestionId == suggestionId &&
      other.suggestionKind == suggestionKind;

    @override
    int get hashCode =>
        branchId.hashCode +
        decidedAt.hashCode +
        decidedBy.hashCode +
        decision.hashCode +
        id.hashCode +
        (notes == null ? 0 : notes.hashCode) +
        suggestionId.hashCode +
        suggestionKind.hashCode;

  factory DecisionRecord.fromJson(Map<String, dynamic> json) => _$DecisionRecordFromJson(json);

  Map<String, dynamic> toJson() => _$DecisionRecordToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

