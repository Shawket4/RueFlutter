import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/payment_method.dart';

void main() {
  group('PaymentMethod', () {
    test('fromWire returns correct enum', () {
      expect(PaymentMethod.fromWire('cash'), PaymentMethod.cash);
      expect(PaymentMethod.fromWire('card'), PaymentMethod.card);
      expect(PaymentMethod.fromWire('digital_wallet'), PaymentMethod.digitalWallet);
      expect(PaymentMethod.fromWire('mixed'), PaymentMethod.mixed);
      expect(PaymentMethod.fromWire('talabat_online'), PaymentMethod.talabatOnline);
      expect(PaymentMethod.fromWire('talabat_cash'), PaymentMethod.talabatCash);
    });

    test('fromWire defaults to cash on unknown format', () {
      expect(PaymentMethod.fromWire('unknown_format'), PaymentMethod.cash);
      expect(PaymentMethod.fromWire(''), PaymentMethod.cash);
    });

    test('isCash correctly flagged', () {
      expect(PaymentMethod.cash.isCash, true);
      expect(PaymentMethod.talabatCash.isCash, true);
      
      expect(PaymentMethod.card.isCash, false);
      expect(PaymentMethod.digitalWallet.isCash, false);
      expect(PaymentMethod.mixed.isCash, false);
      expect(PaymentMethod.talabatOnline.isCash, false);
    });
  });
}
