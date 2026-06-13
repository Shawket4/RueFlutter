// Façade over the OpenAPI-generated wire models (packages/sufrix_api).
// The app's `MenuItem` is the spec's `MenuItemFull` (sizes / addon slots /
// optional fields / recipes embedded), which is what the POS always fetches
// (`/menu-items?full=true` and `/menu-items/{id}`).
import 'package:sufrix_api/sufrix_api.dart';

export 'package:sufrix_api/sufrix_api.dart'
    show
        Category,
        MenuItemFull,
        ItemSize,
        MenuItemRecipe,
        AddonItem,
        $AddonItemCopyWith,
        AddonItemIngredient,
        AddonSlot,
        OptionalField;

typedef MenuItem = MenuItemFull;

extension MenuItemX on MenuItemFull {
  int priceForSize(String? label) {
    if (label == null || sizes.isEmpty) return basePrice;
    for (final s in sizes) {
      if (s.label == label) return s.priceOverride;
    }
    return basePrice;
  }

  /// True if this item has enough embedded recipe data to compute offline.
  bool get hasLocalRecipes => recipes.isNotEmpty;

  /// Localized display name. Falls back to English, then wire `name`.
  String localizedName(String locale) =>
      _localizedStr(nameTranslations, locale, name);
}

extension CategoryX on Category {
  /// Localized display name. Falls back to English, then wire `name`.
  String localizedName(String locale) =>
      _localizedStr(nameTranslations, locale, name);
}

extension AddonItemX on AddonItem {
  /// Localized display name. Falls back to English, then wire `name`.
  String localizedName(String locale) =>
      _localizedStr(nameTranslations, locale, name);
}

extension ItemSizeX on ItemSize {
  /// Legacy app-side alias for the wire `price_override`.
  int get price => priceOverride;
}

extension AddonSlotX on AddonSlot {
  String get displayName {
    if (label != null && label!.isNotEmpty) return label!;
    return addonType
        .replaceAll('_', ' ')
        .split(' ')
        .map((w) => w.isEmpty ? '' : w[0].toUpperCase() + w.substring(1))
        .join(' ');
  }
}

extension OptionalFieldX on OptionalField {
  bool get hasIngredient => ingredientName != null;
  bool get isFree => price == 0;
}

/// Picks the best translation from a wire `*_translations` field.
/// Falls back: requested locale → English → [fallback].
String _localizedStr(Object translations, String locale, String fallback) {
  if (translations is Map) {
    final lang = locale.length >= 2 ? locale.substring(0, 2) : locale;
    final v = translations[lang];
    if (v is String && v.isNotEmpty) return v;
    final en = translations['en'];
    if (en is String && en.isNotEmpty) return en;
  }
  return fallback;
}
