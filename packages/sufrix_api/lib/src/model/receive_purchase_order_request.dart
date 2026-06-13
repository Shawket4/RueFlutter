//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/receive_line_input.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receive_purchase_order_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReceivePurchaseOrderRequest {
  /// Returns a new [ReceivePurchaseOrderRequest] instance.
  ReceivePurchaseOrderRequest({

    required  this.lines,
  });

  @JsonKey(
    
    name: r'lines',
    required: true,
    includeIfNull: false,
  )


  final List<ReceiveLineInput> lines;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ReceivePurchaseOrderRequest &&
      other.lines == lines;

    @override
    int get hashCode =>
        lines.hashCode;

  factory ReceivePurchaseOrderRequest.fromJson(Map<String, dynamic> json) => _$ReceivePurchaseOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReceivePurchaseOrderRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

