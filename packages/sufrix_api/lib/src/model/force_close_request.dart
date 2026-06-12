//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'force_close_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ForceCloseRequest {
  /// Returns a new [ForceCloseRequest] instance.
  ForceCloseRequest({

     this.reason,
  });

  @JsonKey(
    
    name: r'reason',
    required: false,
    includeIfNull: false,
  )


  final String? reason;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ForceCloseRequest &&
      other.reason == reason;

    @override
    int get hashCode =>
        (reason == null ? 0 : reason.hashCode);

  factory ForceCloseRequest.fromJson(Map<String, dynamic> json) => _$ForceCloseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForceCloseRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

