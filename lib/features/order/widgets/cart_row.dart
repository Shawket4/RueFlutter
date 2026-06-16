import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/providers/cart_notifier.dart';
import '../../../core/providers/menu_notifier.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../../../core/utils/haptics.dart';
import '../../../shared/widgets/animated_icons.dart';
import '../../../shared/widgets/confirm_sheet.dart';
import 'bundle_cart_row.dart';
import 'item_detail_sheet.dart';

class CartRow extends ConsumerWidget {
  final int index;
  const CartRow({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final cart = ref.watch(cartProvider);
    // The cart's AnimatedSwitcher keeps this row mounted while the list
    // animates out after the cart shrinks or clears. During that window the
    // row rebuilds against the now-shorter list, so a stale index would throw
    // RangeError and flash a red error box. Bail out instead.
    if (index >= cart.items.length) return const SizedBox.shrink();
    final item = cart.items[index];
    if (item.isBundleLine) {
      return BundleCartRow(index: index, item: item);
    }
    final menu = ref.watch(menuProvider);

    return Container(
      padding: const EdgeInsets.all(AppSpace.md),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: t.borderLight)),
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
                  style: ui(
                      size: 13,
                      weight: FontWeight.w600,
                      color: t.textPrimary,
                      height: 1.3))),
          const SizedBox(width: 8),
          Text(egp(item.lineTotal),
              style:
                  money(size: 13, weight: FontWeight.w700, color: t.textPrimary)),
        ]),

        // ── Addons ─────────────────────────────────────────────────────
        if (item.addons.isNotEmpty) ...[
          const SizedBox(height: 5),
          Wrap(
              spacing: 4,
              runSpacing: 4,
              children: item.addons
                  .map((a) => Container(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                            color: t.navyBg,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                            a.priceModifier > 0
                                ? '${normaliseName(a.name)}${a.quantity > 1 ? " ×${a.quantity}" : ""} +${egp(a.priceModifier * a.quantity)}'
                                : '${normaliseName(a.name)}${a.quantity > 1 ? " ×${a.quantity}" : ""}',
                            style: ui(
                                size: 10,
                                weight: FontWeight.w600,
                                color: t.navy)),
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
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                            color: t.warningBg,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                            o.price > 0
                                ? '${o.name} +${egp(o.price)}'
                                : o.name,
                            style: ui(
                                size: 10,
                                weight: FontWeight.w600,
                                color: t.warning)),
                      ))
                  .toList()),
        ],

        const SizedBox(height: 8),

        // ── Actions row ────────────────────────────────────────────────
        Row(children: [
          _QtyControl(
            icon: Icons.remove,
            onTap: () {
              Haptics.selection();
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
              padding:
                  const EdgeInsetsDirectional.symmetric(horizontal: 10),
              child: SizedBox(
                width: 24,
                child: Text('${item.quantity}',
                    textAlign: TextAlign.center,
                    style: money(
                        size: 14,
                        weight: FontWeight.w700,
                        color: t.textPrimary)),
              )),
          _QtyControl(
            icon: Icons.add,
            onTap: () {
              Haptics.selection();
              ref
                  .read(cartProvider.notifier)
                  .setQty(index, item.quantity + 1);
            },
          ),
          const Spacer(),

          // Edit
          _ActionIcon(
            icon: Icons.edit_outlined,
            color: t.navy,
            background: t.navyBg,
            onTap: () {
              final menuItemId = item.menuItemId;
              if (menuItemId == null) return;
              final menuItem = menu.items.where((m) => m.id == menuItemId);
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

          // Delete — the trash lifts its lid and shakes, then (after a short
          // beat) opens the confirm sheet.
          TapToPlayIcon(
            onTapDown: Haptics.impact,
            onPressed: () => _confirmRemove(context, ref, item.itemName, () {
              ref.read(cartProvider.notifier).removeAt(index);
              _showSnackbar(context, ref, item.itemName);
            }),
            builder: (_, anim) => Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: t.dangerBg, borderRadius: BorderRadius.circular(6)),
              child: CustomPaint(
                  size: const Size(20, 20),
                  painter: TrashPainter(t: anim, color: t.danger)),
            ),
          ),
        ]),
      ]),
    );
  }

  Future<void> _confirmRemove(BuildContext context, WidgetRef ref,
      String itemName, VoidCallback onRemove) async {
    final s = l10n(context);
    final ok = await ConfirmSheet.show(
      context,
      title: s.orderRemoveItemTitle,
      body: s.orderRemoveItemBody(itemName),
      confirmLabel: s.commonRemove,
      destructive: true,
    );
    if (ok) onRemove();
  }

  void _showSnackbar(BuildContext context, WidgetRef ref, String itemName) {
    if (!context.mounted) return;
    // Capture the notifier NOW, while this row's ref is still valid. The
    // SnackBar outlives the row (deleting the item disposes it — and the whole
    // list when it was the last item), so a late ref.read() on the disposed
    // row would throw and the Undo would silently do nothing.
    final cart = ref.read(cartProvider.notifier);
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        content: Text(l10n(context).orderItemRemoved(itemName)),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: l10n(context).commonUndo,
          onPressed: cart.restoreLastRemoved,
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
  Widget build(BuildContext context) {
    final t = context.tokens;
    return AnimatedPressScale(
        onTap: onTap,
        haptic: false,
        child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
                color: t.surface,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: t.border)),
            alignment: Alignment.center,
            child: Icon(icon, size: 14, color: t.textPrimary)));
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color background;
  final VoidCallback onTap;
  const _ActionIcon(
      {required this.icon,
      required this.color,
      required this.background,
      required this.onTap});

  @override
  Widget build(BuildContext context) => AnimatedPressScale(
      onTap: onTap,
      child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
              color: background, borderRadius: BorderRadius.circular(6)),
          alignment: Alignment.center,
          child: Icon(icon, size: 14, color: color)));
}
