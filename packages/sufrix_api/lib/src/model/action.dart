//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum Action {
      @JsonValue(r'hold')
      hold(r'hold'),
      @JsonValue(r'raise_price')
      raisePrice(r'raise_price'),
      @JsonValue(r'lower_price')
      lowerPrice(r'lower_price'),
      @JsonValue(r'bundle')
      bundle(r'bundle'),
      @JsonValue(r'remove')
      remove(r'remove'),
      @JsonValue(r'reformulate')
      reformulate(r'reformulate'),
      @JsonValue(r'monitor')
      monitor(r'monitor'),
      @JsonValue(r'unknown_default_open_api')
      unknownDefaultOpenApi(r'unknown_default_open_api');

  const Action(this.value);

  final String value;

  @override
  String toString() => value;
}
