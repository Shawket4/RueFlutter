import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/cart.dart';
import '../../../core/providers/cart_notifier.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import 'shared_widgets.dart';

class BundleCartRow extends ConsumerWidget {
  final int index;
  final CartItem item;

  const BundleCartRow({super.key, required this.index, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comps = item.bundleComponents ?? const [];

    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: AppColors.primary.withOpacity(0.18)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.layers_outlined, size: 14, color: AppColors.primary),
          const SizedBox(width: 6),
          Expanded(
              child: Text(
                  item.quantity > 1
                      ? '${normaliseName(item.itemName)} × ${item.quantity}'
                      : normaliseName(item.itemName),
                  style: cairo(
                      fontSize: 13, fontWeight: FontWeight.w600, height: 1.3))),
          const SizedBox(width: 8),
          Text(egp(item.lineTotal),
              style: cairo(fontSize: 13, fontWeight: FontWeight.w700)),
        ]),
        if (comps.isNotEmpty) ...[
          const SizedBox(height: 6),
          ...comps.expand((c) {
            final qty = c.quantity * item.quantity;
            final lines = <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 2),
                child: Text(
                  '${normaliseName(c.itemName)}${c.sizeLabel != null ? ' · ${normaliseName(c.sizeLabel!)}' : ''} × $qty',
                  style: cairo(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary),
                ),
              ),
            ];
            for (final a in c.addons) {
              lines.add(Padding(
                padding: const EdgeInsets.only(left: 28, bottom: 2),
                child: Text(
                  a.priceModifier > 0
                      ? '+ ${normaliseName(a.name)}${a.quantity > 1 ? " ×${a.quantity}" : ""}  ${egp(a.priceModifier * a.quantity)}'
                      : '+ ${normaliseName(a.name)}${a.quantity > 1 ? " ×${a.quantity}" : ""}',
                  style: cairo(fontSize: 10, color: AppColors.primary),
                ),
              ));
            }
            for (final o in c.optionals) {
              lines.add(Padding(
                padding: const EdgeInsets.only(left: 28, bottom: 2),
                child: Text(
                  o.price > 0
                      ? '+ ${o.name}  ${egp(o.price)}'
                      : '+ ${o.name}',
                  style: cairo(fontSize: 10, color: AppColors.warning),
                ),
              ));
            }
            return lines;
          }),
        ],
        const SizedBox(height: 8),
        Row(children: [
          InlineBtn(
              icon: Icons.remove,
              onTap: () {
                HapticFeedback.lightImpact();
                if (item.quantity == 1) {
                  _confirmRemove(context, ref);
                } else {
                  ref
                      .read(cartProvider.notifier)
                      .setQty(index, item.quantity - 1);
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
              HapticFeedback.mediumImpact();
              _confirmRemove(context, ref);
            },
            child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                    color: AppColors.danger.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(AppRadius.sm)),
                alignment: Alignment.center,
                child: const Icon(Icons.delete_outline_rounded,
                    size: 14, color: AppColors.danger)),
          ),
        ]),
      ]),
    );
  }

  void _confirmRemove(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm)),
        title: Text('Remove combo?', style: cairo(fontWeight: FontWeight.w700)),
        content: Text(
            'The whole combo "${item.itemName}" will be removed.',
            style: cairo(fontSize: 13, color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel',
                style: cairo(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(cartProvider.notifier).removeAt(index);
            },
            child: Text('Remove',
                style:
                    cairo(color: AppColors.danger, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
