import 'package:flutter/material.dart';
import '../../../core/models/order.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';

class OrderIngredientsSheet extends StatelessWidget {
  final OrderItem item;

  const OrderIngredientsSheet({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final maxH = mq.size.height * 0.75;

    // Group deductions
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

    return Container(
      constraints: BoxConstraints(maxHeight: maxH),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.sheetRadius,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
            offset: Offset(0, -4),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 12, 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.science_rounded,
                              size: 16,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Ingredient Use',
                              style: cairo(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Padding(
                        padding: const EdgeInsets.only(left: 36),
                        child: Text(
                          normaliseName(item.itemName),
                          style: cairo(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded,
                        color: AppColors.textMuted),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.bg,
                      minimumSize: const Size(36, 36),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),

          // Body listing deductions
          Flexible(
            child: item.deductions.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.inbox_rounded,
                              size: 40, color: AppColors.border),
                          const SizedBox(height: 12),
                          Text(
                            'No ingredient deductions recorded.',
                            style: cairo(
                                fontSize: 14, color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                    itemCount: grouped.length,
                    itemBuilder: (context, index) {
                      final groupTitle = grouped.keys.elementAt(index);
                      final deductions = grouped[groupTitle]!;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
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
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  groupTitle,
                                  style: cairo(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ...deductions.map(
                              (d) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: _DeductionCard(deduction: d),
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
    );
  }
}

class _DeductionCard extends StatelessWidget {
  final InventoryDeduction deduction;

  const _DeductionCard({required this.deduction});

  @override
  Widget build(BuildContext context) {
    final sourceLabel = _getSourceLabel(deduction.source);
    final isBase = sourceLabel == 'base';
    final Color badgeColor =
        isBase ? AppColors.primary : AppColors.textSecondary;
    final Color bgColor =
        isBase ? AppColors.primary.withOpacity(0.04) : Colors.white;
    final Color borderColor =
        isBase ? AppColors.primary.withOpacity(0.15) : AppColors.border;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppRadius.xs),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  deduction.quantity % 1 == 0
                      ? deduction.quantity.toInt().toString()
                      : deduction.quantity.toStringAsFixed(1),
                  style: cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    height: 1.1,
                  ),
                ),
                Text(
                  deduction.unit,
                  style: cairo(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  normaliseName(deduction.ingredientName),
                  style: cairo(
                    fontSize: 13.5,
                    fontWeight: isBase ? FontWeight.w700 : FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (deduction.category.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    normaliseName(deduction.category),
                    style: cairo(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: badgeColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: badgeColor.withOpacity(0.15)),
            ),
            child: Text(
              sourceLabel,
              style: cairo(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: badgeColor,
              ),
            ),
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
