// Façade over the OpenAPI-generated wire models (packages/sufrix_api).
// The app's `PaymentMethod` is the spec's `OrgPaymentMethod`.
import 'package:flutter/material.dart';
import 'package:sufrix_api/sufrix_api.dart';
import '../theme/app_theme.dart';

export 'package:sufrix_api/sufrix_api.dart' show OrgPaymentMethod;

typedef PaymentMethod = OrgPaymentMethod;

extension PaymentMethodX on OrgPaymentMethod {
  /// Wire identifier used in order payloads (`payment_method`).
  String get wireFormat => name;

  /// Gets the localized label, falling back to English or the raw name.
  String label(String locale) {
    final translations = labelTranslations;
    if (translations is Map) {
      final lang = locale.substring(0, 2);
      final localized = translations[lang];
      if (localized is String) return localized;
      final english = translations['en'];
      if (english is String) return english;
    }
    return name;
  }

  /// UI colour parsed from the wire `color` hex string.
  /// (Named `uiColor` because the generated model already has a String
  /// field called `color`.)
  Color get uiColor {
    if (color.isEmpty) return AppColors.primary;
    try {
      final hex = color.replaceAll('#', '');
      if (hex.length == 6) {
        return Color(int.parse('FF$hex', radix: 16));
      }
      if (hex.length == 8) {
        return Color(int.parse(hex, radix: 16));
      }
      return AppColors.primary;
    } catch (_) {
      return AppColors.primary;
    }
  }

  /// UI icon mapped from the wire `icon` name.
  /// (Named `uiIcon` because the generated model already has a String
  /// field called `icon`.)
  IconData get uiIcon {
    switch (icon) {
      case 'money': return Icons.payments_outlined;
      case 'credit_card': return Icons.credit_card_rounded;
      case 'wallet': return Icons.account_balance_wallet_rounded;
      case 'pie_chart': return Icons.pie_chart_rounded;
      case 'delivery': return Icons.delivery_dining_rounded;
      case 'qr_code': return Icons.qr_code_rounded;
      case 'bank': return Icons.account_balance_rounded;
      case 'gift_card': return Icons.card_giftcard_rounded;
      case 'smartphone': return Icons.smartphone_rounded;
      case 'receipt': return Icons.receipt_long_rounded;
      case 'store': return Icons.storefront_rounded;
      case 'star': return Icons.star_rounded;
      case 'link': return Icons.link_rounded;
      // Fallback for old seeds before migration
      case 'payments_outlined': return Icons.payments_outlined;
      case 'credit_card_rounded': return Icons.credit_card_rounded;
      case 'account_balance_wallet_rounded':
        return Icons.account_balance_wallet_rounded;
      case 'delivery_dining_rounded': return Icons.delivery_dining_rounded;
      case 'pie_chart_rounded': return Icons.pie_chart_rounded;
      default: return Icons.payments_outlined;
    }
  }
}

/// Synthetic client-side method used by the split-payments UI — not a wire
/// entity. (Replaces the old `PaymentMethod.mixed()` factory.)
PaymentMethod paymentMethodMixed() => _syntheticMethod(
      id: 'mixed',
      name: 'mixed',
      labelTranslations: const {'en': 'Mixed', 'ar': 'متعدد'},
      color: '#3B82F6',
      icon: 'pie_chart',
      isCash: false,
      displayOrder: 999,
    );

/// Builds a client-side stub method (offline fallbacks in payment helpers).
PaymentMethod paymentMethodStub({
  required String id,
  required String name,
  required Map<String, dynamic> labelTranslations,
  required String color,
  required String icon,
  required bool isCash,
  int displayOrder = 99,
}) =>
    _syntheticMethod(
      id: id,
      name: name,
      labelTranslations: labelTranslations,
      color: color,
      icon: icon,
      isCash: isCash,
      displayOrder: displayOrder,
    );

PaymentMethod _syntheticMethod({
  required String id,
  required String name,
  required Map<String, dynamic> labelTranslations,
  required String color,
  required String icon,
  required bool isCash,
  required int displayOrder,
}) =>
    OrgPaymentMethod(
      id: id,
      orgId: 'system',
      name: name,
      labelTranslations: labelTranslations,
      color: color,
      icon: icon,
      isCash: isCash,
      isActive: true,
      displayOrder: displayOrder,
      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
    );
