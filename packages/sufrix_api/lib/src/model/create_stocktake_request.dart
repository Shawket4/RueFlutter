//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_stocktake_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateStocktakeRequest {
  /// Returns a new [CreateStocktakeRequest] instance.
  CreateStocktakeRequest({

     this.note,
  });

  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateStocktakeRequest &&
      other.note == note;

    @override
    int get hashCode =>
        (note == null ? 0 : note.hashCode);

  factory CreateStocktakeRequest.fromJson(Map<String, dynamic> json) => _$CreateStocktakeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateStocktakeRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

