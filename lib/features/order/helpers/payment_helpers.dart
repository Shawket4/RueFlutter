import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/payment_method.dart';

export '../../../core/models/payment_method.dart';

PaymentMethod _findMethod(List<PaymentMethod> methods, String m) {
  if (m == 'mixed') return paymentMethodMixed();

  try {
    return methods.firstWhere((x) => x.wireFormat == m);
  } catch (_) {}

  if (m == 'card' || m == 'credit_card') {
    try {
      return methods.firstWhere((x) => x.wireFormat == 'card' || x.wireFormat == 'credit_card');
    } catch (_) {}

    return paymentMethodStub(
      id: 'card_stub',
      name: 'card',
      labelTranslations: const {'en': 'Card', 'ar': 'بطاقة'},
      color: '#7C3AED',
      icon: 'credit_card',
      isCash: false,
    );
  }

  if (m == 'cash' || m == 'talabat_cash') {
    return paymentMethodStub(
      id: 'cash_stub',
      name: m,
      labelTranslations: const {'en': 'Cash', 'ar': 'نقدي'},
      color: '#22C55E', // AppColors.success roughly
      icon: 'money',
      isCash: true,
    );
  }

  return paymentMethodMixed();
}

Color methodColor(List<PaymentMethod> methods, String m) => _findMethod(methods, m).uiColor;
String methodLabel(List<PaymentMethod> methods, String locale, String m) => _findMethod(methods, m).label(locale);
bool isCashMethod(List<PaymentMethod> methods, String m) => _findMethod(methods, m).isCash;

// ── Addon-type accent colours ────────────────────────────────────────────────
Color addonTypeColor(String addonType) => switch (addonType) {
      'milk_type' => AppColors.primary,          // Changed from yellow to primary blue
      'coffee_type' => const Color(0xFF795548),  // brown
      'extra' => AppColors.primary,              // blue
      'syrup' => const Color(0xFF9C27B0),        // purple
      'topping' => const Color(0xFFE91E63),      // pink
      'drizzle' => const Color(0xFF00BCD4),      // teal
      _ => AppColors.primary,
    };

String addonTypeLabel(String addonType) => addonType
    .replaceAll('_', ' ')
    .split(' ')
    .map((w) => w.isEmpty ? '' : w[0].toUpperCase() + w.substring(1))
    .join(' ');
