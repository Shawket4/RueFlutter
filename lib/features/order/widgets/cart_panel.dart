import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../../core/providers/cart_notifier.dart';
import '../../../core/providers/draft_carts_notifier.dart';
import '../../../core/models/cart.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/label_value.dart';
import '../../../shared/widgets/responsive_sheet.dart';
import 'cart_row.dart';
import '../checkout/checkout_sheet.dart';
import 'shared_widgets.dart';

class CartPanel extends ConsumerWidget {
  const CartPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final w = MediaQuery.of(context).size.width;
    final cartW = (w * 0.26).clamp(280.0, 360.0);
    final cart = ref.watch(cartProvider);

    return Container(
      width: cartW,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(color: AppColors.border))),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border))),
          child: Row(children: [
            Text('Order',
                style: cairo(fontSize: 15, fontWeight: FontWeight.w800)),
            if (!cart.isEmpty) ...[
              const SizedBox(width: 8),
              AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: CountBadge(
                      key: ValueKey(cart.count), count: cart.count)),
            ],
            const Spacer(),
          ]),
        ),
        const DraftTabsBar(),
        Expanded(
            child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: cart.isEmpty
              ? const _EmptyCart()
              : ListView.builder(
                  key: const ValueKey('items'),
                  padding: EdgeInsets.zero,
                  itemCount: cart.items.length,
                  itemBuilder: (_, i) => CartRow(index: i)),
        )),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: cart.isEmpty ? const SizedBox.shrink() : const CartFooter(),
        ),
      ]),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();
  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
              width: 110,
              height: 110,
              child: Lottie.asset('assets/lottie/empty_cart.json',
                  fit: BoxFit.contain, repeat: true)),
          const SizedBox(height: 8),
          Text('Cart is empty',
              style: cairo(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary)),
          const SizedBox(height: 3),
          Text('Tap any item to add it',
              style: cairo(fontSize: 11, color: AppColors.textMuted)),
        ]),
      );
}

class CartFooter extends ConsumerWidget {
  const CartFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.border))),
      child: Column(children: [
        LabelValue('Subtotal', egp(cart.subtotal)),
        if (cart.discountAmount > 0)
          LabelValue('Discount', '− ${egp(cart.discountAmount)}',
              valueColor: AppColors.success),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Divider(height: 1, color: AppColors.borderLight),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total',
                  style: cairo(fontSize: 15, fontWeight: FontWeight.w700)),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, anim) => SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(0, -0.3), end: Offset.zero)
                        .animate(anim),
                    child: FadeTransition(opacity: anim, child: child)),
                child: Text(egp(cart.total),
                    key: ValueKey(cart.total),
                    style: cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary)),
              ),
            ]),
        const SizedBox(height: 10),
        AppButton(
            label: 'Checkout',
            width: double.infinity,
            height: 48,
            icon: Icons.arrow_forward_rounded,
            onTap: () => CheckoutSheet.show(context)),
      ]),
    );
  }
}

class MobileCartFab extends ConsumerWidget {
  const MobileCartFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final drafts = ref.watch(draftCartsProvider);

    // Hide FAB only if BOTH active cart is empty AND there are no held drafts!
    if (cart.isEmpty && drafts.isEmpty) return const SizedBox.shrink();

    final String label;
    if (!cart.isEmpty) {
      label = '${cart.count} items · ${egp(cart.total)}';
    } else {
      label = 'Held Orders (${drafts.length})';
    }

    return FloatingActionButton.extended(
      onPressed: () => _MobileCartSheet.show(context),
      backgroundColor: AppColors.primary,
      elevation: 4,
      label: Text(label,
          style: cairo(
              fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
      icon: const Icon(Icons.shopping_bag_outlined,
          size: 18, color: Colors.white),
    );
  }
}

class _MobileCartSheet extends ConsumerWidget {
  const _MobileCartSheet();

  static void show(BuildContext ctx) => ResponsiveSheet.show(
        context: ctx,
        builder: (_) => const _MobileCartSheet(),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: AppRadius.sheetRadius),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Center(
              child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2)))),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Row(children: [
            Text('Order',
                style: cairo(fontSize: 17, fontWeight: FontWeight.w800)),
            const SizedBox(width: 8),
            CountBadge(count: cart.count),
            const Spacer(),
          ]),
        ),
        const SizedBox(height: 10),
        Container(height: 1, color: AppColors.border),
        const DraftTabsBar(),
        Expanded(
          child: cart.isEmpty
              ? Center(
                  child: Text('Cart is empty',
                      style: cairo(color: AppColors.textSecondary)))
              : ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: cart.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 6),
                  itemBuilder: (_, i) => CartRow(index: i)),
        ),
        if (!cart.isEmpty) const CartFooter(),
      ]),
    );
  }
}

class DraftTabsBar extends ConsumerWidget {
  const DraftTabsBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final drafts = ref.watch(draftCartsProvider);

    if (drafts.isEmpty && cart.isEmpty) {
      return const SizedBox.shrink();
    }

    // Convert active cart to a CartDraft for stable sorting
    final activeDraft = CartDraft(
      id: cart.id ?? 'order_1',
      name: cart.displayName ?? 'Order 1',
      cartState: cart,
      createdAt: cart.createdAt ?? DateTime.now(),
    );

    // Combine active tab and drafts, then sort by createdAt ascending
    final List<CartDraft> allTabs = [activeDraft, ...drafts];
    allTabs.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return Container(
      height: 48,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        children: [
          ...allTabs.map((t) {
            final isActive = t.id == activeDraft.id;
            if (isActive) {
              return _TabWidget(
                key: ValueKey('active_${t.id}'),
                label: '${t.name} (Current)',
                isActive: true,
                isEmpty: cart.isEmpty,
                onTap: () {
                  if (!cart.isEmpty) {
                    _promptRenameActive(context, ref, cart.displayName);
                  }
                },
                onDelete: () => _confirmDeleteActiveTab(context, ref, cart),
              );
            } else {
              return _TabWidget(
                key: ValueKey('draft_${t.id}'),
                label: t.name,
                isActive: false,
                isEmpty: false,
                onTap: () {
                  HapticFeedback.lightImpact();
                  ref.read(draftCartsProvider.notifier).switchDraft(t.id, cart);
                },
                onLongPress: () => _promptRenameDraft(context, ref, t.id, t.name),
                onDelete: () => _confirmDeleteDraft(context, ref, t.id, t.name),
              );
            }
          }),

          // 3. Add Tab Button (+)
          GestureDetector(
            onTap: () async {
              HapticFeedback.mediumImpact();
              final parked = await ref
                  .read(draftCartsProvider.notifier)
                  .parkCurrentCart(cart);
              if (!parked) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Add items before holding this order',
                        style: cairo(fontSize: 13),
                      ),
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
            child: Container(
              margin: const EdgeInsets.only(left: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.xs),
                border: Border.all(color: AppColors.border),
              ),
              child: const Icon(Icons.add_rounded, size: 16, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteDraft(BuildContext context, WidgetRef ref, String id, String name) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.sm)),
        title: Text('Delete Held Order?', style: cairo(fontWeight: FontWeight.w700)),
        content: Text('Are you sure you want to delete "$name"? All its items will be permanently removed.', style: cairo(fontSize: 13, color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: cairo(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(draftCartsProvider.notifier).deleteDraft(id);
            },
            child: Text('Delete', style: cairo(color: AppColors.danger, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteActiveTab(BuildContext context, WidgetRef ref, CartState cart) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.sm)),
        title: Text('Delete Active Order?', style: cairo(fontWeight: FontWeight.w700)),
        content: Text('Are you sure you want to delete this active order tab? All its items will be permanently removed.', style: cairo(fontSize: 13, color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: cairo(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);

              final oldest =
                  ref.read(draftCartsProvider.notifier).oldestHeldDraft();
              if (oldest != null) {
                await ref
                    .read(draftCartsProvider.notifier)
                    .deleteDraft(oldest.id);
                ref
                    .read(cartProvider.notifier)
                    .replaceWith(oldest.cartState);
              } else {
                ref.read(cartProvider.notifier).startNewOrder(
                      id: 'order_1',
                      displayName: 'Order 1',
                    );
              }
            },
            child: Text('Delete Tab', style: cairo(color: AppColors.danger, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _promptRenameActive(BuildContext context, WidgetRef ref, String? currentName) {
    final ctrl = TextEditingController(text: currentName ?? '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.sm)),
        title: Text('Rename Active Cart', style: cairo(fontWeight: FontWeight.w700)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter a custom name/label for this active cart:', style: cairo(fontSize: 13, color: AppColors.textSecondary)),
            const SizedBox(height: 12),
            TextField(
              controller: ctrl,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'e.g., Table 5, Sarah, Guest',
                hintStyle: cairo(color: AppColors.textMuted, fontSize: 13),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.border),
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                ),
              ),
              style: cairo(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: cairo(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(cartProvider.notifier).renameDisplayName(ctrl.text);
            },
            child: Text('Save', style: cairo(color: AppColors.primary, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _promptRenameDraft(BuildContext context, WidgetRef ref, String draftId, String currentName) {
    final ctrl = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.sm)),
        title: Text('Rename Draft Cart', style: cairo(fontWeight: FontWeight.w700)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter a custom name/label for this draft cart:', style: cairo(fontSize: 13, color: AppColors.textSecondary)),
            const SizedBox(height: 12),
            TextField(
              controller: ctrl,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'e.g., Table 5, Sarah, Guest',
                hintStyle: cairo(color: AppColors.textMuted, fontSize: 13),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.border),
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                ),
              ),
              style: cairo(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: cairo(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(draftCartsProvider.notifier).renameDraft(draftId, ctrl.text.trim());
            },
            child: Text('Save', style: cairo(color: AppColors.primary, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _TabWidget extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isEmpty;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDelete;

  const _TabWidget({
    super.key,
    required this.label,
    required this.isActive,
    required this.isEmpty,
    required this.onTap,
    this.onLongPress,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(right: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : AppColors.border.withOpacity(0.25),
          borderRadius: BorderRadius.circular(AppRadius.xs),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.border,
            width: isActive ? 1.4 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? Icons.shopping_bag_rounded : Icons.shopping_bag_outlined,
              size: 13,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: cairo(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                color: isActive ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
            if (onDelete != null) ...[
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  onDelete!();
                },
                child: const Icon(
                  Icons.close_rounded,
                  size: 14,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
