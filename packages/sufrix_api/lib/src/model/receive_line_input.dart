//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'receive_line_input.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ReceiveLineInput {
  /// Returns a new [ReceiveLineInput] instance.
  ReceiveLineInput({

    required  this.lineId,

    required  this.quantityReceived,
  });

  @JsonKey(
    
    name: r'line_id',
    required: true,
    includeIfNull: false,
  )


  final String lineId;



  @JsonKey(
    
    name: r'quantity_received',
    required: true,
    includeIfNull: false,
  )


  final double quantityReceived;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ReceiveLineInput &&
      other.lineId == lineId &&
      other.quantityReceived == quantityReceived;

    @override
    int get hashCode =>
        lineId.hashCode +
        quantityReceived.hashCode;

  factory ReceiveLineInput.fromJson(Map<String, dynamic> json) => _$ReceiveLineInputFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiveLineInputToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

