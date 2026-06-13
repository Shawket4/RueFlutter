//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum PeerPosition {
      @JsonValue(r'above')
      above(r'above'),
      @JsonValue(r'at')
      at(r'at'),
      @JsonValue(r'below')
      below(r'below'),
      @JsonValue(r'unknown_default_open_api')
      unknownDefaultOpenApi(r'unknown_default_open_api');

  const PeerPosition(this.value);

  final String value;

  @override
  String toString() => value;
}
