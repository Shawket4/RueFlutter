//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum RevenueClass {
      @JsonValue(r'hero')
      hero(r'hero'),
      @JsonValue(r'steady')
      steady(r'steady'),
      @JsonValue(r'slow')
      slow(r'slow'),
      @JsonValue(r'quiet')
      quiet(r'quiet'),
      @JsonValue(r'unknown_default_open_api')
      unknownDefaultOpenApi(r'unknown_default_open_api');

  const RevenueClass(this.value);

  final String value;

  @override
  String toString() => value;
}
