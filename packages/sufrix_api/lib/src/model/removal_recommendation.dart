//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum RemovalRecommendation {
      @JsonValue(r'remove')
      remove(r'remove'),
      @JsonValue(r'keep_and_bundle')
      keepAndBundle(r'keep_and_bundle'),
      @JsonValue(r'keep_and_reformulate')
      keepAndReformulate(r'keep_and_reformulate'),
      @JsonValue(r'no_strong_signal')
      noStrongSignal(r'no_strong_signal'),
      @JsonValue(r'unknown_default_open_api')
      unknownDefaultOpenApi(r'unknown_default_open_api');

  const RemovalRecommendation(this.value);

  final String value;

  @override
  String toString() => value;
}
