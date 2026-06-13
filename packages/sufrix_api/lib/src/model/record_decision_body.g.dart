// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_decision_body.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RecordDecisionBodyCWProxy {
  RecordDecisionBody branchId(String branchId);

  RecordDecisionBody decision(String decision);

  RecordDecisionBody notes(String? notes);

  RecordDecisionBody suggestionId(String suggestionId);

  RecordDecisionBody suggestionKind(SuggestionKind suggestionKind);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RecordDecisionBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RecordDecisionBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RecordDecisionBody call({
    String branchId,
    String decision,
    String? notes,
    String suggestionId,
    SuggestionKind suggestionKind,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRecordDecisionBody.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRecordDecisionBody.copyWith.fieldName(...)`
class _$RecordDecisionBodyCWProxyImpl implements _$RecordDecisionBodyCWProxy {
  const _$RecordDecisionBodyCWProxyImpl(this._value);

  final RecordDecisionBody _value;

  @override
  RecordDecisionBody branchId(String branchId) => this(branchId: branchId);

  @override
  RecordDecisionBody decision(String decision) => this(decision: decision);

  @override
  RecordDecisionBody notes(String? notes) => this(notes: notes);

  @override
  RecordDecisionBody suggestionId(String suggestionId) =>
      this(suggestionId: suggestionId);

  @override
  RecordDecisionBody suggestionKind(SuggestionKind suggestionKind) =>
      this(suggestionKind: suggestionKind);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RecordDecisionBody(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RecordDecisionBody(...).copyWith(id: 12, name: "My name")
  /// ````
  RecordDecisionBody call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? decision = const $CopyWithPlaceholder(),
    Object? notes = const $CopyWithPlaceholder(),
    Object? suggestionId = const $CopyWithPlaceholder(),
    Object? suggestionKind = const $CopyWithPlaceholder(),
  }) {
    return RecordDecisionBody(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      decision: decision == const $CopyWithPlaceholder()
          ? _value.decision
          // ignore: cast_nullable_to_non_nullable
          : decision as String,
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

extension $RecordDecisionBodyCopyWith on RecordDecisionBody {
  /// Returns a callable class that can be used as follows: `instanceOfRecordDecisionBody.copyWith(...)` or like so:`instanceOfRecordDecisionBody.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RecordDecisionBodyCWProxy get copyWith =>
      _$RecordDecisionBodyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordDecisionBody _$RecordDecisionBodyFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'RecordDecisionBody',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'branch_id',
            'decision',
            'suggestion_id',
            'suggestion_kind',
          ],
        );
        final val = RecordDecisionBody(
          branchId: $checkedConvert('branch_id', (v) => v as String),
          decision: $checkedConvert('decision', (v) => v as String),
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
        'suggestionId': 'suggestion_id',
        'suggestionKind': 'suggestion_kind',
      },
    );

Map<String, dynamic> _$RecordDecisionBodyToJson(RecordDecisionBody instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'decision': instance.decision,
      'notes': ?instance.notes,
      'suggestion_id': instance.suggestionId,
      'suggestion_kind': _$SuggestionKindEnumMap[instance.suggestionKind]!,
    };

const _$SuggestionKindEnumMap = {
  SuggestionKind.price: 'price',
  SuggestionKind.bundle: 'bundle',
  SuggestionKind.removal: 'removal',
  SuggestionKind.unknownDefaultOpenApi: 'unknown_default_open_api',
};
