import 'package:flutter/material.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/models/order.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/status_chip.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  ORDER INGREDIENTS SHEET — inventory deductions recorded for an order line
// ─────────────────────────────────────────────────────────────────────────────
class OrderIngredientsSheet extends StatelessWidget {
  final OrderItem item;

  const OrderIngredientsSheet({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final maxH = MediaQuery.of(context).size.height * 0.75;

    // Group deductions by source component.
    final Map<String, List<InventoryDeduction>> grouped = {};
    for (final d in item.deductions) {
      String groupName = '';
      if (d.source.startsWith('bundle_component:')) {
        groupName = d.source.substring('bundle_component:'.length);
      } else {
        groupName = item.itemName;
      }
      final prettyName = normaliseName(groupName);
      grouped.putIfAbsent(prettyName, () => []).add(d);
    }

    // Mirrors ResponsiveSheet's centering: the caller opens this with a raw
    // showModalBottomSheet, so the width cap for tablets lives here.
    return Align(
      alignment: Alignment.bottomCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 600, maxHeight: maxH),
        child: Container(
          decoration: BoxDecoration(
            color: t.surfaceRaised,
            borderRadius: AppRadius.sheetRadius,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _DragHandle(),

              // ── Header ────────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpace.lg, 0, AppSpace.lg, AppSpace.md),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: t.navyBg, shape: BoxShape.circle),
                      child:
                          Icon(Icons.science_rounded, size: 16, color: t.navy),
                    ),
                    const SizedBox(width: AppSpace.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n(context).orderIngredientUse,
                            style: Theme.of(context).textTheme.titleLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            normaliseName(item.itemName),
                            style: ui(
                                size: 12.5,
                                weight: FontWeight.w600,
                                color: t.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpace.sm),
                    _CloseBtn(onTap: () => Navigator.pop(context)),
                  ],
                ),
              ),
              Container(height: 1, color: t.border),

              // ── Body ──────────────────────────────────────────────────────
              Flexible(
                child: item.deductions.isEmpty
                    ? SingleChildScrollView(
                        child: EmptyState(
                          icon: Icons.inventory_2_outlined,
                          title: l10n(context).orderNoDeductions,
                          body: l10n(context).orderNoDeductionsBody,
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            AppSpace.lg,
                            AppSpace.lg,
                            AppSpace.lg,
                            AppSpace.xxl),
                        itemCount: grouped.length,
                        itemBuilder: (context, index) {
                          final groupTitle = grouped.keys.elementAt(index);
                          final deductions = grouped[groupTitle]!;

                          return Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppSpace.lg),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      item.isBundleLine
                                          ? Icons.restaurant_menu_rounded
                                          : Icons.local_cafe_rounded,
                                      size: 16,
                                      color: t.navy,
                                    ),
                                    const SizedBox(width: AppSpace.sm),
                                    Expanded(
                                      child: Text(
                                        groupTitle,
                                        style: ui(
                                            size: 14,
                                            weight: FontWeight.w700,
                                            color: t.textPrimary),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSpace.sm),
                                ...deductions.map(
                                  (d) => Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: AppSpace.sm),
                                    child: _DeductionRow(deduction: d),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DEDUCTION ROW
// ─────────────────────────────────────────────────────────────────────────────
class _DeductionRow extends StatelessWidget {
  final InventoryDeduction deduction;

  const _DeductionRow({required this.deduction});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    final sourceLabel = _getSourceLabel(deduction.source);
    final isBase = sourceLabel == 'base';
    final displayLabel = switch (sourceLabel) {
      'base' => s.orderSourceBase,
      'combo item' => s.orderSourceComboItem,
      'addon' => s.orderSourceAddon,
      _ => sourceLabel,
    };

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.md, vertical: AppSpace.md),
      decoration: BoxDecoration(
        color: isBase ? t.navyBg : t.surface,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: isBase ? t.navy.withOpacity(0.25) : t.border),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: t.surfaceRaised,
              borderRadius: BorderRadius.circular(AppRadius.xs),
              border: Border.all(color: t.borderLight),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  deduction.quantity % 1 == 0
                      ? deduction.quantity.toInt().toString()
                      : deduction.quantity.toStringAsFixed(1),
                  style: ui(
                      size: 14,
                      weight: FontWeight.w700,
                      color: t.textPrimary,
                      height: 1.1),
                ),
                Text(
                  deduction.unit,
                  style: ui(
                      size: 10, weight: FontWeight.w600, color: t.textMuted),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpace.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  normaliseName(deduction.ingredientName),
                  style: ui(
                      size: 13.5,
                      weight: isBase ? FontWeight.w700 : FontWeight.w600,
                      color: t.textPrimary),
                ),
                if (deduction.category.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    normaliseName(deduction.category),
                    style: ui(size: 10.5, color: t.textSecondary),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSpace.sm),
          StatusChip(
            label: displayLabel.toUpperCase(),
            tone: isBase ? ChipTone.info : ChipTone.neutral,
          ),
        ],
      ),
    );
  }

  String _getSourceLabel(String source) {
    if (source.startsWith('bundle_component:')) {
      return 'combo item';
    }
    if (source == 'drink_recipe' || source == 'base') {
      return 'base';
    }
    if (source.startsWith('optional:')) {
      return normaliseName(source.substring('optional:'.length));
    }
    if (source.startsWith('addon_swap:')) {
      return normaliseName(source.substring('addon_swap:'.length));
    }
    if (source == 'addon') {
      return 'addon';
    }
    return normaliseName(source);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SMALL PARTS
// ─────────────────────────────────────────────────────────────────────────────
class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            const EdgeInsets.only(top: AppSpace.md, bottom: AppSpace.md),
        child: Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.tokens.border,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
          ),
        ),
      );
}

class _CloseBtn extends StatelessWidget {
  final VoidCallback onTap;
  const _CloseBtn({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return AnimatedPressScale(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: t.surfaceAlt,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: t.border),
        ),
        child: Icon(Icons.close_rounded, size: 18, color: t.textSecondary),
      ),
    );
  }
}
