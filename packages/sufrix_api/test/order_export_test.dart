import 'package:test/test.dart';
import 'package:sufrix_api/sufrix_api.dart';

// tests for OrderExport
void main() {
  final OrderExport? instance = /* OrderExport(...) */ null;
  // TODO add properties to the entity

  group(OrderExport, () {
    // int amountTendered
    test('to test the property `amountTendered`', () async {
      // TODO
    });

    // String branchId
    test('to test the property `branchId`', () async {
      // TODO
    });

    // int changeGiven
    test('to test the property `changeGiven`', () async {
      // TODO
    });

    // DateTime createdAt
    test('to test the property `createdAt`', () async {
      // TODO
    });

    // String customerName
    test('to test the property `customerName`', () async {
      // TODO
    });

    // Delivery channel (\"in_mall\" | \"outside\") of the linked delivery order, surfaced on the list so clients can flag + segment delivery orders without a per-order detail fetch. `null` for dine-in orders.
    // String deliveryChannel
    test('to test the property `deliveryChannel`', () async {
      // TODO
    });

    // Delivery charge in piastres, shown separately from the item subtotal. Always 0 for dine-in orders; for delivery orders `total_amount == subtotal + tax_amount + delivery_fee` (minus discount).
    // int deliveryFee
    test('to test the property `deliveryFee`', () async {
      // TODO
    });

    // Links a finalized delivery order back to its `delivery_orders` row (customer, address, channel, zone). `null` for dine-in orders.
    // String deliveryOrderId
    test('to test the property `deliveryOrderId`', () async {
      // TODO
    });

    // int discountAmount
    test('to test the property `discountAmount`', () async {
      // TODO
    });

    // String discountId
    test('to test the property `discountId`', () async {
      // TODO
    });

    // String discountType
    test('to test the property `discountType`', () async {
      // TODO
    });

    // int discountValue
    test('to test the property `discountValue`', () async {
      // TODO
    });

    // String id
    test('to test the property `id`', () async {
      // TODO
    });

    // String notes
    test('to test the property `notes`', () async {
      // TODO
    });

    // int orderNumber
    test('to test the property `orderNumber`', () async {
      // TODO
    });

    // Human-readable, org-unique reference (e.g. \"DT-260614-0042\"). Additive alongside the per-shift order_number. Optional only during the rollout window before the historical backfill runs; never null afterwards.
    // String orderRef
    test('to test the property `orderRef`', () async {
      // TODO
    });

    // Order origin: \"dine_in\" (POS sale) or \"delivery\" (finalized delivery order). Defaults to \"dine_in\" for every POS sale.
    // String orderType
    test('to test the property `orderType`', () async {
      // TODO
    });

    // String paymentMethod
    test('to test the property `paymentMethod`', () async {
      // TODO
    });

    // String shiftId
    test('to test the property `shiftId`', () async {
      // TODO
    });

    // String status
    test('to test the property `status`', () async {
      // TODO
    });

    // int subtotal
    test('to test the property `subtotal`', () async {
      // TODO
    });

    // int taxAmount
    test('to test the property `taxAmount`', () async {
      // TODO
    });

    // String tellerId
    test('to test the property `tellerId`', () async {
      // TODO
    });

    // String tellerName
    test('to test the property `tellerName`', () async {
      // TODO
    });

    // int tipAmount
    test('to test the property `tipAmount`', () async {
      // TODO
    });

    // String tipPaymentMethod
    test('to test the property `tipPaymentMethod`', () async {
      // TODO
    });

    // int totalAmount
    test('to test the property `totalAmount`', () async {
      // TODO
    });

    // String voidNote
    test('to test the property `voidNote`', () async {
      // TODO
    });

    // String voidReason
    test('to test the property `voidReason`', () async {
      // TODO
    });

    // DateTime voidedAt
    test('to test the property `voidedAt`', () async {
      // TODO
    });

    // String voidedBy
    test('to test the property `voidedBy`', () async {
      // TODO
    });

    // List<OrderItemFull> items
    test('to test the property `items`', () async {
      // TODO
    });

    // List<OrderPayment> payments
    test('to test the property `payments`', () async {
      // TODO
    });

  });
}
