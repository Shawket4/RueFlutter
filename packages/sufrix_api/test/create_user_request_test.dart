import 'package:test/test.dart';
import 'package:sufrix_api/sufrix_api.dart';

// tests for CreateUserRequest
void main() {
  final CreateUserRequest? instance = /* CreateUserRequest(...) */ null;
  // TODO add properties to the entity

  group(CreateUserRequest, () {
    // Branches to assign the new user to immediately. Branch managers can only assign to branches they themselves are assigned to.
    // List<String> branchIds
    test('to test the property `branchIds`', () async {
      // TODO
    });

    // Required for admins and managers; ignored for tellers.
    // String email
    test('to test the property `email`', () async {
      // TODO
    });

    // String name
    test('to test the property `name`', () async {
      // TODO
    });

    // String orgId
    test('to test the property `orgId`', () async {
      // TODO
    });

    // Required when `role` is anything other than `teller`. Plain text; hashed server-side with bcrypt before storage.
    // String password
    test('to test the property `password`', () async {
      // TODO
    });

    // String phone
    test('to test the property `phone`', () async {
      // TODO
    });

    // Required when `role = teller`. 4–6 ASCII digits.
    // String pin
    test('to test the property `pin`', () async {
      // TODO
    });

    // UserRole role
    test('to test the property `role`', () async {
      // TODO
    });

  });
}
