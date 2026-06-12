//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum UserRole {
      @JsonValue(r'super_admin')
      superAdmin(r'super_admin'),
      @JsonValue(r'org_admin')
      orgAdmin(r'org_admin'),
      @JsonValue(r'branch_manager')
      branchManager(r'branch_manager'),
      @JsonValue(r'teller')
      teller(r'teller'),
      @JsonValue(r'unknown_default_open_api')
      unknownDefaultOpenApi(r'unknown_default_open_api');

  const UserRole(this.value);

  final String value;

  @override
  String toString() => value;
}
