import 'order.dart';

class PendingOrder {
  final String         localId;
  final String         branchId;
  final String         shiftId;
  final String         paymentMethod;
  final String?        customerName;
  final String?        discountType;
  final int?           discountValue;
  final List<CartItem> items;
  final DateTime       createdAt;

  PendingOrder({required this.localId, required this.branchId,
      required this.shiftId, required this.paymentMethod,
      this.customerName, this.discountType, this.discountValue,
      required this.items, required this.createdAt});

  Map<String, dynamic> toJson() => {
    'local_id': localId, 'branch_id': branchId, 'shift_id': shiftId,
    'payment_method': paymentMethod, 'customer_name': customerName,
    'discount_type': discountType, 'discount_value': discountValue,
    'items': items.map((i) => i.toJson()).toList(),
    'created_at': createdAt.toIso8601String(),
  };

  factory PendingOrder.fromJson(Map<String, dynamic> j) => PendingOrder(
    localId:       j['local_id']       as String,
    branchId:      (j['branch_id']     as String?) ?? '',
    shiftId:       j['shift_id']       as String,
    paymentMethod: j['payment_method'] as String,
    customerName:  j['customer_name']  as String?,
    discountType:  j['discount_type']  as String?,
    discountValue: j['discount_value'] as int?,
    items: (j['items'] as List).map((i) {
      final m = i as Map<String, dynamic>;
      return CartItem(
        menuItemId: m['menu_item_id'] as String,
        itemName:   m['item_name']    ?? '',
        sizeLabel:  m['size_label']   as String?,
        unitPrice:  (m['unit_price']  ?? 0) as int,
        quantity:   (m['quantity']    ?? 1)  as int,
        addons: (m['addons'] as List? ?? []).map((a) {
          final am = a as Map<String, dynamic>;
          return SelectedAddon(
            addonItemId:       am['addon_item_id'],
            drinkOptionItemId: am['drink_option_item_id'] ?? '',
            name:              am['name']            ?? '',
            priceModifier:     (am['price_modifier']  ?? 0) as int,
          );
        }).toList(),
      );
    }).toList(),
    createdAt: DateTime.parse(j['created_at'] as String),
  );
}

