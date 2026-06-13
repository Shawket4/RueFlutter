//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_waste_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateWasteRequest {
  /// Returns a new [CreateWasteRequest] instance.
  CreateWasteRequest({

     this.note,

    required  this.orgIngredientId,

    required  this.quantity,

    required  this.reason,
  });

  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;



  @JsonKey(
    
    name: r'org_ingredient_id',
    required: true,
    includeIfNull: false,
  )


  final String orgIngredientId;



  @JsonKey(
    
    name: r'quantity',
    required: true,
    includeIfNull: false,
  )


  final double quantity;



      /// expired | spoiled | damaged | overproduction | theft | other
  @JsonKey(
    
    name: r'reason',
    required: true,
    includeIfNull: false,
  )


  final String reason;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateWasteRequest &&
      other.note == note &&
      other.orgIngredientId == orgIngredientId &&
      other.quantity == quantity &&
      other.reason == reason;

    @override
    int get hashCode =>
        (note == null ? 0 : note.hashCode) +
        orgIngredientId.hashCode +
        quantity.hashCode +
        reason.hashCode;

  factory CreateWasteRequest.fromJson(Map<String, dynamic> json) => _$CreateWasteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateWasteRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

