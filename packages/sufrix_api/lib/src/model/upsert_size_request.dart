//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upsert_size_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpsertSizeRequest {
  /// Returns a new [UpsertSizeRequest] instance.
  UpsertSizeRequest({

    required  this.label,

    required  this.priceOverride,
  });

  @JsonKey(
    
    name: r'label',
    required: true,
    includeIfNull: false,
  )


  final String label;



  @JsonKey(
    
    name: r'price_override',
    required: true,
    includeIfNull: false,
  )


  final int priceOverride;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpsertSizeRequest &&
      other.label == label &&
      other.priceOverride == priceOverride;

    @override
    int get hashCode =>
        label.hashCode +
        priceOverride.hashCode;

  factory UpsertSizeRequest.fromJson(Map<String, dynamic> json) => _$UpsertSizeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpsertSizeRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

