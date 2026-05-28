import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/theme/app_theme.dart';
import 'package:sufrix_pos/features/order/helpers/payment_helpers.dart';

void main() {
  group('Payment Helpers', () {
    test('methodColor returns correct color', () {
      expect(methodColor('cash'), PaymentMethod.cash.color);
      expect(methodColor('card'), PaymentMethod.card.color);
      expect(methodColor('unknown'), PaymentMethod.cash.color); // Defaults to cash
    });

    test('methodLabel returns correct label', () {
      expect(methodLabel('cash'), 'Cash');
      expect(methodLabel('card'), 'Card');
    });

    test('isCashMethod returns correct boolean', () {
      expect(isCashMethod('cash'), true);
      expect(isCashMethod('card'), false);
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
