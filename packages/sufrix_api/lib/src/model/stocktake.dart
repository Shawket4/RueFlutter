//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stocktake.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Stocktake {
  /// Returns a new [Stocktake] instance.
  Stocktake({

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





    @override
    bool operator ==(Object other) => identical(this, other) || other is Stocktake &&
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
      other.status == status;

    @override
    int get hashCode =>
        branchId.hashCode +
        createdAt.hashCode +
        (finalizedAt == null ? 0 : finalizedAt.hashCode) +
        (finalizedBy == null ? 0 : finalizedBy.hashCode) +
        id.hashCode +
        (note == null ? 0 : note.hashCode) +
        orgId.hashCode +
        startedAt.hashCode +
        startedBy.hashCode +
        (startedByName == null ? 0 : startedByName.hashCode) +
        status.hashCode;

  factory Stocktake.fromJson(Map<String, dynamic> json) => _$StocktakeFromJson(json);

  Map<String, dynamic> toJson() => _$StocktakeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

