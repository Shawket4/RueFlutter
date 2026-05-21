import 'menu.dart';
import 'inventory.dart';

// ── BundleStatus ──────────────────────────────────────────────────────────────

enum BundleStatus {
  active,
  archived,
  draft;

  static BundleStatus fromApi(String? raw) {
    switch (raw?.toLowerCase()) {
      case 'active':
        return BundleStatus.active;
      case 'archived':
        return BundleStatus.archived;
      case 'draft':
        return BundleStatus.draft;
      default:
        return BundleStatus.archived;
    }
  }

  String get apiValue => name;
}

// ── BundleComponent ───────────────────────────────────────────────────────────

class BundleComponent {
  final String bundleId;
  final String itemId;
  final int    quantity;
  final int    position;

  const BundleComponent({
    required this.bundleId,
    required this.itemId,
    required this.quantity,
    required this.position,
  });

  factory BundleComponent.fromJson(Map<String, dynamic> j, {String? bundleId}) =>
      BundleComponent(
        bundleId: bundleId ?? j['bundle_id'] as String,
        itemId:   j['item_id']   as String,
        quantity: (j['quantity'] ?? 1) as int,
        position: (j['position'] ?? 0) as int,
      );

  Map<String, dynamic> toJson() => {
        'bundle_id': bundleId,
        'item_id':   itemId,
        'quantity':  quantity,
        'position':  position,
      };
}

// ── Bundle ────────────────────────────────────────────────────────────────────

class Bundle {
  final String       id;
  final String       orgId;
  final String       name;
  final String?      description;
  final int          price;
  final BundleStatus status;
  final String?      imageUrl;
  final int          displayOrder;
  final DateTime?    availableFromDate;
  final DateTime?    availableUntilDate;
  final int?         availableFromMinutes;
  final int?         availableUntilMinutes;
  final List<String> branchAvailability;
  final List<BundleComponent> components;
  final DateTime?    updatedAt;

  const Bundle({
    required this.id,
    required this.orgId,
    required this.name,
    this.description,
    required this.price,
    required this.status,
    this.imageUrl,
    required this.displayOrder,
    this.availableFromDate,
    this.availableUntilDate,
    this.availableFromMinutes,
    this.availableUntilMinutes,
    this.branchAvailability = const [],
    this.components = const [],
    this.updatedAt,
  });

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

  factory Bundle.fromJson(Map<String, dynamic> j) {
    final comps = (j['components'] as List? ?? [])
        .map((c) => BundleComponent.fromJson(
              c as Map<String, dynamic>,
              bundleId: j['id'] as String,
            ))
        .toList();

    final branchIds = <String>[];
    final rawBranches = j['branch_ids'] ?? j['branch_availability'];
    if (rawBranches is List) {
      for (final b in rawBranches) {
        if (b is String) {
          branchIds.add(b);
        } else if (b is Map && b['branch_id'] != null) {
          branchIds.add(b['branch_id'] as String);
        }
      }
    }

    return Bundle(
      id:           j['id'] as String,
      orgId:        j['org_id'] as String,
      name:         j['name'] as String,
      description:  j['description'] as String?,
      price:        (j['price'] ?? 0) as int,
      status:       BundleStatus.fromApi(j['status'] as String?),
      imageUrl:     j['image_url'] as String?,
      displayOrder: (j['display_order'] ?? 0) as int,
      availableFromDate:  _parseDate(j['available_from_date']),
      availableUntilDate: _parseDate(j['available_until_date']),
      availableFromMinutes:  _parseTimeMinutes(j['available_from_time']),
      availableUntilMinutes: _parseTimeMinutes(j['available_until_time']),
      branchAvailability: branchIds,
      components: comps,
      updatedAt: j['updated_at'] != null
          ? DateTime.tryParse(j['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'org_id': orgId,
        'name': name,
        'description': description,
        'price': price,
        'status': status.apiValue,
        'image_url': imageUrl,
        'display_order': displayOrder,
        'available_from_date': availableFromDate?.toIso8601String().split('T').first,
        'available_until_date': availableUntilDate?.toIso8601String().split('T').first,
        'available_from_time': availableFromMinutes,
        'available_until_time': availableUntilMinutes,
        'branch_ids': branchAvailability,
        'components': components.map((c) => c.toJson()).toList(),
        'updated_at': updatedAt?.toIso8601String(),
      };
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

  factory MenuGridEntry.item(MenuItem i) =>
      MenuGridEntry._(kind: MenuGridEntryKind.item, item: i, displayOrder: i.displayOrder);

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

DateTime? _parseDate(dynamic raw) {
  if (raw == null) return null;
  if (raw is String && raw.isNotEmpty) {
    return DateTime.tryParse(raw.split('T').first);
  }
  return null;
}

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
  final invMap = {
    for (final i in inventory)
      if (i.id.isNotEmpty) i.id: i.currentStock,
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
