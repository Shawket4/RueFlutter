//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_transfer_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateTransferRequest {
  /// Returns a new [UpdateTransferRequest] instance.
  UpdateTransferRequest({

     this.note,
  });

  @JsonKey(
    
    name: r'note',
    required: false,
    includeIfNull: false,
  )


  final String? note;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpdateTransferRequest &&
      other.note == note;

    @override
    int get hashCode =>
        (note == null ? 0 : note.hashCode);

  factory UpdateTransferRequest.fromJson(Map<String, dynamic> json) => _$UpdateTransferRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTransferRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

