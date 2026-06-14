import 'package:test/test.dart';
import 'package:sufrix_api/sufrix_api.dart';

// tests for MeResponse
void main() {
  final MeResponse? instance = /* MeResponse(...) */ null;
  // TODO add properties to the entity

  group(MeResponse, () {
    // Org currency code (e.g. \"EGP\").
    // String currencyCode
    test('to test the property `currencyCode`', () async {
      // TODO
    });

    // Org tax rate as a decimal (e.g. 0.14 = 14% VAT); 0.0 when the user has no org. Exposed so the POS can compute a tax-inclusive cart total client-side.
    // double taxRate
    test('to test the property `taxRate`', () async {
      // TODO
    });

    // UserPublic user
    test('to test the property `user`', () async {
      // TODO
    });

  });
}
