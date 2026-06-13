//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/purchase_order_line.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'purchase_order_full.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PurchaseOrderFull {
  /// Returns a new [PurchaseOrderFull] instance.
  PurchaseOrderFull({

    required  this.branchId,

    required  this.createdAt,

    required  this.createdBy,

     this.expectedAt,

    required  this.id,

     this.note,

    required  this.orgId,

     this.receivedAt,

     this.receivedBy,

     this.reference,

    required  this.status,

     this.supplierId,

     this.supplierName,

    required  this.updatedAt,

    required  this.lines,
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
    
    name: r'created_by',
    required: true,
    includeIfNull: false,
  )


  final String createdBy;



  @JsonKey(
    
    name: r'expected_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? expectedAt;



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
    
    name: r'received_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? receivedAt;



  @JsonKey(
    
    name: r'received_by',
    required: false,
    includeIfNull: false,
  )


  final String? receivedBy;



  @JsonKey(
    
    name: r'reference',
    required: false,
    includeIfNull: false,
  )


  final String? reference;



  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final String status;



  @JsonKey(
    
    name: r'supplier_id',
    required: false,
    includeIfNull: false,
  )


  final String? supplierId;



  @JsonKey(
    
    name: r'supplier_name',
    required: false,
    includeIfNull: false,
  )


  final String? supplierName;



  @JsonKey(
    
    name: r'updated_at',
    required: true,
    includeIfNull: false,
  )


  final DateTime updatedAt;



  @JsonKey(
    
    name: r'lines',
    required: true,
    includeIfNull: false,
  )


  final List<PurchaseOrderLine> lines;





    @override
    bool operator ==(Object other) => identical(this, other) || other is PurchaseOrderFull &&
      other.branchId == branchId &&
      other.createdAt == createdAt &&
      other.createdBy == createdBy &&
      other.expectedAt == expectedAt &&
      other.id == id &&
      other.note == note &&
      other.orgId == orgId &&
      other.receivedAt == receivedAt &&
      other.receivedBy == receivedBy &&
      other.reference == reference &&
      other.status == status &&
      other.supplierId == supplierId &&
      other.supplierName == supplierName &&
      other.updatedAt == updatedAt &&
      other.lines == lines;

    @override
    int get hashCode =>
        branchId.hashCode +
        createdAt.hashCode +
        createdBy.hashCode +
        expectedAt.hashCode +
        id.hashCode +
        note.hashCode +
        orgId.hashCode +
        receivedAt.hashCode +
        receivedBy.hashCode +
        reference.hashCode +
        status.hashCode +
        supplierId.hashCode +
        supplierName.hashCode +
        updatedAt.hashCode +
        lines.hashCode;

  factory PurchaseOrderFull.fromJson(Map<String, dynamic> json) => _$PurchaseOrderFullFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseOrderFullToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

