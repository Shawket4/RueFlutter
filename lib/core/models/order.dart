// Façade over the OpenAPI-generated wire models (packages/sufrix_api).
// The app's `Order` is the spec's `OrderFull` (order + embedded items) and
// `OrderItem` is `OrderItemFull` (item + addons/optionals/bundle components).
// The spec's bare `Order`/`OrderItem` (itemless) are intentionally NOT
// exported — everything the POS touches carries its line items.
import 'package:sufrix_api/sufrix_api.dart';

export 'package:sufrix_api/sufrix_api.dart'
    show
        OrderFull,
        $OrderFullCopyWith,
        OrderItemFull,
        OrderItemAddon,
        OrderItemOptional,
        OrderBundleComponentFull,
        OrderBundleComponentAddon,
        OrderBundleComponentOptional;

typedef Order = OrderFull;
typedef OrderItem = OrderItemFull;

extension OrderX on OrderFull {
  bool get isVoided => status == 'voided';
}

extension OrderItemX on OrderItemFull {
  bool get isBundleLine => bundleId != null;

  /// Client-side parse of the `deductions_snapshot` JSON blob.
  List<InventoryDeduction> get deductions {
    final snapshot = deductionsSnapshot;
    if (snapshot is! List) return const [];
    return snapshot
        .whereType<Map>()
        .map((d) => InventoryDeduction.fromJson(Map<String, dynamic>.from(d)))
        .toList();
  }
}

// Legacy field aliases so receipt/printing consumers keep reading bundle
// component addons/optionals the way cart snapshots named them.
extension OrderBundleComponentAddonX on OrderBundleComponentAddon {
  String get name => addonName;
  int get priceModifier => unitPrice;
}

extension OrderBundleComponentOptionalX on OrderBundleComponentOptional {
  String get name => fieldName;
}

/// One row of an order item's `deductions_snapshot` blob. This is a
/// client-side parse of an opaque JSON column — not a wire schema — so it
/// stays hand-written.
class InventoryDeduction {
  final String? orgIngredientId;
  final String ingredientName;
  final String unit;
  final double quantity;
  final String source;
  final String category;

  const InventoryDeduction({
    this.orgIngredientId,
    required this.ingredientName,
    required this.unit,
    required this.quantity,
    required this.source,
    required this.category,
  });

  factory InventoryDeduction.fromJson(Map<String, dynamic> j) =>
      InventoryDeduction(
        orgIngredientId: j['org_ingredient_id'] as String?,
        ingredientName: j['ingredient_name'] as String? ?? '',
        unit: j['unit'] as String? ?? '',
        quantity: (j['quantity'] is String)
            ? (double.tryParse(j['quantity'] as String) ?? 0.0)
            : ((j['quantity'] as num?)?.toDouble() ?? 0.0),
        source: j['source'] as String? ?? '',
        category: j['category'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        if (orgIngredientId != null) 'org_ingredient_id': orgIngredientId,
        'ingredient_name': ingredientName,
        'unit': unit,
        'quantity': quantity,
        'source': source,
        'category': category,
      };
}
