//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UploadResponse {
  /// Returns a new [UploadResponse] instance.
  UploadResponse({

    required  this.imageUrl,
  });

  @JsonKey(
    
    name: r'image_url',
    required: true,
    includeIfNull: false,
  )


  final String imageUrl;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UploadResponse &&
      other.imageUrl == imageUrl;

    @override
    int get hashCode =>
        imageUrl.hashCode;

  factory UploadResponse.fromJson(Map<String, dynamic> json) => _$UploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

