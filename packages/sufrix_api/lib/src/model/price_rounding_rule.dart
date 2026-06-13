//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

/// Serializes as `\"EgyptianCafe\"` / `\"NearestUnit\"` — PascalCase on the wire (no `rename_all`); existing clients depend on it.
enum PriceRoundingRule {
          /// Serializes as `\"EgyptianCafe\"` / `\"NearestUnit\"` — PascalCase on the wire (no `rename_all`); existing clients depend on it.
      @JsonValue(r'EgyptianCafe')
      egyptianCafe(r'EgyptianCafe'),
          /// Serializes as `\"EgyptianCafe\"` / `\"NearestUnit\"` — PascalCase on the wire (no `rename_all`); existing clients depend on it.
      @JsonValue(r'NearestUnit')
      nearestUnit(r'NearestUnit'),
          /// Serializes as `\"EgyptianCafe\"` / `\"NearestUnit\"` — PascalCase on the wire (no `rename_all`); existing clients depend on it.
      @JsonValue(r'unknown_default_open_api')
      unknownDefaultOpenApi(r'unknown_default_open_api');

  const PriceRoundingRule(this.value);

  final String value;

  @override
  String toString() => value;
}
