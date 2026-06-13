//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum SuggestionKind {
      @JsonValue(r'price')
      price(r'price'),
      @JsonValue(r'bundle')
      bundle(r'bundle'),
      @JsonValue(r'removal')
      removal(r'removal'),
      @JsonValue(r'unknown_default_open_api')
      unknownDefaultOpenApi(r'unknown_default_open_api');

  const SuggestionKind(this.value);

  final String value;

  @override
  String toString() => value;
}
