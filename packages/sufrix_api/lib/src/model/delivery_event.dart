//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/delivery_order.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delivery_event.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DeliveryEvent {
  /// Returns a new [DeliveryEvent] instance.
  DeliveryEvent({

    required  this.eventType,

    required  this.order,
  });

      /// `\"created\"` (intake) | `\"updated\"` (status / cancel / finalize / prep-time).
  @JsonKey(
    
    name: r'event_type',
    required: true,
    includeIfNull: false,
  )


  final String eventType;



  @JsonKey(
    
    name: r'order',
    required: true,
    includeIfNull: false,
  )


  final DeliveryOrder order;





    @override
    bool operator ==(Object other) => identical(this, other) || other is DeliveryEvent &&
      other.eventType == eventType &&
      other.order == order;

    @override
    int get hashCode =>
        eventType.hashCode +
        order.hashCode;

  factory DeliveryEvent.fromJson(Map<String, dynamic> json) => _$DeliveryEventFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryEventToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

