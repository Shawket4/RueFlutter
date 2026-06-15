import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/providers/cart_notifier.dart';
import '../../../core/providers/draft_carts_notifier.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/entrance_focus.dart';
import '../../../core/utils/formatting.dart';
import '../../../core/utils/haptics.dart';
import '../../../shared/widgets/animated_icons.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/confirm_sheet.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/responsive_sheet.dart';
import '../checkout/checkout_sheet.dart';
import 'cart_row.dart';
import 'shared_widgets.dart';

/// Compact amount for tab labels: "240" / "240.50" (egp() minus the prefix).
String _tabAmount(int piastres) => egp(piastres).replaceFirst('EGP ', '');

// ─────────────────────────────────────────────────────────────────────────────
//  SIDE CART PANEL — desktop & tablet-landscape
// ─────────────────────────────────────────────────────────────────────────────
class CartPanel extends ConsumerWidget {
  const CartPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final w = MediaQuery.of(context).size.width;
    final cartW = (w * 0.26).clamp(300.0, 380.0);
    // Only the fields this panel lays out — rows watch their own item, the
    // footer watches the totals, so e.g. payment/discount edits don't
    // rebuild the whole panel.
    final (isEmpty, count, itemCount) = ref.watch(
        cartProvider.select((c) => (c.isEmpty, c.count, c.items.length)));

    return Container(
      width: cartW,
      decoration: BoxDecoration(
        color: t.surface,
        border: BorderDirectional(start: BorderSide(color: t.border)),
      ),
      child: Column(children: [
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpace.lg, vertical: 14),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: t.border))),
          child: Row(children: [
            Text(l10n(context).orderCartTitle,
                style: Theme.of(context).textTheme.titleMedium),
            if (!isEmpty) ...[
              const SizedBox(width: AppSpace.sm),
              AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: CountBadge(key: ValueKey(count), count: count)),
            ],
            const Spacer(),
          ]),
        ),
        const DraftTabsBar(),
        Expanded(
            child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: isEmpty
              ? EmptyState(
                  key: const ValueKey('empty'),
                  lottieAsset: 'assets/lottie/empty_cart.json',
                  lottieSize: 130,
                  title: l10n(context).orderCartEmpty,
                  body: l10n(context).orderTapToAdd,
                )
              : ListView.builder(
                  key: const ValueKey('items'),
                  padding:
                      const EdgeInsets.symmetric(vertical: AppSpace.xs),
                  itemCount: itemCount,
                  itemBuilder: (_, i) => CartRow(index: i)),
        )),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isEmpty ? const SizedBox.shrink() : const CartFooter(),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  STICKY FOOTER — totals + checkout
// ─────────────────────────────────────────────────────────────────────────────
class CartFooter extends ConsumerWidget {
  const CartFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final s = l10n(context);
    final (subtotal, discountAmount, taxAmount, total) = ref.watch(
        cartProvider.select(
            (c) => (c.subtotal, c.discountAmount, c.taxAmount, c.total)));

    Widget line(String label, String value,
        {Color? valueColor, double size = 13}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: ui(size: size, color: t.textSecondary)),
            Text(value,
                style: money(
                    size: size,
                    weight: FontWeight.w600,
                    color: valueColor ?? t.textPrimary)),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpace.lg, AppSpace.md, AppSpace.lg, 14),
      decoration: BoxDecoration(
        color: t.surface,
        border: Border(top: BorderSide(color: t.border)),
      ),
      child: Column(children: [
        line(s.orderSubtotal, egp(subtotal)),
        if (discountAmount > 0)
          line(s.orderDiscount, '− ${egp(discountAmount)}',
              valueColor: t.success),
        if (taxAmount > 0) line(s.orderTax, egp(taxAmount)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Divider(height: 1, color: t.borderLight),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(s.orderTotal,
              style: ui(
                  size: 15, weight: FontWeight.w700, color: t.textPrimary)),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, anim) => SlideTransition(
                position: Tween<Offset>(
                        begin: const Offset(0, -0.3), end: Offset.zero)
                    .animate(anim),
                child: FadeTransition(opacity: anim, child: child)),
            child: Text(egp(total),
                key: ValueKey(total),
                style: money(
                    size: 18, weight: FontWeight.w800, color: t.accent)),
          ),
        ]),
        const SizedBox(height: AppSpace.sm + 2),
        AppButton(
            label: s.orderCheckout,
            width: double.infinity,
            height: 50,
            icon: Icons.point_of_sale_rounded,
            onTap: () => CheckoutSheet.show(context)),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  CART FAB — phone & tablet-portrait
// ─────────────────────────────────────────────────────────────────────────────
class MobileCartFab extends ConsumerWidget {
  const MobileCartFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final (isEmpty, count, total) = ref
        .watch(cartProvider.select((c) => (c.isEmpty, c.count, c.total)));
    final draftCount = ref.watch(draftCartsProvider.select((d) => d.length));

    // Hide FAB only if BOTH active cart is empty AND there are no held drafts.
    if (isEmpty && draftCount == 0) return const SizedBox.shrink();

    final Widget label;
    if (!isEmpty) {
      label = Text.rich(TextSpan(children: [
        TextSpan(
            text: '$count · ',
            style:
                ui(size: 13, weight: FontWeight.w700, color: t.textOnAccent)),
        TextSpan(
            text: egp(total),
            style: money(
                size: 13, weight: FontWeight.w700, color: t.textOnAccent)),
      ]));
    } else {
      label = Text(l10n(context).orderHeldOrders(draftCount),
          style: ui(size: 13, weight: FontWeight.w700, color: t.textOnAccent));
    }

    return FloatingActionButton.extended(
      onPressed: () => MobileCartSheet.show(context),
      backgroundColor: t.accent,
      foregroundColor: t.textOnAccent,
      elevation: 4,
      label: label,
      icon: Icon(Icons.shopping_bag_outlined,
          size: 18, color: t.textOnAccent),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  CART SHEET — opened by the FAB
// ─────────────────────────────────────────────────────────────────────────────
class MobileCartSheet extends ConsumerWidget {
  const MobileCartSheet({super.key});

  static Future<void> show(BuildContext ctx) => ResponsiveSheet.show(
        context: ctx,
        builder: (_) => const MobileCartSheet(),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final (isEmpty, count, itemCount) = ref.watch(
        cartProvider.select((c) => (c.isEmpty, c.count, c.items.length)));
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
      decoration: BoxDecoration(
          color: t.surfaceRaised, borderRadius: AppRadius.sheetRadius),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: AppSpace.md),
          child: Center(
              child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                      color: t.border,
                      borderRadius: BorderRadius.circular(2)))),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpace.xl, AppSpace.md, AppSpace.xl, 0),
          child: Row(children: [
            Text(l10n(context).orderCartTitle,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(width: AppSpace.sm),
            CountBadge(count: count),
            const Spacer(),
          ]),
        ),
        const SizedBox(height: AppSpace.sm + 2),
        Divider(height: 1, color: t.border),
        const DraftTabsBar(),
        Expanded(
          child: isEmpty
              ? EmptyState(
                  lottieAsset: 'assets/lottie/empty_cart.json',
                  lottieSize: 130,
                  title: l10n(context).orderCartEmpty,
                  body: l10n(context).orderTapToAdd,
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: AppSpace.sm),
                  itemCount: itemCount,
                  itemBuilder: (_, i) => CartRow(index: i)),
        ),
        if (!isEmpty) const CartFooter(),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DRAFT TABS — held orders ("name · count · subtotal")
// ─────────────────────────────────────────────────────────────────────────────
class DraftTabsBar extends ConsumerWidget {
  const DraftTabsBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    // Display-only slice of the active cart; the full cart is read inside
    // callbacks so the tab bar doesn't rebuild on unrelated cart edits.
    final active = ref.watch(cartProvider.select((c) => (
          id: c.id,
          name: c.displayName,
          createdAt: c.createdAt,
          isEmpty: c.isEmpty,
          count: c.count,
          total: c.total,
        )));
    final drafts = ref.watch(draftCartsProvider);

    if (drafts.isEmpty && active.isEmpty) {
      return const SizedBox.shrink();
    }

    // Merge the active cart with held drafts for stable createdAt sorting.
    final activeId = active.id ?? 'order_1';
    final allTabs = <({String id, String name, DateTime createdAt, CartDraft? draft})>[
      (
        id: activeId,
        name: active.name ?? l10n(context).shellDefaultOrderName,
        createdAt: active.createdAt ?? DateTime.now(),
        draft: null,
      ),
      for (final d in drafts)
        (id: d.id, name: d.name, createdAt: d.createdAt, draft: d),
    ]..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    String tabLabel(String name, {required bool isEmpty, required int count, required int total}) {
      if (isEmpty) return name;
      return '$name · $count · ${_tabAmount(total)}';
    }

    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: t.surfaceAlt,
        border: Border(bottom: BorderSide(color: t.border)),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 10, vertical: 8),
        children: [
          ...allTabs.map((tab) {
            final d = tab.draft;
            if (d == null) {
              return _TabWidget(
                key: ValueKey('active_${tab.id}'),
                label: tabLabel(tab.name,
                    isEmpty: active.isEmpty,
                    count: active.count,
                    total: active.total),
                isActive: true,
                onTap: () {
                  if (!active.isEmpty) {
                    _promptRenameActive(context, ref, active.name);
                  }
                },
                onDelete: () => _confirmDeleteActiveTab(context, ref),
              );
            }
            return _TabWidget(
              key: ValueKey('draft_${d.id}'),
              label: tabLabel(d.name,
                  isEmpty: d.cartState.isEmpty,
                  count: d.cartState.count,
                  total: d.cartState.total),
              isActive: false,
              onTap: () async {
                Haptics.selection();
                await ref
                    .read(draftCartsProvider.notifier)
                    .switchDraft(d.id, ref.read(cartProvider));
              },
              onLongPress: () =>
                  _promptRenameDraft(context, ref, d.id, d.name),
              onDelete: () => _confirmDeleteDraft(context, ref, d.id, d.name),
            );
          }),

          // Hold the current order: the bookmark swings, then (after a short
          // beat) the cart is parked as a draft and a fresh one starts.
          TapToPlayIcon(
            onTapDown: Haptics.impact,
            duration: const Duration(milliseconds: 600),
            onPressed: () async {
              final parked = await ref
                  .read(draftCartsProvider.notifier)
                  .parkCurrentCart(ref.read(cartProvider));
              if (!parked) {
                Haptics.warning();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n(context).orderAddItemsBeforeHold),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
                return;
              }
              if (context.mounted && Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            builder: (_, anim) => Container(
              margin: const EdgeInsetsDirectional.only(start: 4),
              padding:
                  const EdgeInsetsDirectional.symmetric(horizontal: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: t.surface,
                borderRadius: BorderRadius.circular(AppRadius.xs),
                border: Border.all(color: t.border),
              ),
              child: CustomPaint(
                  size: const Size(13, 16),
                  painter: BookmarkPainter(
                      t: anim, color: t.accent, fill: t.accentBg)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteDraft(
      BuildContext context, WidgetRef ref, String id, String name) async {
    final s = l10n(context);
    final ok = await ConfirmSheet.show(
      context,
      title: s.orderDeleteHeldTitle,
      body: s.orderDeleteHeldBody(name),
      confirmLabel: s.commonDelete,
      destructive: true,
    );
    if (ok) await ref.read(draftCartsProvider.notifier).deleteDraft(id);
  }

  Future<void> _confirmDeleteActiveTab(
      BuildContext context, WidgetRef ref) async {
    final s = l10n(context);
    final ok = await ConfirmSheet.show(
      context,
      title: s.orderDeleteActiveTitle,
      body: s.orderDeleteActiveBody,
      confirmLabel: s.orderDeleteTab,
      destructive: true,
    );
    if (!ok) return;

    final oldest = ref.read(draftCartsProvider.notifier).oldestHeldDraft();
    if (oldest != null) {
      await ref.read(draftCartsProvider.notifier).deleteDraft(oldest.id);
      ref.read(cartProvider.notifier).replaceWith(oldest.cartState);
    } else {
      ref.read(cartProvider.notifier).startNewOrder(
            id: 'order_1',
            displayName: context.mounted
                ? l10n(context).shellDefaultOrderName
                : 'Order 1',
          );
    }
  }

  Future<void> _promptRenameActive(
      BuildContext context, WidgetRef ref, String? currentName) async {
    final name = await _RenameSheet.show(
      context,
      title: l10n(context).orderRenameOrder,
      initial: currentName ?? '',
    );
    if (name != null && name.isNotEmpty) {
      ref.read(cartProvider.notifier).renameDisplayName(name);
    }
  }

  Future<void> _promptRenameDraft(BuildContext context, WidgetRef ref,
      String draftId, String currentName) async {
    final name = await _RenameSheet.show(
      context,
      title: l10n(context).orderRenameHeldOrder,
      initial: currentName,
    );
    if (name != null && name.isNotEmpty) {
      await ref.read(draftCartsProvider.notifier).renameDraft(draftId, name);
    }
  }
}

class _TabWidget extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDelete;

  const _TabWidget({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.onLongPress,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsetsDirectional.only(end: 6),
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isActive ? t.surface : t.hoverOverlay,
          borderRadius: BorderRadius.circular(AppRadius.xs),
          border: Border.all(
            color: isActive ? t.accent : t.border,
            width: isActive ? 1.4 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive
                  ? Icons.shopping_bag_rounded
                  : Icons.shopping_bag_outlined,
              size: 13,
              color: isActive ? t.accent : t.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: money(
                size: 12,
                weight: isActive ? FontWeight.w700 : FontWeight.w600,
                color: isActive ? t.accent : t.textSecondary,
              ),
            ),
            if (onDelete != null) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () {
                  Haptics.selection();
                  onDelete!();
                },
                child: Icon(
                  Icons.close_rounded,
                  size: 14,
                  color: t.textMuted,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  RENAME SHEET — small input sheet (ConfirmSheet has no text field)
// ─────────────────────────────────────────────────────────────────────────────
class _RenameSheet extends StatefulWidget {
  final String title;
  final String initial;
  const _RenameSheet({required this.title, required this.initial});

  static Future<String?> show(BuildContext context,
          {required String title, required String initial}) =>
      ResponsiveSheet.show<String>(
        context: context,
        builder: (_) => _RenameSheet(title: title, initial: initial),
      );

  @override
  State<_RenameSheet> createState() => _RenameSheetState();
}

class _RenameSheetState extends State<_RenameSheet>
    with EntranceFocus<_RenameSheet> {
  late final TextEditingController _ctrl =
      TextEditingController(text: widget.initial);
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    focusAfterEntrance(_focus);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _submit() => Navigator.pop(context, _ctrl.text.trim());

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        margin: const EdgeInsets.all(AppSpace.md),
        padding: const EdgeInsets.all(AppSpace.xl),
        decoration: BoxDecoration(
          color: t.surfaceRaised,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: t.border),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpace.xs),
            Text(l10n(context).orderRenameHint,
                style: ui(size: 13, color: t.textSecondary)),
            const SizedBox(height: AppSpace.lg),
            TextField(
              controller: _ctrl,
              focusNode: _focus,
              onSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                hintText: l10n(context).orderRenamePlaceholder,
              ),
            ),
            const SizedBox(height: AppSpace.lg),
            Row(children: [
              Expanded(
                child: AppButton(
                  label: l10n(context).cancelAction,
                  variant: BtnVariant.outline,
                  height: 46,
                  onTap: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: AppSpace.md),
              Expanded(
                child: AppButton(
                    label: l10n(context).commonSave,
                    height: 46,
                    onTap: _submit),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
