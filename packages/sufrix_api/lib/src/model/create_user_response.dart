//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sufrix_api/src/model/user_public.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_user_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CreateUserResponse {
  /// Returns a new [CreateUserResponse] instance.
  CreateUserResponse({

    required  this.user,
  });

  @JsonKey(
    
    name: r'user',
    required: true,
    includeIfNull: false,
  )


  final UserPublic user;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CreateUserResponse &&
      other.user == user;

    @override
    int get hashCode =>
        user.hashCode;

  factory CreateUserResponse.fromJson(Map<String, dynamic> json) => _$CreateUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

