import 'package:test/test.dart';
import 'package:sufrix_api/sufrix_api.dart';

// tests for LoginResponse
void main() {
  final LoginResponse? instance = /* LoginResponse(...) */ null;
  // TODO add properties to the entity

  group(LoginResponse, () {
    // String currencyCode
    test('to test the property `currencyCode`', () async {
      // TODO
    });

    // Org tax rate as a decimal (e.g. 0.14 = 14% VAT); 0.0 when no org. Mirrors /auth/me so the POS has it immediately after login.
    // double taxRate
    test('to test the property `taxRate`', () async {
      // TODO
    });

    // JWT to send as `Authorization: Bearer <token>` on subsequent requests.
    // String token
    test('to test the property `token`', () async {
      // TODO
    });

    // UserPublic user
    test('to test the property `user`', () async {
      // TODO
    });

  });
}
