//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum Decision {
      @JsonValue(r'accepted')
      accepted(r'accepted'),
      @JsonValue(r'rejected')
      rejected(r'rejected'),
      @JsonValue(r'ignored')
      ignored(r'ignored'),
      @JsonValue(r'unknown_default_open_api')
      unknownDefaultOpenApi(r'unknown_default_open_api');

  const Decision(this.value);

  final String value;

  @override
  String toString() => value;
}
