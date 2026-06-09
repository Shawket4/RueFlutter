import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/payment_method.dart';

export '../../../core/models/payment_method.dart';

PaymentMethod _findMethod(List<PaymentMethod> methods, String m) {
  if (m == 'mixed') return PaymentMethod.mixed();
  
  try {
    return methods.firstWhere((x) => x.wireFormat == m);
  } catch (_) {}

  if (m == 'card' || m == 'credit_card') {
    try {
      return methods.firstWhere((x) => x.wireFormat == 'card' || x.wireFormat == 'credit_card');
    } catch (_) {}
    
    return const PaymentMethod(
      id: 'card_stub',
      orgId: '',
      wireFormat: 'card',
      labelTranslations: {'en': 'Card', 'ar': 'بطاقة'},
      colorHex: '#7C3AED',
      iconName: 'credit_card',
      isCash: false,
      isActive: true,
      displayOrder: 99,
    );
  }

  if (m == 'cash' || m == 'talabat_cash') {
    return PaymentMethod(
      id: 'cash_stub',
      orgId: '',
      wireFormat: m,
      labelTranslations: {'en': 'Cash', 'ar': 'نقدي'},
      colorHex: '#22C55E', // AppColors.success roughly
      iconName: 'money',
      isCash: true,
      isActive: true,
      displayOrder: 1,
    );
  }
  
  return PaymentMethod.mixed();
}

Color methodColor(List<PaymentMethod> methods, String m) => _findMethod(methods, m).color;
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
