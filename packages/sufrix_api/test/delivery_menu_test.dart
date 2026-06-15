import 'package:test/test.dart';
import 'package:sufrix_api/sufrix_api.dart';

// tests for DeliveryMenu
void main() {
  final DeliveryMenu? instance = /* DeliveryMenu(...) */ null;
  // TODO add properties to the entity

  group(DeliveryMenu, () {
    // Org-wide addon catalog (global, POS model): channel-effective, grouped by `type`, applicable to every item. Channel-unavailable options are excluded.
    // List<DeliveryAddonOption> addons
    test('to test the property `addons`', () async {
      // TODO
    });

    // List<DeliveryMenuCategory> categories
    test('to test the property `categories`', () async {
      // TODO
    });

    // The active discount for this channel (customer-facing) or `null`. Applies to the item subtotal only — the delivery fee is always charged in full.
    // DeliveryMenuDiscount discount
    test('to test the property `discount`', () async {
      // TODO
    });

    // List<DeliveryMenuItem> items
    test('to test the property `items`', () async {
      // TODO
    });

  });
}
