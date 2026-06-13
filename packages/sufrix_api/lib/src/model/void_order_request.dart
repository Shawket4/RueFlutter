//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'void_order_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class VoidOrderRequest {
  /// Returns a new [VoidOrderRequest] instance.
  VoidOrderRequest({

     this.note,

    required  this.reason,

     this.restoreInventory,

     this.voidedAt,
  });

      /// Free-text explanation. Required when `reason` is \"other\".
  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;



  @JsonKey(
    
    name: r'reason',
    required: true,
    includeIfNull: false,
  )


  final String reason;



  @JsonKey(
    
    name: r'restore_inventory',
    required: false,
    includeIfNull: false,
  )


  final bool? restoreInventory;



  @JsonKey(
    
    name: r'voided_at',
    required: false,
    includeIfNull: false,
  )


  final DateTime? voidedAt;





    @override
    bool operator ==(Object other) => identical(this, other) || other is VoidOrderRequest &&
      other.note == note &&
      other.reason == reason &&
      other.restoreInventory == restoreInventory &&
      other.voidedAt == voidedAt;

    @override
    int get hashCode =>
        (note == null ? 0 : note.hashCode) +
        reason.hashCode +
        (restoreInventory == null ? 0 : restoreInventory.hashCode) +
        (voidedAt == null ? 0 : voidedAt.hashCode);

  factory VoidOrderRequest.fromJson(Map<String, dynamic> json) => _$VoidOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VoidOrderRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

