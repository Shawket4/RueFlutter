// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stocktake_full.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$StocktakeFullCWProxy {
  StocktakeFull branchId(String branchId);

  StocktakeFull createdAt(DateTime createdAt);

  StocktakeFull finalizedAt(DateTime? finalizedAt);

  StocktakeFull finalizedBy(String? finalizedBy);

  StocktakeFull id(String id);

  StocktakeFull note(String? note);

  StocktakeFull orgId(String orgId);

  StocktakeFull startedAt(DateTime startedAt);

  StocktakeFull startedBy(String startedBy);

  StocktakeFull startedByName(String? startedByName);

  StocktakeFull status(String status);

  StocktakeFull items(List<StocktakeItem> items);

  StocktakeFull varianceThresholdPct(double varianceThresholdPct);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StocktakeFull(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StocktakeFull(...).copyWith(id: 12, name: "My name")
  /// ````
  StocktakeFull call({
    String branchId,
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
    List<StocktakeItem> items,
    double varianceThresholdPct,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfStocktakeFull.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfStocktakeFull.copyWith.fieldName(...)`
class _$StocktakeFullCWProxyImpl implements _$StocktakeFullCWProxy {
  const _$StocktakeFullCWProxyImpl(this._value);

  final StocktakeFull _value;

  @override
  StocktakeFull branchId(String branchId) => this(branchId: branchId);

  @override
  StocktakeFull createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  StocktakeFull finalizedAt(DateTime? finalizedAt) =>
      this(finalizedAt: finalizedAt);

  @override
  StocktakeFull finalizedBy(String? finalizedBy) =>
      this(finalizedBy: finalizedBy);

  @override
  StocktakeFull id(String id) => this(id: id);

  @override
  StocktakeFull note(String? note) => this(note: note);

  @override
  StocktakeFull orgId(String orgId) => this(orgId: orgId);

  @override
  StocktakeFull startedAt(DateTime startedAt) => this(startedAt: startedAt);

  @override
  StocktakeFull startedBy(String startedBy) => this(startedBy: startedBy);

  @override
  StocktakeFull startedByName(String? startedByName) =>
      this(startedByName: startedByName);

  @override
  StocktakeFull status(String status) => this(status: status);

  @override
  StocktakeFull items(List<StocktakeItem> items) => this(items: items);

  @override
  StocktakeFull varianceThresholdPct(double varianceThresholdPct) =>
      this(varianceThresholdPct: varianceThresholdPct);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `StocktakeFull(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// StocktakeFull(...).copyWith(id: 12, name: "My name")
  /// ````
  StocktakeFull call({
    Object? branchId = const $CopyWithPlaceholder(),
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
    Object? items = const $CopyWithPlaceholder(),
    Object? varianceThresholdPct = const $CopyWithPlaceholder(),
  }) {
    return StocktakeFull(
      branchId: branchId == const $CopyWithPlaceholder()
          ? _value.branchId
          // ignore: cast_nullable_to_non_nullable
          : branchId as String,
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
      items: items == const $CopyWithPlaceholder()
          ? _value.items
          // ignore: cast_nullable_to_non_nullable
          : items as List<StocktakeItem>,
      varianceThresholdPct: varianceThresholdPct == const $CopyWithPlaceholder()
          ? _value.varianceThresholdPct
          // ignore: cast_nullable_to_non_nullable
          : varianceThresholdPct as double,
    );
  }
}

extension $StocktakeFullCopyWith on StocktakeFull {
  /// Returns a callable class that can be used as follows: `instanceOfStocktakeFull.copyWith(...)` or like so:`instanceOfStocktakeFull.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$StocktakeFullCWProxy get copyWith => _$StocktakeFullCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StocktakeFull _$StocktakeFullFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'StocktakeFull',
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
            'items',
            'variance_threshold_pct',
          ],
        );
        final val = StocktakeFull(
          branchId: $checkedConvert('branch_id', (v) => v as String),
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
          startedByName: $checkedConvert(
            'started_by_name',
            (v) => v as String?,
          ),
          status: $checkedConvert('status', (v) => v as String),
          items: $checkedConvert(
            'items',
            (v) => (v as List<dynamic>)
                .map((e) => StocktakeItem.fromJson(e as Map<String, dynamic>))
                .toList(),
          ),
          varianceThresholdPct: $checkedConvert(
            'variance_threshold_pct',
            (v) => (v is String ? double.parse(v) : (v as num).toDouble()),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'branchId': 'branch_id',
        'createdAt': 'created_at',
        'finalizedAt': 'finalized_at',
        'finalizedBy': 'finalized_by',
        'orgId': 'org_id',
        'startedAt': 'started_at',
        'startedBy': 'started_by',
        'startedByName': 'started_by_name',
        'varianceThresholdPct': 'variance_threshold_pct',
      },
    );

Map<String, dynamic> _$StocktakeFullToJson(StocktakeFull instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
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
      'items': instance.items.map((e) => e.toJson()).toList(),
      'variance_threshold_pct': instance.varianceThresholdPct,
    };
