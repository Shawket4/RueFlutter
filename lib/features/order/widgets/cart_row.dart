import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/cart_notifier.dart';
import '../../../core/providers/menu_notifier.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import 'bundle_cart_row.dart';
import 'item_detail_sheet.dart';

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
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderLight)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // ── Name + total ───────────────────────────────────────────────
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

        // ── Addons ─────────────────────────────────────────────────────
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
                            color: AppColors.primary.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(4)),
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

        // ── Optionals ──────────────────────────────────────────────────
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
                            color: AppColors.warning.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(4)),
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

        // ── Actions row ────────────────────────────────────────────────
        Row(children: [
          _QtyControl(
            icon: Icons.remove,
            onTap: () {
              HapticFeedback.lightImpact();
              if (item.quantity == 1) {
                _confirmRemove(context, ref, item.itemName, () {
                  ref.read(cartProvider.notifier).setQty(index, 0);
                  _showSnackbar(context, ref, item.itemName);
                });
              } else {
                ref
                    .read(cartProvider.notifier)
                    .setQty(index, item.quantity - 1);
              }
            },
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: 24,
                child: Text('${item.quantity}',
                    textAlign: TextAlign.center,
                    style: cairo(fontSize: 14, fontWeight: FontWeight.w700)),
              )),
          _QtyControl(
            icon: Icons.add,
            onTap: () {
              HapticFeedback.lightImpact();
              ref
                  .read(cartProvider.notifier)
                  .setQty(index, item.quantity + 1);
            },
          ),
          const Spacer(),

          // Edit
          _ActionIcon(
            icon: Icons.edit_outlined,
            color: AppColors.primary,
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
          ),
          const SizedBox(width: 6),

          // Delete
          _ActionIcon(
            icon: Icons.close_rounded,
            color: AppColors.danger,
            onTap: () {
              HapticFeedback.mediumImpact();
              _confirmRemove(context, ref, item.itemName, () {
                ref.read(cartProvider.notifier).removeAt(index);
                _showSnackbar(context, ref, item.itemName);
              });
            },
          ),
        ]),
      ]),
    );
  }

  void _confirmRemove(
      BuildContext context, WidgetRef ref, String itemName, VoidCallback onRemove) {
    showDialog(
      context: context,
      builder: (ctx) => _ConfirmDialog(
        title: 'Remove Item?',
        message: 'Remove "$itemName" from the cart?',
        confirmLabel: 'Remove',
        onConfirm: () {
          Navigator.pop(ctx);
          onRemove();
        },
        onCancel: () => Navigator.pop(ctx),
      ),
    );
  }

  void _showSnackbar(BuildContext context, WidgetRef ref, String itemName) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$itemName removed',
            style: cairo(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xs),
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

// ── Small controls ──────────────────────────────────────────────────────────

class _QtyControl extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyControl({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onTap,
      child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.border)),
          alignment: Alignment.center,
          child: Icon(icon, size: 14, color: AppColors.textPrimary)));
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _ActionIcon(
      {required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onTap,
      child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
              color: color.withOpacity(0.06),
              borderRadius: BorderRadius.circular(6)),
          alignment: Alignment.center,
          child: Icon(icon, size: 14, color: color)));
}

// ── Confirm Dialog (replaces AlertDialog for web-style) ─────────────────────

class _ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const _ConfirmDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child:
                Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title,
                  style: cairo(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text(message,
                  style: cairo(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      height: 1.4)),
              const SizedBox(height: 24),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                AnimatedPressScale(
                  onTap: onCancel,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.xs),
                        border: Border.all(color: AppColors.border)),
                    child: Text('Cancel',
                        style: cairo(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary)),
                  ),
                ),
                const SizedBox(width: 10),
                AnimatedPressScale(
                  onTap: onConfirm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                        color: AppColors.danger,
                        borderRadius: BorderRadius.circular(AppRadius.xs)),
                    child: Text(confirmLabel,
                        style: cairo(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ),
                ),
              ]),
            ]),
          ),
        ),
      );
}
