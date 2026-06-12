import 'package:flutter/material.dart';

/// Maps a category/item name to a themed icon + colour palette.
///
/// Colours are derived from a per-category seed hue so light and dark themes
/// stay coherent — no hand-picked pastel table that only works on white.
class CatStyle {
  final IconData icon;
  final Color bgTop, bgBottom, iconColor, accent;
  const CatStyle({
    required this.icon,
    required this.bgTop,
    required this.bgBottom,
    required this.iconColor,
    required this.accent,
  });

  static CatStyle of(String name, {Brightness brightness = Brightness.light}) {
    final (icon, hue, sat) = _seed(name.toLowerCase());
    return _fromHue(icon, hue, sat, brightness);
  }

  /// (icon, hue°, saturation 0..1) per category family.
  static (IconData, double, double) _seed(String n) {
    if (n.contains('matcha')) return (Icons.eco_rounded, 130, .45);
    if (n.contains('latte') ||
        n.contains('espresso') ||
        n.contains('americano') ||
        n.contains('cappuc') ||
        n.contains('flat') ||
        n.contains('cortado') ||
        n.contains('coffee') ||
        n.contains('v60') ||
        n.contains('blended') ||
        n.contains('cold brew')) {
      return (Icons.coffee_rounded, 28, .38);
    }
    if (n.contains('chocolate') || n.contains('mocha')) {
      return (Icons.coffee_rounded, 8, .35);
    }
    if (n.contains('croissant') ||
        n.contains('brownie') ||
        n.contains('cookie') ||
        n.contains('pastry') ||
        n.contains('pastries') ||
        n.contains('cake') ||
        n.contains('waffle')) {
      return (Icons.bakery_dining_rounded, 40, .60);
    }
    if (n.contains('sandwich') ||
        n.contains('chicken') ||
        n.contains('turkey') ||
        n.contains('food')) {
      return (Icons.lunch_dining_rounded, 22, .62);
    }
    if (n.contains('affogato') || n.contains('ice cream')) {
      return (Icons.icecream_rounded, 285, .42);
    }
    if (n.contains('lemon') ||
        n.contains('lemonade') ||
        n.contains('refresher') ||
        n.contains('juice')) {
      return (Icons.local_drink_rounded, 52, .65);
    }
    if (n.contains('tea') || n.contains('chai')) {
      return (Icons.emoji_food_beverage_rounded, 140, .42);
    }
    if (n.contains('water') || n.contains('sparkling')) {
      return (Icons.water_drop_rounded, 210, .55);
    }
    if (n.contains('iced')) return (Icons.ac_unit_rounded, 200, .55);
    return (Icons.local_cafe_rounded, 24, .32);
  }

  static CatStyle _fromHue(
      IconData icon, double hue, double sat, Brightness brightness) {
    Color hsl(double s, double l) =>
        HSLColor.fromAHSL(1, hue, s, l).toColor();
    if (brightness == Brightness.dark) {
      return CatStyle(
        icon: icon,
        bgTop: hsl(sat * .55, .175),
        bgBottom: hsl(sat * .6, .13),
        iconColor: hsl(sat, .72),
        accent: hsl(sat, .62),
      );
    }
    return CatStyle(
      icon: icon,
      bgTop: hsl(sat, .945),
      bgBottom: hsl(sat, .875),
      iconColor: hsl(sat, .30),
      accent: hsl(sat, .40),
    );
  }
}
