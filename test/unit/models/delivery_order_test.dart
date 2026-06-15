import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/delivery_order.dart';

void main() {
  // A representative wire payload matching SufrixRust/src/delivery/staff.rs +
  // snapshot.rs (money in integer piastres).
  Map<String, dynamic> wire() => {
        'id': 'ord-1',
        'org_id': 'org-1',
        'branch_id': 'br-1',
        'channel': 'outside',
        'status': 'received',
        'delivery_ref': 'D-CAI-260615-0001',
        'customer_name': 'Mona',
        'customer_phone': '201001234567',
        'place_name': 'Tower A',
        'floor': '3',
        'unit_number': '12',
        'landmark': 'by the bank',
        'address_line': '5 Nile St',
        'delivery_notes': 'ring twice',
        'customer_lat': 30.05,
        'customer_lng': 31.23,
        'delivery_zone_id': 'zone-2',
        'road_distance_meters': 2400,
        'subtotal': 12000,
        'delivery_fee': 2500,
        'total': 14500,
        'extra_prep_minutes': 10,
        'payment_method_hint': 'cash',
        'otp_verified': true,
        'cancel_restocked': null,
        'created_at': '2026-06-15T10:00:00Z',
        'updated_at': '2026-06-15T10:05:00Z',
        'cart': {
          'lines': [
            {
              'menu_item_id': 'mi-1',
              'item_name': 'Latte',
              'name_translations': {'ar': 'لاتيه'},
              'size_label': 'large',
              'unit_price': 9000,
              'quantity': 1,
              'line_total': 11000,
              'notes': 'extra hot',
              'addons': [
                {
                  'addon_item_id': 'ad-1',
                  'addon_name': 'Oat milk',
                  'name_translations': {'ar': 'حليب شوفان'},
                  'unit_price': 2000,
                  'quantity': 1,
                  'line_cost': 800,
                }
              ],
              'optionals': [
                {
                  'optional_field_id': 'of-1',
                  'field_name': 'Cinnamon',
                  'name_translations': {},
                  'price': 0,
                }
              ],
              'line_cost': 3500,
              'unit_cost': 3500,
              'cost_missing': false,
            }
          ]
        },
      };

  test('fromJson maps every field incl. the nested cart', () {
    final o = DeliveryOrder.fromJson(wire());

    expect(o.id, 'ord-1');
    expect(o.channel, DeliveryChannel.outside);
    expect(o.isInMall, false);
    expect(o.status, DeliveryStatus.received);
    expect(o.deliveryRef, 'D-CAI-260615-0001');
    expect(o.deliveryZoneId, 'zone-2');
    expect(o.roadDistanceMeters, 2400);
    expect(o.otpVerified, true);
    expect(o.cancelRestocked, isNull);
    expect(o.subtotal, 12000);
    expect(o.deliveryFee, 2500);
    expect(o.total, 14500);
    expect(o.extraPrepMinutes, 10);

    expect(o.cart.lines, hasLength(1));
    final l = o.cart.lines.first;
    expect(l.menuItemId, 'mi-1');
    expect(l.itemName, 'Latte');
    expect(l.sizeLabel, 'large');
    expect(l.notes, 'extra hot');
    expect(l.lineCost, 3500);
    expect(l.costMissing, false);
    expect(l.addons, hasLength(1));
    expect(l.addons.first.addonItemId, 'ad-1');
    expect(l.addons.first.addonName, 'Oat milk');
    expect(l.addons.first.unitPrice, 2000);
    expect(l.optionals, hasLength(1));
    expect(l.optionals.first.optionalFieldId, 'of-1');
    expect(l.optionals.first.fieldName, 'Cinnamon');
  });

  test('toJson → fromJson round-trips losslessly (cache durability)', () {
    final original = DeliveryOrder.fromJson(wire());
    final round = DeliveryOrder.fromJson(original.toJson());

    expect(round.id, original.id);
    expect(round.channel, original.channel);
    expect(round.status, original.status);
    expect(round.deliveryRef, original.deliveryRef);
    expect(round.deliveryZoneId, original.deliveryZoneId);
    expect(round.roadDistanceMeters, original.roadDistanceMeters);
    expect(round.otpVerified, original.otpVerified);
    expect(round.subtotal, original.subtotal);
    expect(round.total, original.total);
    expect(round.extraPrepMinutes, original.extraPrepMinutes);
    expect(round.cart.lines.length, original.cart.lines.length);

    final rl = round.cart.lines.first;
    final ol = original.cart.lines.first;
    expect(rl.menuItemId, ol.menuItemId);
    expect(rl.itemName, ol.itemName);
    expect(rl.sizeLabel, ol.sizeLabel);
    expect(rl.notes, ol.notes);
    expect(rl.lineTotal, ol.lineTotal);
    expect(rl.addons.first.addonItemId, ol.addons.first.addonItemId);
    expect(rl.addons.first.unitPrice, ol.addons.first.unitPrice);
    expect(rl.optionals.first.optionalFieldId, ol.optionals.first.optionalFieldId);
    expect(rl.optionals.first.price, ol.optionals.first.price);
  });

  test('status + channel enums round-trip via wire identifiers', () {
    expect(DeliveryStatusX.fromWire('out_for_delivery'),
        DeliveryStatus.outForDelivery);
    expect(DeliveryStatus.outForDelivery.wire, 'out_for_delivery');
    expect(DeliveryChannel.fromWire('in_mall'), DeliveryChannel.inMall);
    expect(DeliveryChannel.inMall.wire, 'in_mall');
    expect(DeliveryStatusX.fromWire('weird'), DeliveryStatus.unknown);
  });

  test('forward transitions + terminal/active helpers', () {
    expect(DeliveryStatus.received.nextForward, DeliveryStatus.confirmed);
    expect(DeliveryStatus.ready.nextForward, DeliveryStatus.outForDelivery);
    expect(DeliveryStatus.outForDelivery.nextForward, isNull);
    expect(DeliveryStatus.delivered.isTerminal, true);
    expect(DeliveryStatus.preparing.isActive, true);
  });

  test('tolerates missing optional fields', () {
    final o = DeliveryOrder.fromJson({
      'id': 'x',
      'branch_id': 'b',
      'channel': 'in_mall',
      'status': 'confirmed',
      'customer_name': 'A',
      'customer_phone': '2010',
      'subtotal': 0,
      'delivery_fee': 0,
      'total': 0,
      'extra_prep_minutes': 0,
      'cart': {'lines': []},
      'created_at': '2026-06-15T10:00:00Z',
      'updated_at': '2026-06-15T10:00:00Z',
    });
    expect(o.otpVerified, false);
    expect(o.deliveryZoneId, isNull);
    expect(o.roadDistanceMeters, isNull);
    expect(o.cart.lines, isEmpty);
  });
}
