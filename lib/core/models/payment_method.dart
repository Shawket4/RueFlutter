import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PaymentMethod {
  final String id;
  final String orgId;
  final String wireFormat; // Maps to `name` in the backend
  final Map<String, dynamic> labelTranslations;
  final String _colorHex;
  final String _iconName;
  final bool isCash;
  final bool isActive;
  final int displayOrder;

  const PaymentMethod({
    required this.id,
    required this.orgId,
    required this.wireFormat,
    required this.labelTranslations,
    required String colorHex,
    required String iconName,
    required this.isCash,
    required this.isActive,
    required this.displayOrder,
  })  : _colorHex = colorHex,
        _iconName = iconName;

  /// Gets the localized label, falling back to English or the raw name.
  String label(String locale) {
    final lang = locale.substring(0, 2);
    if (labelTranslations.containsKey(lang)) {
      return labelTranslations[lang];
    }
    if (labelTranslations.containsKey('en')) {
      return labelTranslations['en'];
    }
    return wireFormat;
  }

  Color get color {
    if (_colorHex.isEmpty) return AppColors.primary;
    try {
      final hex = _colorHex.replaceAll('#', '');
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

  IconData get icon {
    switch (_iconName) {
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
      case 'account_balance_wallet_rounded': return Icons.account_balance_wallet_rounded;
      case 'delivery_dining_rounded': return Icons.delivery_dining_rounded;
      case 'pie_chart_rounded': return Icons.pie_chart_rounded;
      default: return Icons.payments_outlined;
    }
  }

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'] ?? '',
      orgId: json['org_id'] ?? '',
      wireFormat: json['name'] ?? '',
      labelTranslations: json['label_translations'] as Map<String, dynamic>? ?? {},
      colorHex: json['color'] ?? '',
      iconName: json['icon'] ?? '',
      isCash: json['is_cash'] ?? false,
      isActive: json['is_active'] ?? true,
      displayOrder: json['display_order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'name': wireFormat,
      'label_translations': labelTranslations,
      'color': _colorHex,
      'icon': _iconName,
      'is_cash': isCash,
      'is_active': isActive,
      'display_order': displayOrder,
    };
  }

  // Fallback for split payments UI
  static PaymentMethod mixed() {
    return const PaymentMethod(
      id: 'mixed',
      orgId: 'system',
      wireFormat: 'mixed',
      labelTranslations: {'en': 'Mixed', 'ar': 'متعدد'},
      colorHex: '#3B82F6', // AppColors.primary roughly
      iconName: 'pie_chart',
      isCash: false,
      isActive: true,
      displayOrder: 999,
    );
  }
}
