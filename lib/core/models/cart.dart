import 'package:flutter/foundation.dart';

// ── SelectedOptional ──────────────────────────────────────────
@immutable
class SelectedOptional {
  final String optionalFieldId;
  final String name;
  final int    price;

  const SelectedOptional({
    required this.optionalFieldId,
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toApiJson() => {
    'optional_field_id': optionalFieldId,
  };

  Map<String, dynamic> toStorageJson() => {
    'optional_field_id': optionalFieldId,
    'name':              name,
    'price':             price,
  };

  factory SelectedOptional.fromStorageJson(Map<String, dynamic> j) =>
      SelectedOptional(
        optionalFieldId: j['optional_field_id'] as String,
        name:            (j['name']             as String?) ?? '',
        price:           (j['price']            as int?)    ?? 0,
      );
}

// ── SelectedAddon ─────────────────────────────────────────────
@immutable
class SelectedAddon {
  final String addonItemId;
  final String name;
  final int    priceModifier;
  final int    quantity;

  const SelectedAddon({
    required this.addonItemId,
    required this.name,
    required this.priceModifier,
    this.quantity = 1,
  });

  SelectedAddon copyWith({int? quantity}) => SelectedAddon(
    addonItemId:   addonItemId,
    name:          name,
    priceModifier: priceModifier,
    quantity:      quantity ?? this.quantity,
  );

  Map<String, dynamic> toApiJson() => {
    'addon_item_id': addonItemId,
    'quantity':      quantity,
  };

  Map<String, dynamic> toStorageJson() => {
    ...toApiJson(),
    'name':           name,
    'price_modifier': priceModifier,
  };

  factory SelectedAddon.fromStorageJson(Map<String, dynamic> j) => SelectedAddon(
    addonItemId:   j['addon_item_id']   as String,
    name:          (j['name']           as String?) ?? '',
    priceModifier: (j['price_modifier'] as int?)    ?? 0,
    quantity:      (j['quantity']       as int?)    ?? 1,
  );
}

// ── BundleComponentSnapshot (order-time) ──────────────────────

class BundleComponentSnapshot {
  final String itemId;
  final String itemName;
  final int quantity;
  final String? sizeLabel;
  final List<SelectedAddon> addons;
  final List<SelectedOptional> optionals;

  const BundleComponentSnapshot({
    required this.itemId,
    required this.itemName,
    required this.quantity,
    this.sizeLabel,
    this.addons = const [],
    this.optionals = const [],
  });

  int get addonsPrice =>
      addons.fold(0, (s, a) => s + a.priceModifier * a.quantity);

  int get optionalsPrice => optionals.fold(0, (s, o) => s + o.price);

  Map<String, dynamic> toApiJson() => {
        'item_id': itemId,
        'quantity': quantity,
        if (sizeLabel != null) 'size_label': sizeLabel,
        'addons': addons.map((a) => a.toApiJson()).toList(),
        'optional_field_ids':
            optionals.map((o) => o.optionalFieldId).toList(),
      };

  Map<String, dynamic> toStorageJson() => {
        'item_id': itemId,
        'quantity': quantity,
        if (sizeLabel != null) 'size_label': sizeLabel,
        'item_name': itemName,
        'addons': addons.map((a) => a.toStorageJson()).toList(),
        'optionals': optionals.map((o) => o.toStorageJson()).toList(),
      };

  factory BundleComponentSnapshot.fromJson(Map<String, dynamic> j) =>
      BundleComponentSnapshot(
        itemId: j['item_id'] as String,
        itemName: (j['item_name'] as String?) ?? '',
        quantity: (j['quantity'] as int?) ?? 1,
        sizeLabel: j['size_label'] as String?,
        addons: (j['addons'] as List? ?? [])
            .map((a) => _addonFromOrderJson(a as Map<String, dynamic>))
            .toList(),
        optionals: (j['optionals'] as List? ?? [])
            .map((o) => _optionalFromOrderJson(o as Map<String, dynamic>))
            .toList(),
      );

  factory BundleComponentSnapshot.fromStorageJson(Map<String, dynamic> j) =>
      BundleComponentSnapshot(
        itemId: j['item_id'] as String,
        itemName: (j['item_name'] as String?) ?? '',
        quantity: (j['quantity'] as int?) ?? 1,
        sizeLabel: j['size_label'] as String?,
        addons: (j['addons'] as List? ?? [])
            .map((a) => SelectedAddon.fromStorageJson(a as Map<String, dynamic>))
            .toList(),
        optionals: (j['optionals'] as List? ?? [])
            .map((o) =>
                SelectedOptional.fromStorageJson(o as Map<String, dynamic>))
            .toList(),
      );
}

SelectedAddon _addonFromOrderJson(Map<String, dynamic> j) => SelectedAddon(
      addonItemId: (j['addon_item_id'] as String?) ?? '',
      name: (j['addon_name'] as String?) ?? '',
      priceModifier: (j['unit_price'] as int?) ?? 0,
      quantity: (j['quantity'] as int?) ?? 1,
    );

SelectedOptional _optionalFromOrderJson(Map<String, dynamic> j) =>
    SelectedOptional(
      optionalFieldId: (j['optional_field_id'] as String?) ?? '',
      name: (j['field_name'] as String?) ?? '',
      price: (j['price'] as int?) ?? 0,
    );

/// Configuration from [ItemDetailSheet] for one bundle component drink/item.
class ItemLineConfiguration {
  final String? sizeLabel;
  final List<SelectedAddon> addons;
  final List<SelectedOptional> optionals;

  const ItemLineConfiguration({
    this.sizeLabel,
    this.addons = const [],
    this.optionals = const [],
  });
}

// ── CartItem ──────────────────────────────────────────────────
@immutable
class CartItem {
  final String?             menuItemId;
  final String?             bundleId;
  final List<BundleComponentSnapshot>? bundleComponents;
  final String              itemName;
  final String?             sizeLabel;
  final int                 unitPrice;
  final int                 quantity;
  final List<SelectedAddon>    addons;
  final List<SelectedOptional> optionals;
  final String?             notes;

  const CartItem({
    this.menuItemId,
    this.bundleId,
    this.bundleComponents,
    required this.itemName,
    this.sizeLabel,
    required this.unitPrice,
    this.quantity  = 1,
    this.addons    = const [],
    this.optionals = const [],
    this.notes,
  }) : assert(menuItemId != null || bundleId != null);

  bool get isBundleLine => bundleId != null;

  CartItem copyWith({
    int?                    quantity,
    List<SelectedAddon>?    addons,
    List<SelectedOptional>? optionals,
    String?                 notes,
  }) => CartItem(
    menuItemId:        menuItemId,
    bundleId:          bundleId,
    bundleComponents:  bundleComponents,
    itemName:          itemName,
    sizeLabel:         sizeLabel,
    unitPrice:         unitPrice,
    notes:             notes     ?? this.notes,
    quantity:          quantity  ?? this.quantity,
    addons:            addons    ?? this.addons,
    optionals:         optionals ?? this.optionals,
  );

  int get addonsPrice    => addons.fold(0, (s, a) => s + a.priceModifier * a.quantity);
  int get optionalsPrice => optionals.fold(0, (s, o) => s + o.price);
  int get lineTotal {
    if (!isBundleLine) {
      return (unitPrice + addonsPrice + optionalsPrice) * quantity;
    }
    final componentExtras = bundleComponents?.fold<int>(
          0,
          (s, c) => s + c.addonsPrice + c.optionalsPrice,
        ) ??
        0;
    return (unitPrice + componentExtras) * quantity;
  }

  Map<String, dynamic> toApiJson() {
    if (isBundleLine) {
      return {
        'bundle_id':          bundleId,
        'bundle_unit_price':  unitPrice,
        'quantity':           quantity,
        'addons':             const [],           // required by backend serde
        'optional_field_ids': const [],           // required by backend serde
        'bundle_components':  bundleComponents!
            .map((c) => c.toApiJson())
            .toList(),
        if (notes != null) 'notes': notes,
      };
    }
    return {
      'menu_item_id':       menuItemId,
      'size_label':         sizeLabel,
      'quantity':           quantity,
      'addons':             addons.map((a) => a.toApiJson()).toList(),
      'optional_field_ids': optionals.map((o) => o.optionalFieldId).toList(),
      if (notes != null) 'notes': notes,
    };
  }

  Map<String, dynamic> toStorageJson() => {
        'menu_item_id': menuItemId,
        'bundle_id': bundleId,
        'size_label': sizeLabel,
        'quantity': quantity,
        if (notes != null) 'notes': notes,
        'item_name':  itemName,
        'unit_price': unitPrice,
        'addons':     addons.map((a) => a.toStorageJson()).toList(),
        'optionals':  optionals.map((o) => o.toStorageJson()).toList(),
        if (bundleComponents != null)
          'bundle_components': bundleComponents!
              .map((c) => c.toStorageJson())
              .toList(),
      };

  factory CartItem.fromStorageJson(Map<String, dynamic> j) {
    final bundleId = j['bundle_id'] as String?;
    final comps = bundleId != null
        ? (j['bundle_components'] as List? ?? [])
            .map((c) => BundleComponentSnapshot.fromStorageJson(
                c as Map<String, dynamic>))
            .toList()
        : null;

    return CartItem(
      menuItemId: j['menu_item_id'] as String?,
      bundleId: bundleId,
      bundleComponents: comps,
      itemName: (j['item_name'] as String?) ?? '',
      sizeLabel: j['size_label'] as String?,
      unitPrice: (j['unit_price'] as int?) ?? 0,
      quantity: (j['quantity'] as int?) ?? 1,
      notes: j['notes'] as String?,
      addons: (j['addons'] as List? ?? [])
          .map((a) => SelectedAddon.fromStorageJson(a as Map<String, dynamic>))
          .toList(),
      optionals: (j['optionals'] as List? ?? [])
          .map((o) => SelectedOptional.fromStorageJson(o as Map<String, dynamic>))
          .toList(),
    );
  }

  static bool addonsMatch(List<SelectedAddon> a, List<SelectedAddon> b) {
    if (a.length != b.length) return false;
    final aIds = a.map((x) => x.addonItemId).toSet();
    final bIds = b.map((x) => x.addonItemId).toSet();
    return aIds.containsAll(bIds) && bIds.containsAll(aIds);
  }

  static bool optionalsMatch(List<SelectedOptional> a, List<SelectedOptional> b) {
    if (a.length != b.length) return false;
    final aIds = a.map((x) => x.optionalFieldId).toSet();
    final bIds = b.map((x) => x.optionalFieldId).toSet();
    return aIds.containsAll(bIds) && bIds.containsAll(aIds);
  }
}

// ── DiscountType ──────────────────────────────────────────────
enum DiscountType { percentage, fixed }

extension DiscountTypeX on DiscountType {
  String get apiValue => name;
}

// ── PaymentSplit ──────────────────────────────────────────────
@immutable
class PaymentSplit {
  final String method;
  final int    amount;

  const PaymentSplit({required this.method, required this.amount});

  Map<String, dynamic> toApiJson() => {'method': method, 'amount': amount};

  PaymentSplit copyWith({String? method, int? amount}) =>
      PaymentSplit(method: method ?? this.method, amount: amount ?? this.amount);
}

// ── CartState ─────────────────────────────────────────────────
@immutable
class CartState {
  final String?             id;
  final String?             displayName;
  final DateTime?           createdAt;
  final List<CartItem>      items;
  final String              payment;
  final String?             customerName;
  final String?             notes;
  final DiscountType?       discountType;
  final int?                discountValue;
  final String?             discountId;
  final int?                amountTendered;
  final int?                tipAmount;
  final List<PaymentSplit>? paymentSplits;

  const CartState({
    this.id,
    this.displayName,
    this.createdAt,
    this.items          = const [],
    this.payment        = 'cash',
    this.customerName,
    this.notes,
    this.discountType,
    this.discountValue,
    this.discountId,
    this.amountTendered,
    this.tipAmount,
    this.paymentSplits,
  });

  bool get isEmpty  => items.isEmpty;
  int  get count    => items.fold(0, (s, i) => s + i.quantity);
  int  get subtotal => items.fold(0, (s, i) => s + i.lineTotal);

  int get discountAmount {
    if (discountType == null || (discountValue ?? 0) == 0) return 0;
    if (discountType == DiscountType.percentage) {
      return (subtotal * discountValue! / 100).round();
    }
    return discountValue!.clamp(0, subtotal);
  }

  int get total => subtotal - discountAmount;

  int get changeGiven {
    if (amountTendered == null) return 0;
    return (amountTendered! - total).clamp(0, 999999);
  }

  bool get isSplitPayment =>
      paymentSplits != null && paymentSplits!.isNotEmpty;

  CartState copyWith({
    String?              id,
    String?              displayName,
    DateTime?            createdAt,
    List<CartItem>?      items,
    String?              payment,
    String?              customerName,
    String?              notes,
    DiscountType?        discountType,
    int?                 discountValue,
    String?              discountId,
    int?                 amountTendered,
    int?                 tipAmount,
    List<PaymentSplit>?  paymentSplits,
    bool clearDiscount   = false,
    bool clearCustomer   = false,
    bool clearTendered   = false,
    bool clearSplits     = false,
    bool clearDiscountId = false,
  }) => CartState(
    id:             id             ?? this.id,
    displayName:    displayName    ?? this.displayName,
    createdAt:      createdAt      ?? this.createdAt,
    items:          items          ?? this.items,
    payment:        payment        ?? this.payment,
    customerName:   clearCustomer   ? null : (customerName  ?? this.customerName),
    notes:          notes           ?? this.notes,
    discountType:   clearDiscount   ? null : (discountType  ?? this.discountType),
    discountValue:  clearDiscount   ? null : (discountValue ?? this.discountValue),
    discountId:     clearDiscountId ? null : (discountId    ?? this.discountId),
    amountTendered: clearTendered   ? null : (amountTendered ?? this.amountTendered),
    tipAmount:      tipAmount       ?? this.tipAmount,
    paymentSplits:  clearSplits     ? null : (paymentSplits ?? this.paymentSplits),
  );

  Map<String, dynamic> toStorageJson() => {
        'id': id,
        'display_name': displayName,
        'created_at': createdAt?.toIso8601String(),
        'items': items.map((i) => i.toStorageJson()).toList(),
        'payment': payment,
        'customer_name': customerName,
        'notes': notes,
        'discount_type': discountType?.name,
        'discount_value': discountValue,
        'discount_id': discountId,
        'amount_tendered': amountTendered,
        'tip_amount': tipAmount,
        'payment_splits': paymentSplits?.map((s) => s.toApiJson()).toList(),
      };

  factory CartState.fromStorageJson(Map<String, dynamic> j) => CartState(
        id: j['id'] as String?,
        displayName: j['display_name'] as String?,
        createdAt: j['created_at'] != null ? DateTime.tryParse(j['created_at'] as String) : null,
        items: (j['items'] as List? ?? [])
            .map((i) => CartItem.fromStorageJson(i as Map<String, dynamic>))
            .toList(),
        payment: j['payment'] as String? ?? 'cash',
        customerName: j['customer_name'] as String?,
        notes: j['notes'] as String?,
        discountType: j['discount_type'] != null
            ? DiscountType.values
                .firstWhere((e) => e.name == j['discount_type'])
            : null,
        discountValue: j['discount_value'] as int?,
        discountId: j['discount_id'] as String?,
        amountTendered: j['amount_tendered'] as int?,
        tipAmount: j['tip_amount'] as int?,
        paymentSplits: (j['payment_splits'] as List? ?? [])
            .map((s) => PaymentSplit(
                  method: s['method'] as String,
                  amount: (s['amount'] as num).toInt(),
                ))
            .toList(),
      );

  static const empty = CartState();
}
