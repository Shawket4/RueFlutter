import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/models/cart.dart';
import '../../../core/providers/cart_notifier.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../../../shared/widgets/confirm_sheet.dart';
import 'shared_widgets.dart';

class BundleCartRow extends ConsumerWidget {
  final int index;
  final CartItem item;

  const BundleCartRow({super.key, required this.index, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final comps = item.bundleComponents ?? const [];

    return Container(
      margin: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpace.sm, vertical: AppSpace.xs),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: t.navyBg.withOpacity(0.45),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: t.navy.withOpacity(0.2)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.layers_outlined, size: 14, color: t.navy),
          const SizedBox(width: 6),
          Expanded(
              child: Text(
                  item.quantity > 1
                      ? '${normaliseName(item.itemName)} × ${item.quantity}'
                      : normaliseName(item.itemName),
                  style: ui(
                      size: 13,
                      weight: FontWeight.w600,
                      color: t.textPrimary,
                      height: 1.3))),
          const SizedBox(width: 8),
          Text(egp(item.lineTotal),
              style: money(
                  size: 13, weight: FontWeight.w700, color: t.textPrimary)),
        ]),
        if (comps.isNotEmpty) ...[
          const SizedBox(height: 6),
          ...comps.expand((c) {
            final qty = c.quantity * item.quantity;
            final lines = <Widget>[
              Padding(
                padding:
                    const EdgeInsetsDirectional.only(start: 20, bottom: 2),
                child: Text(
                  '${normaliseName(c.itemName)}${c.sizeLabel != null ? ' · ${normaliseName(c.sizeLabel!)}' : ''} × $qty',
                  style: ui(
                      size: 11,
                      weight: FontWeight.w600,
                      color: t.textSecondary),
                ),
              ),
            ];
            for (final a in c.addons) {
              lines.add(Padding(
                padding:
                    const EdgeInsetsDirectional.only(start: 28, bottom: 2),
                child: Text(
                  a.priceModifier > 0
                      ? '+ ${normaliseName(a.name)}${a.quantity > 1 ? " ×${a.quantity}" : ""}  ${egp(a.priceModifier * a.quantity)}'
                      : '+ ${normaliseName(a.name)}${a.quantity > 1 ? " ×${a.quantity}" : ""}',
                  style: ui(size: 10, color: t.navy),
                ),
              ));
            }
            for (final o in c.optionals) {
              lines.add(Padding(
                padding:
                    const EdgeInsetsDirectional.only(start: 28, bottom: 2),
                child: Text(
                  o.price > 0 ? '+ ${o.name}  ${egp(o.price)}' : '+ ${o.name}',
                  style: ui(size: 10, color: t.warning),
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
              padding:
                  const EdgeInsetsDirectional.symmetric(horizontal: 12),
              child: Text('${item.quantity}',
                  style: money(
                      size: 14,
                      weight: FontWeight.w700,
                      color: t.textPrimary))),
          InlineBtn(
              icon: Icons.add,
              onTap: () {
                HapticFeedback.lightImpact();
                ref
                    .read(cartProvider.notifier)
                    .setQty(index, item.quantity + 1);
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
                    color: t.dangerBg,
                    borderRadius: BorderRadius.circular(AppRadius.sm)),
                alignment: Alignment.center,
                child: Icon(Icons.delete_outline_rounded,
                    size: 14, color: t.danger)),
          ),
        ]),
      ]),
    );
  }

  Future<void> _confirmRemove(BuildContext context, WidgetRef ref) async {
    final s = l10n(context);
    final ok = await ConfirmSheet.show(
      context,
      title: s.orderRemoveComboTitle,
      body: s.orderRemoveComboBody(item.itemName),
      confirmLabel: s.commonRemove,
      destructive: true,
    );
    if (ok) ref.read(cartProvider.notifier).removeAt(index);
  }
}
