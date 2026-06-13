//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/stocktake_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stocktake_full.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StocktakeFull {
  /// Returns a new [StocktakeFull] instance.
  StocktakeFull({

    required  this.branchId,

    required  this.createdAt,

     this.finalizedAt,

     this.finalizedBy,

    required  this.id,

     this.note,

    required  this.orgId,

    required  this.startedAt,

    required  this.startedBy,

     this.startedByName,

    required  this.status,

    required  this.items,

    required  this.varianceThresholdPct,
  });

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
    
    name: r'finalized_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? finalizedAt;



  @JsonKey(
    
    name: r'finalized_by',
    required: false,
    includeIfNull: false,
  )


  final String? finalizedBy;



  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;



  @JsonKey(
    
    name: r'org_id',
    required: true,
    includeIfNull: false,
  )


  final String orgId;



  @JsonKey(
    
    name: r'started_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime startedAt;



  @JsonKey(
    
    name: r'started_by',
    required: true,
    includeIfNull: false,
  )


  final String startedBy;



  @JsonKey(
    
    name: r'started_by_name',
    required: false,
    includeIfNull: false,
  )


  final String? startedByName;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final String status;



  @JsonKey(
    
    name: r'items',
    required: true,
    includeIfNull: false,
  )


  final List<StocktakeItem> items;



      /// Org tolerance: a counted row whose |difference| is >= this percent of the expected quantity (or that appears-from / vanishes-to zero) is flagged and requires a `variance_reason` before the count can be finalized.
  @JsonKey(
    
    name: r'variance_threshold_pct',
    required: true,
    includeIfNull: false,
  )


  final double varianceThresholdPct;





    @override
    bool operator ==(Object other) => identical(this, other) || other is StocktakeFull &&
      other.branchId == branchId &&
      other.createdAt == createdAt &&
      other.finalizedAt == finalizedAt &&
      other.finalizedBy == finalizedBy &&
      other.id == id &&
      other.note == note &&
      other.orgId == orgId &&
      other.startedAt == startedAt &&
      other.startedBy == startedBy &&
      other.startedByName == startedByName &&
      other.status == status &&
      other.items == items &&
      other.varianceThresholdPct == varianceThresholdPct;

    @override
    int get hashCode =>
        branchId.hashCode +
        createdAt.hashCode +
        finalizedAt.hashCode +
        finalizedBy.hashCode +
        id.hashCode +
        note.hashCode +
        orgId.hashCode +
        startedAt.hashCode +
        startedBy.hashCode +
        startedByName.hashCode +
        status.hashCode +
        items.hashCode +
        varianceThresholdPct.hashCode;

  factory StocktakeFull.fromJson(Map<String, dynamic> json) => _$StocktakeFullFromJson(json);

  Map<String, dynamic> toJson() => _$StocktakeFullToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

