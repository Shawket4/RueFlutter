//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/suggestion_kind.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'record_decision_body.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RecordDecisionBody {
  /// Returns a new [RecordDecisionBody] instance.
  RecordDecisionBody({

    required  this.branchId,

    required  this.decision,

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



      /// accepted | rejected | ignored — kept as a string so invalid values yield a 400 instead of a deserialization error.
  @JsonKey(
    
    name: r'decision',
    required: true,
    includeIfNull: false,
  )


  final String decision;



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
    bool operator ==(Object other) => identical(this, other) || other is RecordDecisionBody &&
      other.branchId == branchId &&
      other.decision == decision &&
      other.notes == notes &&
      other.suggestionId == suggestionId &&
      other.suggestionKind == suggestionKind;

    @override
    int get hashCode =>
        branchId.hashCode +
        decision.hashCode +
        (notes == null ? 0 : notes.hashCode) +
        suggestionId.hashCode +
        suggestionKind.hashCode;

  factory RecordDecisionBody.fromJson(Map<String, dynamic> json) => _$RecordDecisionBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RecordDecisionBodyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

