//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/po_line_input.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_purchase_order_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreatePurchaseOrderRequest {
  /// Returns a new [CreatePurchaseOrderRequest] instance.
  CreatePurchaseOrderRequest({

     this.expectedAt,

    required  this.lines,

     this.note,

     this.reference,

     this.supplierId,
  });

  @JsonKey(
    
    name: r'expected_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? expectedAt;



  @JsonKey(
    
    name: r'lines',
    required: true,
    includeIfNull: false,
  )


  final List<POLineInput> lines;



  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;



  @JsonKey(
    
    name: r'reference',
    required: false,
    includeIfNull: false,
  )


  final String? reference;



  @JsonKey(
    
    name: r'supplier_id',
    required: false,
    includeIfNull: false,
  )


  final String? supplierId;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreatePurchaseOrderRequest &&
      other.expectedAt == expectedAt &&
      other.lines == lines &&
      other.note == note &&
      other.reference == reference &&
      other.supplierId == supplierId;

    @override
    int get hashCode =>
        (expectedAt == null ? 0 : expectedAt.hashCode) +
        lines.hashCode +
        (note == null ? 0 : note.hashCode) +
        (reference == null ? 0 : reference.hashCode) +
        (supplierId == null ? 0 : supplierId.hashCode);

  factory CreatePurchaseOrderRequest.fromJson(Map<String, dynamic> json) => _$CreatePurchaseOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePurchaseOrderRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

