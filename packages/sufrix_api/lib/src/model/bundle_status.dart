//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum BundleStatus {
      @JsonValue(r'draft')
      draft(r'draft'),
      @JsonValue(r'active')
      active(r'active'),
      @JsonValue(r'archived')
      archived(r'archived'),
      @JsonValue(r'unknown_default_open_api')
      unknownDefaultOpenApi(r'unknown_default_open_api');

  const BundleStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
