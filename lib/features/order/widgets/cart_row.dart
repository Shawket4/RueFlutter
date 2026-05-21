import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/cart_notifier.dart';
import '../../../core/providers/menu_notifier.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import 'bundle_cart_row.dart';
import 'item_detail_sheet.dart';
import 'shared_widgets.dart';

class CartRow extends ConsumerWidget {
  final int index;
  const CartRow({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final item = cart.items[index];
    if (item.isBundleLine) {
      return BundleCartRow(index: index, item: item);
    }
    final menu = ref.watch(menuProvider);

    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: AppColors.border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: Text(
                  item.itemName +
                      (item.sizeLabel != null
                          ? ' · ${normaliseName(item.sizeLabel!)}'
                          : ''),
                  style: cairo(
                      fontSize: 13, fontWeight: FontWeight.w600, height: 1.3))),
          const SizedBox(width: 8),
          Text(egp(item.lineTotal),
              style: cairo(fontSize: 13, fontWeight: FontWeight.w700)),
        ]),
        if (item.addons.isNotEmpty) ...[
          const SizedBox(height: 5),
          Wrap(
              spacing: 4,
              runSpacing: 4,
              children: item.addons
                  .map((a) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(AppRadius.xs)),
                        child: Text(
                            a.priceModifier > 0
                                ? '${normaliseName(a.name)}${a.quantity > 1 ? " ×${a.quantity}" : ""} +${egp(a.priceModifier * a.quantity)}'
                                : '${normaliseName(a.name)}${a.quantity > 1 ? " ×${a.quantity}" : ""}',
                            style: cairo(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary)),
                      ))
                  .toList()),
        ],
        if (item.optionals.isNotEmpty) ...[
          const SizedBox(height: 4),
          Wrap(
              spacing: 4,
              runSpacing: 4,
              children: item.optionals
                  .map((o) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                            color: AppColors.warning.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(AppRadius.xs)),
                        child: Text(
                            o.price > 0
                                ? '${o.name} +${egp(o.price)}'
                                : o.name,
                            style: cairo(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.warning)),
                      ))
                  .toList()),
        ],
        const SizedBox(height: 8),
        Row(children: [
          InlineBtn(
              icon: Icons.remove,
              onTap: () {
                HapticFeedback.lightImpact();
                if (item.quantity == 1) {
                  _confirmRemove(context, ref, item.itemName, () {
                    ref.read(cartProvider.notifier).setQty(index, 0);
                    _showSnackbar(context, ref, item.itemName);
                  });
                } else {
                  ref.read(cartProvider.notifier).setQty(index, item.quantity - 1);
                }
              }),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('${item.quantity}',
                  style: cairo(fontSize: 14, fontWeight: FontWeight.w700))),
          InlineBtn(
              icon: Icons.add,
              onTap: () {
                HapticFeedback.lightImpact();
                ref.read(cartProvider.notifier).setQty(index, item.quantity + 1);
              }),
          const Spacer(),

          GestureDetector(
            onTap: () {
              final menuItemId = item.menuItemId;
              if (menuItemId == null) return;
              final menuItem =
                  menu.items.where((m) => m.id == menuItemId);
              if (menuItem.isEmpty) return;
              ItemDetailSheet.show(
                context,
                menuItem.first,
                editIndex: index,
                existingItem: item,
              );
            },
            child: Container(
                width: 28,
                height: 28,
                margin: const EdgeInsets.only(right: 6),
                decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(AppRadius.xs)),
                alignment: Alignment.center,
                child: const Icon(Icons.edit_outlined,
                    size: 13, color: AppColors.primary)),
          ),

          GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              _confirmRemove(context, ref, item.itemName, () {
                ref.read(cartProvider.notifier).removeAt(index);
                _showSnackbar(context, ref, item.itemName);
              });
            },
            child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                    color: AppColors.danger.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(AppRadius.xs)),
                alignment: Alignment.center,
                child: const Icon(Icons.delete_outline_rounded,
                    size: 14, color: AppColors.danger)),
          ),
        ]),
      ]),
    );
  }

  void _confirmRemove(BuildContext context, WidgetRef ref, String itemName, VoidCallback onRemove) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.sm)),
        title: Text('Remove Item?', style: cairo(fontWeight: FontWeight.w700)),
        content: Text('Are you sure you want to remove "$itemName" from the cart?', style: cairo(fontSize: 13, color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: cairo(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              onRemove();
            },
            child: Text('Remove', style: cairo(color: AppColors.danger, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(BuildContext context, WidgetRef ref, String itemName) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$itemName removed',
            style: cairo(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 8,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.border),
        ),
        action: SnackBarAction(
          label: 'Undo',
          textColor: AppColors.primary,
          onPressed: () => ref.read(cartProvider.notifier).restoreLastRemoved(),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
