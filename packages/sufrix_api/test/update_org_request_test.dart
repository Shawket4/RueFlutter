import 'package:test/test.dart';
import 'package:sufrix_api/sufrix_api.dart';

// tests for UpdateOrgRequest
void main() {
  final UpdateOrgRequest? instance = /* UpdateOrgRequest(...) */ null;
  // TODO add properties to the entity

  group(UpdateOrgRequest, () {
    // String currencyCode
    test('to test the property `currencyCode`', () async {
      // TODO
    });

    // bool isActive
    test('to test the property `isActive`', () async {
      // TODO
    });

    // `null` clears the logo; absent leaves it unchanged. To set a new logo, use `PUT /orgs/{id}/logo` (multipart) instead — JSON updates only accept the clear-to-null case here.
    // String logoUrl
    test('to test the property `logoUrl`', () async {
      // TODO
    });

    // String name
    test('to test the property `name`', () async {
      // TODO
    });

    // String receiptFooter
    test('to test the property `receiptFooter`', () async {
      // TODO
    });

    // String slug
    test('to test the property `slug`', () async {
      // TODO
    });

    // double taxRate
    test('to test the property `taxRate`', () async {
      // TODO
    });

    // IANA timezone name (e.g. `Africa/Cairo`). Validated against the PostgreSQL timezone database. Branches inherit this when their own timezone is unset.
    // String timezone
    test('to test the property `timezone`', () async {
      // TODO
    });

  });
}
