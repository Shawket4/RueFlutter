import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/features/order/helpers/category_style.dart';

void main() {
  group('CatStyle icon mapping', () {
    final cases = <String, IconData>{
      'Matcha Latte': Icons.eco_rounded,
      // 'iced' and 'latte' both match; the coffee family wins (chain order).
      'Iced Latte': Icons.coffee_rounded,
      'Espresso': Icons.coffee_rounded,
      'Hot Chocolate': Icons.coffee_rounded,
      'Croissant': Icons.bakery_dining_rounded,
      'Chicken Sandwich': Icons.lunch_dining_rounded,
      'Ice Cream': Icons.icecream_rounded,
      'Lemonade': Icons.local_drink_rounded,
      'Green Tea': Icons.emoji_food_beverage_rounded,
      'Sparkling Water': Icons.water_drop_rounded,
      'Iced Something': Icons.ac_unit_rounded,
      'Unknown Item': Icons.local_cafe_rounded,
    };

    cases.forEach((name, icon) {
      test('"$name" → $icon', () {
        expect(CatStyle.of(name).icon, icon);
        // Dark variant keeps the same icon.
        expect(CatStyle.of(name, brightness: Brightness.dark).icon, icon);
      });
    });
  });

  group('CatStyle brightness variants', () {
    test('light backgrounds are light, dark backgrounds are dark', () {
      for (final name in ['Espresso', 'Matcha', 'Lemonade', 'Unknown']) {
        final light = CatStyle.of(name);
        final dark = CatStyle.of(name, brightness: Brightness.dark);
        expect(light.bgTop.computeLuminance(), greaterThan(0.5),
            reason: '$name light bgTop should be light');
        expect(dark.bgTop.computeLuminance(), lessThan(0.2),
            reason: '$name dark bgTop should be dark');
        // Icon colour must contrast against its own background.
        expect(light.iconColor.computeLuminance(),
            lessThan(light.bgTop.computeLuminance()));
        expect(dark.iconColor.computeLuminance(),
            greaterThan(dark.bgTop.computeLuminance()));
      }
    });

    test('distinct categories get distinct accents', () {
      final a = CatStyle.of('Matcha').accent;
      final b = CatStyle.of('Espresso').accent;
      final c = CatStyle.of('Sparkling Water').accent;
      expect(a, isNot(b));
      expect(b, isNot(c));
    });
  });
}
