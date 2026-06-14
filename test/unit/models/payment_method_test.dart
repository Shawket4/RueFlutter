import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/payment_method.dart';

import '../../helpers/model_fixtures.dart';

void main() {
  group('PaymentMethod', () {
    test('fromJson parses correctly', () {
      final method = PaymentMethod.fromJson({
        'id': 'pm1',
        'org_id': 'org1',
        'name': 'cash',
        'label_translations': {'en': 'Cash', 'ar': 'نقدي'},
        'color': '#22C55E',
        'icon': 'money',
        'is_cash': true,
        'is_active': true,
        'display_order': 1,
        'created_at': '2026-01-01T00:00:00.000Z',
        'updated_at': '2026-01-01T00:00:00.000Z',
      });

      expect(method.id, 'pm1');
      expect(method.orgId, 'org1');
      expect(method.wireFormat, 'cash');
      expect(method.isCash, true);
      expect(method.isActive, true);
    });

    test('toJson keeps wire key names', () {
      final json = {
        'id': 'pm2',
        'org_id': 'org1',
        'name': 'card',
        'label_translations': {'en': 'Card'},
        'color': '#7C3AED',
        'icon': 'credit_card',
        'is_cash': false,
        'is_active': true,
        'created_at': '2026-01-01T00:00:00.000Z',
        'updated_at': '2026-01-01T00:00:00.000Z',
      };
      final out = PaymentMethod.fromJson(json).toJson();
      expect(out['id'], 'pm2');
      expect(out['org_id'], 'org1');
      expect(out['name'], 'card');
      expect(out['label_translations'], {'en': 'Card'});
      expect(out['color'], '#7C3AED');
      expect(out['icon'], 'credit_card');
      expect(out['is_cash'], false);
      expect(out['is_active'], true);
      // display_order was removed from the payment-method contract.
      expect(out.containsKey('display_order'), false);
    });

    test('label falls back to English then wire name', () {
      final method = makePaymentMethod(
        name: 'cash',
        labelTranslations: {'en': 'Cash', 'ar': 'نقدي'},
      );
      expect(method.label('en'), 'Cash');
      expect(method.label('ar'), 'نقدي');
      expect(method.label('fr'), 'Cash'); // falls back to English

      final noLabels = makePaymentMethod(name: 'cash', labelTranslations: {});
      expect(noLabels.label('en'), 'cash'); // falls back to wire name
    });

    test('uiColor parses 6-digit hex', () {
      final method = makePaymentMethod(color: '#22C55E');
      expect(method.uiColor, const Color(0xFF22C55E));
    });

    test('uiIcon maps wire icon names', () {
      expect(makePaymentMethod(icon: 'money').uiIcon, Icons.payments_outlined);
      expect(makePaymentMethod(icon: 'credit_card').uiIcon,
          Icons.credit_card_rounded);
      expect(makePaymentMethod(icon: 'whatever').uiIcon,
          Icons.payments_outlined);
    });

    test('paymentMethodMixed fallback is not cash', () {
      final mixed = paymentMethodMixed();
      expect(mixed.wireFormat, 'mixed');
      expect(mixed.isCash, false);
    });
  });
}
