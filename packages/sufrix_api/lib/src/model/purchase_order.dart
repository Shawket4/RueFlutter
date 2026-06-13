//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'purchase_order.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class PurchaseOrder {
  /// Returns a new [PurchaseOrder] instance.
  PurchaseOrder({

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





    @override
    bool operator ==(Object other) => identical(this, other) || other is PurchaseOrder &&
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
      other.updatedAt == updatedAt;

    @override
    int get hashCode =>
        branchId.hashCode +
        createdAt.hashCode +
        createdBy.hashCode +
        (expectedAt == null ? 0 : expectedAt.hashCode) +
        id.hashCode +
        (note == null ? 0 : note.hashCode) +
        orgId.hashCode +
        (receivedAt == null ? 0 : receivedAt.hashCode) +
        (receivedBy == null ? 0 : receivedBy.hashCode) +
        (reference == null ? 0 : reference.hashCode) +
        status.hashCode +
        (supplierId == null ? 0 : supplierId.hashCode) +
        (supplierName == null ? 0 : supplierName.hashCode) +
        updatedAt.hashCode;

  factory PurchaseOrder.fromJson(Map<String, dynamic> json) => _$PurchaseOrderFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseOrderToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

