// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stocktake.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StocktakeCWProxy {
  Stocktake branchId(String branchId);

  Stocktake branchName(String? branchName);

  Stocktake createdAt(DateTime createdAt);

  Stocktake finalizedAt(DateTime? finalizedAt);

  Stocktake finalizedBy(String? finalizedBy);

  Stocktake id(String id);

  Stocktake note(String? note);

  Stocktake orgId(String orgId);

  Stocktake startedAt(DateTime startedAt);

  Stocktake startedBy(String startedBy);

  Stocktake startedByName(String? startedByName);

  Stocktake status(String status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Stocktake(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Stocktake(...).copyWith(id: 12, name: "My name")
  /// ````
  Stocktake call({
    String branchId,
    String? branchName,
    DateTime createdAt,
    DateTime? finalizedAt,
    String? finalizedBy,
    String id,
    String? note,
    String orgId,
    DateTime startedAt,
    String startedBy,
    String? startedByName,
    String status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStocktake.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStocktake.copyWith.fieldName(...)`
class _$StocktakeCWProxyImpl implements _$StocktakeCWProxy {
  const _$StocktakeCWProxyImpl(this._value);

  final Stocktake _value;

  @override
  Stocktake branchId(String branchId) => this(branchId: branchId);

  @override
  Stocktake branchName(String? branchName) => this(branchName: branchName);

  @override
  Stocktake createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  Stocktake finalizedAt(DateTime? finalizedAt) =>
      this(finalizedAt: finalizedAt);

  @override
  Stocktake finalizedBy(String? finalizedBy) => this(finalizedBy: finalizedBy);

  @override
  Stocktake id(String id) => this(id: id);

  @override
  Stocktake note(String? note) => this(note: note);

  @override
  Stocktake orgId(String orgId) => this(orgId: orgId);

  @override
  Stocktake startedAt(DateTime startedAt) => this(startedAt: startedAt);

  @override
  Stocktake startedBy(String startedBy) => this(startedBy: startedBy);

  @override
  Stocktake startedByName(String? startedByName) =>
      this(startedByName: startedByName);

  @override
  Stocktake status(String status) => this(status: status);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Stocktake(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Stocktake(...).copyWith(id: 12, name: "My name")
  /// ````
  Stocktake call({
    Object? branchId = const $CopyWithPlaceholder(),
    Object? branchName = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? finalizedAt = const $CopyWithPlaceholder(),
    Object? finalizedBy = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? note = const $CopyWithPlaceholder(),
    Object? orgId = const $CopyWithPlaceholder(),
    Object? startedAt = const $CopyWithPlaceholder(),
    Object? startedBy = const $CopyWithPlaceholder(),
    Object? startedByName = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return Stocktake(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
      branchName: branchName == const $CopyWithPlaceholder()
          ? _value.branchName
          // ignore: cast_nullable_to_non_nullable
          : branchName as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      finalizedAt: finalizedAt == const $CopyWithPlaceholder()
          ? _value.finalizedAt
          // ignore: cast_nullable_to_non_nullable
          : finalizedAt as DateTime?,
      finalizedBy: finalizedBy == const $CopyWithPlaceholder()
          ? _value.finalizedBy
          // ignore: cast_nullable_to_non_nullable
          : finalizedBy as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      note: note == const $CopyWithPlaceholder()
          ? _value.note
          // ignore: cast_nullable_to_non_nullable
          : note as String?,
      orgId: orgId == const $CopyWithPlaceholder()
          ? _value.orgId
          // ignore: cast_nullable_to_non_nullable
          : orgId as String,
      startedAt: startedAt == const $CopyWithPlaceholder()
          ? _value.startedAt
          // ignore: cast_nullable_to_non_nullable
          : startedAt as DateTime,
      startedBy: startedBy == const $CopyWithPlaceholder()
          ? _value.startedBy
          // ignore: cast_nullable_to_non_nullable
          : startedBy as String,
      startedByName: startedByName == const $CopyWithPlaceholder()
          ? _value.startedByName
          // ignore: cast_nullable_to_non_nullable
          : startedByName as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String,
    );
  }
}

extension $StocktakeCopyWith on Stocktake {
  /// Returns a callable class that can be used as follows: `instanceOfStocktake.copyWith(...)` or like so:`instanceOfStocktake.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StocktakeCWProxy get copyWith => _$StocktakeCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stocktake _$StocktakeFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Stocktake',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const [
        'branch_id',
        'created_at',
        'id',
        'org_id',
        'started_at',
        'started_by',
        'status',
      ],
    );
    final val = Stocktake(
      branchId: $checkedConvert('branch_id', (v) => v as String),
      branchName: $checkedConvert('branch_name', (v) => v as String?),
      createdAt: $checkedConvert(
        'created_at',
        (v) => DateTime.parse(v as String),
      ),
      finalizedAt: $checkedConvert(
        'finalized_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      finalizedBy: $checkedConvert('finalized_by', (v) => v as String?),
      id: $checkedConvert('id', (v) => v as String),
      note: $checkedConvert('note', (v) => v as String?),
      orgId: $checkedConvert('org_id', (v) => v as String),
      startedAt: $checkedConvert(
        'started_at',
        (v) => DateTime.parse(v as String),
      ),
      startedBy: $checkedConvert('started_by', (v) => v as String),
      startedByName: $checkedConvert('started_by_name', (v) => v as String?),
      status: $checkedConvert('status', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'branchId': 'branch_id',
    'branchName': 'branch_name',
    'createdAt': 'created_at',
    'finalizedAt': 'finalized_at',
    'finalizedBy': 'finalized_by',
    'orgId': 'org_id',
    'startedAt': 'started_at',
    'startedBy': 'started_by',
    'startedByName': 'started_by_name',
  },
);

Map<String, dynamic> _$StocktakeToJson(Stocktake instance) => <String, dynamic>{
  'branch_id': instance.branchId,
  'branch_name': ?instance.branchName,
  'created_at': instance.createdAt.toIso8601String(),
  'finalized_at': ?instance.finalizedAt?.toIso8601String(),
  'finalized_by': ?instance.finalizedBy,
  'id': instance.id,
  'note': ?instance.note,
  'org_id': instance.orgId,
  'started_at': instance.startedAt.toIso8601String(),
  'started_by': instance.startedBy,
  'started_by_name': ?instance.startedByName,
  'status': instance.status,
};
