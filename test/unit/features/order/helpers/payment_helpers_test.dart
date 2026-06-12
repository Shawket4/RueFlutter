import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/theme/app_theme.dart';
import 'package:sufrix_pos/features/order/helpers/payment_helpers.dart';

import '../../../../helpers/model_fixtures.dart';

void main() {
  final cash = makePaymentMethod(
    id: 'pm_cash',
    orgId: 'org1',
    name: 'cash',
    labelTranslations: {'en': 'Cash', 'ar': 'نقدي'},
    color: '#22C55E',
    icon: 'money',
    isCash: true,
    isActive: true,
    displayOrder: 1,
  );
  final card = makePaymentMethod(
    id: 'pm_card',
    orgId: 'org1',
    name: 'card',
    labelTranslations: {'en': 'Card', 'ar': 'بطاقة'},
    color: '#7C3AED',
    icon: 'credit_card',
    isCash: false,
    isActive: true,
    displayOrder: 2,
  );
  final methods = [cash, card];

  group('Payment Helpers', () {
    test('methodColor returns correct color', () {
      expect(methodColor(methods, 'cash'), cash.uiColor);
      expect(methodColor(methods, 'card'), card.uiColor);
      expect(methodColor(methods, 'unknown'), paymentMethodMixed().uiColor); // Defaults to mixed
    });

    test('methodLabel returns correct label', () {
      expect(methodLabel(methods, 'en', 'cash'), 'Cash');
      expect(methodLabel(methods, 'en', 'card'), 'Card');
    });

    test('isCashMethod returns correct boolean', () {
      expect(isCashMethod(methods, 'cash'), true);
      expect(isCashMethod(methods, 'card'), false);
    });

    test('addonTypeColor returns correct color', () {
      expect(addonTypeColor('milk_type'), AppColors.primary);
      expect(addonTypeColor('coffee_type'), const Color(0xFF795548));
      expect(addonTypeColor('extra'), AppColors.primary);
      expect(addonTypeColor('syrup'), const Color(0xFF9C27B0));
      expect(addonTypeColor('topping'), const Color(0xFFE91E63));
      expect(addonTypeColor('drizzle'), const Color(0xFF00BCD4));
      expect(addonTypeColor('unknown_type'), AppColors.primary);
    });

    test('addonTypeLabel formats label correctly', () {
      expect(addonTypeLabel('milk_type'), 'Milk Type');
      expect(addonTypeLabel('coffee_type'), 'Coffee Type');
      expect(addonTypeLabel('extra'), 'Extra');
      expect(addonTypeLabel('unknown_type'), 'Unknown Type');
    });
  });
}
