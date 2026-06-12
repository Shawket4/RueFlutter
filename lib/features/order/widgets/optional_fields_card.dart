import 'package:flutter/material.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/models/menu.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../../../shared/widgets/status_chip.dart';
import '../../../shared/widgets/surface_card.dart';
import 'addon_card.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  OPTIONAL FIELDS CARD — flat list under "Optional" header
// ─────────────────────────────────────────────────────────────────────────────
class OptionalFieldsCard extends StatelessWidget {
  final List<OptionalField> fields;
  final Set<String> selected;
  final String? sizeLabel;
  final void Function(String) onToggle;

  const OptionalFieldsCard({
    super.key,
    required this.fields,
    required this.selected,
    required this.sizeLabel,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;

    // Show only fields that match current size (or have no size restriction).
    final visible = fields
        .where((f) => f.sizeLabel == null || f.sizeLabel == sizeLabel)
        .toList();

    if (visible.isEmpty) return const SizedBox.shrink();

    final selCount =
        selected.where((id) => visible.any((f) => f.id == id)).length;

    return SurfaceCard(
      padding: const EdgeInsets.all(AppSpace.md),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(
            child: Text(l10n(context).orderOptionalHeader,
                style: ui(
                    size: 11,
                    weight: FontWeight.w700,
                    color: t.textSecondary,
                    letterSpacing: 0.6)),
          ),
          if (selCount > 0)
            StatusChip(label: '$selCount', tone: ChipTone.accent),
        ]),
        const SizedBox(height: AppSpace.md),
        Wrap(
          spacing: AppSpace.sm,
          runSpacing: AppSpace.sm,
          children: visible.map((f) {
            return OptionChip(
              label: f.name,
              sublabel: f.isFree ? null : '+${egp(f.price)}',
              selected: selected.contains(f.id),
              checkbox: true,
              onTap: () => onToggle(f.id),
            );
          }).toList(),
        ),
      ]),
    );
  }
}
