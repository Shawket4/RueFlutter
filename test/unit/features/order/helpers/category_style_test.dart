import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/features/order/helpers/category_style.dart';

void main() {
  group('CatStyle', () {
    test('returns correct style for matcha', () {
      final style = CatStyle.of('Matcha Latte');
      expect(style.icon, Icons.eco_rounded);
      expect(style.iconColor, const Color(0xFF2E7D32));
    });

    test('returns correct style for coffee variants', () {
      final styleLatte = CatStyle.of('Iced Latte');
      // Wait, 'iced' and 'latte' both match. 'latte' comes first in the if-else chain.
      expect(styleLatte.icon, Icons.coffee_rounded);
      expect(styleLatte.iconColor, const Color(0xFF5D4037));

      final styleEspresso = CatStyle.of('Espresso');
      expect(styleEspresso.icon, Icons.coffee_rounded);
    });

    test('returns correct style for chocolate', () {
      final style = CatStyle.of('Hot Chocolate');
      expect(style.icon, Icons.coffee_rounded);
      expect(style.iconColor, const Color(0xFF6D4C41));
    });

    test('returns correct style for bakery', () {
      final style = CatStyle.of('Croissant');
      expect(style.icon, Icons.bakery_dining_rounded);
      expect(style.iconColor, const Color(0xFFE65100));
    });

    test('returns correct style for sandwich', () {
      final style = CatStyle.of('Chicken Sandwich');
      expect(style.icon, Icons.lunch_dining_rounded);
      expect(style.iconColor, const Color(0xFFE64A19));
    });

    test('returns correct style for ice cream', () {
      final style = CatStyle.of('Ice Cream');
      expect(style.icon, Icons.icecream_rounded);
      expect(style.iconColor, const Color(0xFF7B1FA2));
    });

    test('returns correct style for juice', () {
      final style = CatStyle.of('Lemonade');
      expect(style.icon, Icons.local_drink_rounded);
      expect(style.iconColor, const Color(0xFFF57F17));
    });

    test('returns correct style for tea', () {
      final style = CatStyle.of('Green Tea');
      expect(style.icon, Icons.emoji_food_beverage_rounded);
      expect(style.iconColor, const Color(0xFF388E3C));
    });

    test('returns correct style for water', () {
      final style = CatStyle.of('Sparkling Water');
      expect(style.icon, Icons.water_drop_rounded);
      expect(style.iconColor, const Color(0xFF1565C0));
    });

    test('returns correct style for iced drinks not caught by others', () {
      final style = CatStyle.of('Iced Something');
      expect(style.icon, Icons.ac_unit_rounded);
      expect(style.iconColor, const Color(0xFF0277BD));
    });

    test('returns default style for unknown', () {
      final style = CatStyle.of('Unknown Item');
      expect(style.icon, Icons.local_cafe_rounded);
      expect(style.iconColor, const Color(0xFF795548));
    });
  });
}
