// Façade over the OpenAPI-generated wire models (packages/sufrix_api).
// The app's `Bundle` is the spec's `BundleWithComponents` (the POS bundles
// endpoint always hydrates components + branch ids); `BundleComponent` is
// the spec's `BundleComponentHydrated`.
//
// The grid-entry type and the availability/stock predicates below are pure
// client logic — they stay hand-written.
import 'package:sufrix_api/sufrix_api.dart'
    show BundleWithComponents, BundleComponentHydrated, BundleStatus;

import 'inventory.dart';
import 'menu.dart';

export 'package:sufrix_api/sufrix_api.dart'
    show BundleWithComponents, BundleComponentHydrated, BundleStatus;

typedef Bundle = BundleWithComponents;
typedef BundleComponent = BundleComponentHydrated;

extension BundleX on BundleWithComponents {
  /// Legacy app-side alias for the wire `branch_ids`.
  List<String> get branchAvailability => branchIds;

  /// `available_from_time` ("HH:MM[:SS]") as minutes since midnight.
  int? get availableFromMinutes => _parseTimeMinutes(availableFromTime);

  /// `available_until_time` ("HH:MM[:SS]") as minutes since midnight.
  int? get availableUntilMinutes => _parseTimeMinutes(availableUntilTime);

  /// Category for grid placement: first component's menu item category.
  String? effectiveCategoryId(List<MenuItem> menuItems) {
    if (components.isEmpty) return null;
    final sorted = List<BundleComponent>.of(components)
      ..sort((a, b) => a.position.compareTo(b.position));
    for (final comp in sorted) {
      final item = _menuItemById(menuItems, comp.itemId);
      if (item?.categoryId != null) return item!.categoryId;
    }
    return null;
  }

  /// Sum of component base prices (for savings chip).
  int componentListPrice(List<MenuItem> menuItems) {
    var sum = 0;
    for (final comp in components) {
      final item = _menuItemById(menuItems, comp.itemId);
      if (item != null) sum += item.basePrice * comp.quantity;
    }
    return sum;
  }

  int savingsVsComponents(List<MenuItem> menuItems) {
    final list = componentListPrice(menuItems);
    return list > price ? list - price : 0;
  }

  String? previewImageUrl(List<MenuItem> menuItems) {
    if (imageUrl != null && imageUrl!.isNotEmpty) return imageUrl;
    if (components.isEmpty) return null;
    final sorted = List<BundleComponent>.of(components)
      ..sort((a, b) => a.position.compareTo(b.position));
    for (final comp in sorted) {
      final item = _menuItemById(menuItems, comp.itemId);
      if (item?.imageUrl != null && item!.imageUrl!.isNotEmpty) {
        return item.imageUrl;
      }
    }
    return null;
  }
}

// ── Menu grid entry (item or bundle) ──────────────────────────────────────────

enum MenuGridEntryKind { item, bundle }

class MenuGridEntry {
  final MenuGridEntryKind kind;
  final MenuItem? item;
  final Bundle? bundle;
  final int displayOrder;
  final bool enabled;
  final String? disabledReason;

  const MenuGridEntry._({
    required this.kind,
    this.item,
    this.bundle,
    required this.displayOrder,
    this.enabled = true,
    this.disabledReason,
  });

  factory MenuGridEntry.item(MenuItem i) => MenuGridEntry._(
      kind: MenuGridEntryKind.item, item: i, displayOrder: i.displayOrder);

  factory MenuGridEntry.bundle(
    Bundle b, {
    bool enabled = true,
    String? disabledReason,
  }) =>
      MenuGridEntry._(
        kind: MenuGridEntryKind.bundle,
        bundle: b,
        displayOrder: b.displayOrder,
        enabled: enabled,
        disabledReason: disabledReason,
      );
}

// ── Availability & stock predicates ───────────────────────────────────────────

int? _parseTimeMinutes(dynamic raw) {
  if (raw == null) return null;
  if (raw is int) return raw;
  if (raw is num) return raw.toInt();
  if (raw is String && raw.contains(':')) {
    final parts = raw.split(':');
    if (parts.length >= 2) {
      final h = int.tryParse(parts[0]) ?? 0;
      final m = int.tryParse(parts[1]) ?? 0;
      return h * 60 + m;
    }
  }
  return int.tryParse(raw.toString());
}

/// Single source of truth: should this bundle render as tappable right now?
/// An unknown status (newer backend than app) is treated as not active.
bool isBundleAvailableNow(Bundle b, String branchId, DateTime now) {
  if (b.status != BundleStatus.active) return false;

  if (b.branchAvailability.isNotEmpty &&
      !b.branchAvailability.contains(branchId)) {
    return false;
  }

  final today = DateTime(now.year, now.month, now.day);
  if (b.availableFromDate != null) {
    final from = DateTime(
      b.availableFromDate!.year,
      b.availableFromDate!.month,
      b.availableFromDate!.day,
    );
    if (today.isBefore(from)) return false;
  }
  if (b.availableUntilDate != null) {
    final until = DateTime(
      b.availableUntilDate!.year,
      b.availableUntilDate!.month,
      b.availableUntilDate!.day,
    );
    if (today.isAfter(until)) return false;
  }

  final nowMinutes = now.hour * 60 + now.minute;
  if (b.availableFromMinutes != null && nowMinutes < b.availableFromMinutes!) {
    return false;
  }
  if (b.availableUntilMinutes != null && nowMinutes > b.availableUntilMinutes!) {
    return false;
  }

  return true;
}

/// Returns null if in stock; otherwise the first out-of-stock component name.
String? bundleOutOfStockReason(
  Bundle bundle,
  List<MenuItem> menuItems,
  List<InventoryItem> inventory,
) {
  // Keyed by org ingredient — recipes reference org_ingredient_id, NOT the
  // branch-inventory row id (keying by row id silently disabled all
  // out-of-stock detection against live data).
  final invMap = {
    for (final i in inventory)
      if (i.orgIngredientId.isNotEmpty) i.orgIngredientId: i.currentStock,
  };

  for (final comp in bundle.components) {
    final item = _menuItemById(menuItems, comp.itemId);
    if (item == null) continue;

    for (final recipe in item.recipes) {
      final ingId = recipe.orgIngredientId;
      if (ingId == null || ingId.isEmpty) continue;
      final stock = invMap[ingId] ?? double.infinity;
      final needed = recipe.quantityUsed * comp.quantity;
      if (stock < needed) return item.name;
    }
  }
  return null;
}

MenuItem? _menuItemById(List<MenuItem> items, String id) {
  for (final m in items) {
    if (m.id == id) return m;
  }
  return null;
}
