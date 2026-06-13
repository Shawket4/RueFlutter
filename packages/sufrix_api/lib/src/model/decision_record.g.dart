// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decision_record.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DecisionRecordCWProxy {
  DecisionRecord branchId(String branchId);

  DecisionRecord decidedAt(DateTime decidedAt);

  DecisionRecord decidedBy(String decidedBy);

  DecisionRecord decision(Decision decision);

  DecisionRecord id(String id);

  DecisionRecord notes(String? notes);

  DecisionRecord suggestionId(String suggestionId);

  DecisionRecord suggestionKind(SuggestionKind suggestionKind);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DecisionRecord(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DecisionRecord(...).copyWith(id: 12, name: "My name")
  /// ````
  DecisionRecord call({
    String branchId,
    DateTime decidedAt,
    String decidedBy,
    Decision decision,
    String id,
    String? notes,
    String suggestionId,
    SuggestionKind suggestionKind,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDecisionRecord.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDecisionRecord.copyWith.fieldName(...)`
class _$DecisionRecordCWProxyImpl implements _$DecisionRecordCWProxy {
  const _$DecisionRecordCWProxyImpl(this._value);

  final DecisionRecord _value;

  @override
  DecisionRecord branchId(String branchId) => this(branchId: branchId);

  @override
  DecisionRecord decidedAt(DateTime decidedAt) => this(decidedAt: decidedAt);

  @override
  DecisionRecord decidedBy(String decidedBy) => this(decidedBy: decidedBy);

  @override
  DecisionRecord decision(Decision decision) => this(decision: decision);

  @override
  DecisionRecord id(String id) => this(id: id);

  @override
  DecisionRecord notes(String? notes) => this(notes: notes);

  @override
  DecisionRecord suggestionId(String suggestionId) =>
      this(suggestionId: suggestionId);

  @override
  DecisionRecord suggestionKind(SuggestionKind suggestionKind) =>
      this(suggestionKind: suggestionKind);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DecisionRecord(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DecisionRecord(...).copyWith(id: 12, name: "My name")
  /// ````
  DecisionRecord call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? decidedAt = const $CopyWithPlaceholder(),
    Object? decidedBy = const $CopyWithPlaceholder(),
    Object? decision = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
    Object? suggestionId = const $CopyWithPlaceholder(),
    Object? suggestionKind = const $CopyWithPlaceholder(),
  }) {
    return DecisionRecord(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      decidedAt: decidedAt == const $CopyWithPlaceholder()
          ? _value.decidedAt
          // ignore: cast_nullable_to_non_nullable
          : decidedAt as DateTime,
      decidedBy: decidedBy == const $CopyWithPlaceholder()
          ? _value.decidedBy
          // ignore: cast_nullable_to_non_nullable
          : decidedBy as String,
      decision: decision == const $CopyWithPlaceholder()
          ? _value.decision
          // ignore: cast_nullable_to_non_nullable
          : decision as Decision,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      notes: notes == const $CopyWithPlaceholder()
          ? _value.notes
          // ignore: cast_nullable_to_non_nullable
          : notes as String?,
      suggestionId: suggestionId == const $CopyWithPlaceholder()
          ? _value.suggestionId
          // ignore: cast_nullable_to_non_nullable
          : suggestionId as String,
      suggestionKind: suggestionKind == const $CopyWithPlaceholder()
          ? _value.suggestionKind
          // ignore: cast_nullable_to_non_nullable
          : suggestionKind as SuggestionKind,
    );
  }
}

extension $DecisionRecordCopyWith on DecisionRecord {
  /// Returns a callable class that can be used as follows: `instanceOfDecisionRecord.copyWith(...)` or like so:`instanceOfDecisionRecord.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DecisionRecordCWProxy get copyWith => _$DecisionRecordCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecisionRecord _$DecisionRecordFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DecisionRecord',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'branch_id',
            'decided_at',
            'decided_by',
            'decision',
            'id',
            'suggestion_id',
            'suggestion_kind',
          ],
        );
        final val = DecisionRecord(
          branchId: $checkedConvert('branch_id', (v) => v as String),
          decidedAt: $checkedConvert(
            'decided_at',
            (v) => DateTime.parse(v as String),
          ),
          decidedBy: $checkedConvert('decided_by', (v) => v as String),
          decision: $checkedConvert(
            'decision',
            (v) => $enumDecode(
              _$DecisionEnumMap,
              v,
              unknownValue: Decision.unknownDefaultOpenApi,
            ),
          ),
          id: $checkedConvert('id', (v) => v as String),
          notes: $checkedConvert('notes', (v) => v as String?),
          suggestionId: $checkedConvert('suggestion_id', (v) => v as String),
          suggestionKind: $checkedConvert(
            'suggestion_kind',
            (v) => $enumDecode(
              _$SuggestionKindEnumMap,
              v,
              unknownValue: SuggestionKind.unknownDefaultOpenApi,
            ),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'branchId': 'branch_id',
        'decidedAt': 'decided_at',
        'decidedBy': 'decided_by',
        'suggestionId': 'suggestion_id',
        'suggestionKind': 'suggestion_kind',
      },
    );

Map<String, dynamic> _$DecisionRecordToJson(DecisionRecord instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'decided_at': instance.decidedAt.toIso8601String(),
      'decided_by': instance.decidedBy,
      'decision': _$DecisionEnumMap[instance.decision]!,
      'id': instance.id,
      'notes': ?instance.notes,
      'suggestion_id': instance.suggestionId,
      'suggestion_kind': _$SuggestionKindEnumMap[instance.suggestionKind]!,
    };

const _$DecisionEnumMap = {
  Decision.accepted: 'accepted',
  Decision.rejected: 'rejected',
  Decision.ignored: 'ignored',
  Decision.unknownDefaultOpenApi: 'unknown_default_open_api',
};

const _$SuggestionKindEnumMap = {
  SuggestionKind.price: 'price',
  SuggestionKind.bundle: 'bundle',
  SuggestionKind.removal: 'removal',
  SuggestionKind.unknownDefaultOpenApi: 'unknown_default_open_api',
};
