import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/models/menu.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../../../shared/widgets/status_chip.dart';
import '../../../shared/widgets/surface_card.dart';

/// Visibility of the auto-dismissing "max N selections" hint. The 2.6 s
/// dismiss timer stays in the card's State object; only the flag lives here.
/// Family-keyed by the card's [AddonCard.id] so cards never share hint state.
final _addonMaxHintProvider =
    NotifierProvider.autoDispose.family<_AddonMaxHintNotifier, bool, String>(
        _AddonMaxHintNotifier.new);

class _AddonMaxHintNotifier extends AutoDisposeFamilyNotifier<bool, String> {
  @override
  bool build(String arg) => false;

  void show() => state = true;

  void hide() => state = false;
}

// ─────────────────────────────────────────────────────────────────────────────
//  ADDON CARD  — one per addon type (slotted or unslotted)
// ─────────────────────────────────────────────────────────────────────────────
class AddonCard extends ConsumerStatefulWidget {
  /// Stable identity (slot id or addon type) for sheet-local provider state.
  final String id;
  final String title;
  final bool isRequired;
  final bool isMulti;
  final int? maxSelections;
  final List<AddonItem> items;
  final String? selectedSingle;
  final Map<String, int> selectedMulti;
  final void Function(String) onToggleSingle;
  final void Function(String) onToggleMulti;
  final void Function(String) onIncrement;
  final void Function(String) onDecrement;
  final Color? accentColor;

  const AddonCard({
    super.key,
    required this.id,
    required this.title,
    required this.isRequired,
    required this.isMulti,
    required this.maxSelections,
    required this.items,
    required this.selectedSingle,
    required this.selectedMulti,
    required this.onToggleSingle,
    required this.onToggleMulti,
    required this.onIncrement,
    required this.onDecrement,
    this.accentColor,
  });

  @override
  ConsumerState<AddonCard> createState() => _AddonCardState();
}

class _AddonCardState extends ConsumerState<AddonCard> {
  final _searchCtrl = TextEditingController();
  Timer? _hintTimer;

  @override
  void dispose() {
    _hintTimer?.cancel();
    _searchCtrl.dispose();
    super.dispose();
  }

  bool _isSelected(String id) => widget.selectedMulti.containsKey(id);

  int _qty(String id) => widget.selectedMulti[id] ?? 1;

  int get _selCount {
    if (!widget.isMulti) return widget.selectedSingle != null ? 1 : 0;
    return widget.selectedMulti.length;
  }

  bool get _atMax =>
      widget.isMulti &&
      widget.maxSelections != null &&
      _selCount >= widget.maxSelections!;

  /// Visible feedback when tapping a chip that is blocked by the max limit.
  void _showMaxHint() {
    _hintTimer?.cancel();
    ref.read(_addonMaxHintProvider(widget.id).notifier).show();
    _hintTimer = Timer(const Duration(milliseconds: 2600), () {
      if (mounted) ref.read(_addonMaxHintProvider(widget.id).notifier).hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final dotColor = widget.accentColor ?? t.accent;
    final showSearch = widget.items.length > 5;
    final hintVisible = ref.watch(_addonMaxHintProvider(widget.id));

    return SurfaceCard(
      padding: const EdgeInsets.all(AppSpace.md),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // ── Header ──────────────────────────────────────────────────────────
        Row(children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpace.sm),
          Expanded(
            child: Text(widget.title.toUpperCase(),
                style: ui(
                    size: 11,
                    weight: FontWeight.w700,
                    color: t.textSecondary,
                    letterSpacing: 0.6)),
          ),
          if (widget.isRequired) ...[
            const SizedBox(width: AppSpace.xs),
            StatusChip(
                label: l10n(context).orderRequiredChip,
                tone: ChipTone.danger),
          ],
          if (widget.maxSelections != null) ...[
            const SizedBox(width: AppSpace.xs),
            StatusChip(
                label:
                    l10n(context).orderMaxSelections(widget.maxSelections!)),
          ],
          if (_selCount > 0) ...[
            const SizedBox(width: AppSpace.xs),
            StatusChip(label: '$_selCount', tone: ChipTone.accent),
          ],
        ]),

        // ── Max-selections hint (auto-dismissing) ───────────────────────────
        AnimatedSize(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          alignment: AlignmentDirectional.topStart,
          child: !hintVisible
              ? const SizedBox(width: double.infinity)
              : Padding(
                  padding: const EdgeInsets.only(top: AppSpace.sm),
                  child: Row(children: [
                    Icon(Icons.info_outline_rounded,
                        size: 14, color: t.warning),
                    const SizedBox(width: AppSpace.xs),
                    Expanded(
                      child: Text(
                          l10n(context).orderMaxHint(
                              widget.maxSelections ?? 0, widget.title),
                          style: ui(
                              size: 12,
                              weight: FontWeight.w600,
                              color: t.warning)),
                    ),
                  ]),
                ),
        ),

        // ── Search + chips ──────────────────────────────────────────────────
        // Keystrokes only rebuild this builder — never the parent sheet.
        ListenableBuilder(
          listenable: _searchCtrl,
          builder: (context, _) {
            final query = _searchCtrl.text.trim().toLowerCase();
            final opts = query.isEmpty
                ? widget.items
                : widget.items
                    .where((o) => o.name.toLowerCase().contains(query))
                    .toList();

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showSearch) ...[
                    const SizedBox(height: AppSpace.md),
                    Container(
                      height: 38,
                      decoration: BoxDecoration(
                          color: t.surfaceAlt,
                          borderRadius: BorderRadius.circular(AppRadius.xs),
                          border: Border.all(color: t.border)),
                      child: TextField(
                        controller: _searchCtrl,
                        style: ui(size: 13, color: t.textPrimary),
                        decoration: InputDecoration(
                          hintText: l10n(context).orderSearchOptions,
                          hintStyle: ui(size: 13, color: t.textMuted),
                          prefixIcon: Icon(Icons.search_rounded,
                              size: 16, color: t.textMuted),
                          suffixIcon: query.isNotEmpty
                              ? GestureDetector(
                                  onTap: _searchCtrl.clear,
                                  child: Icon(Icons.close_rounded,
                                      size: 15, color: t.textMuted))
                              : null,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                          isDense: true,
                          filled: false,
                        ),
                      ),
                    ),
                  ],

                  // ── Chips ──────────────────────────────────────────────────
                  const SizedBox(height: AppSpace.md),
                  if (opts.isEmpty)
                    Text(l10n(context).orderNoMatchFor(query),
                        style: ui(size: 12, color: t.textMuted))
                  else
                    Wrap(
                        spacing: AppSpace.sm,
                        runSpacing: AppSpace.sm,
                        children: opts.map((opt) {
                          final sel = widget.isMulti
                              ? _isSelected(opt.id)
                              : widget.selectedSingle == opt.id;

                          // Multi-select selected chip: show qty stepper
                          // inline.
                          if (widget.isMulti && sel) {
                            return QtyChip(
                              label: normaliseName(opt.name),
                              price: opt.defaultPrice,
                              qty: _qty(opt.id),
                              onIncrement: () => widget.onIncrement(opt.id),
                              onDecrement: () => widget.onDecrement(opt.id),
                            );
                          }

                          // At max: unselected chips dim, but stay tappable
                          // so the tap can explain *why* nothing happens.
                          final blocked = widget.isMulti && _atMax && !sel;

                          return OptionChip(
                            label: normaliseName(opt.name),
                            sublabel: opt.defaultPrice > 0
                                ? '+${egp(opt.defaultPrice)}'
                                : null,
                            selected: sel,
                            checkbox: widget.isMulti,
                            dimmed: blocked,
                            onTap: () {
                              if (blocked) {
                                _showMaxHint();
                                return;
                              }
                              widget.isMulti
                                  ? widget.onToggleMulti(opt.id)
                                  : widget.onToggleSingle(opt.id);
                            },
                          );
                        }).toList()),
                ]);
          },
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  OPTION CHIP  — token-aware selectable chip (sizes, addons, optionals)
// ─────────────────────────────────────────────────────────────────────────────
class OptionChip extends StatelessWidget {
  final String label;
  final String? sublabel;
  final bool selected;
  final bool checkbox;
  final bool dimmed;
  final VoidCallback onTap;

  const OptionChip({
    super.key,
    required this.label,
    this.sublabel,
    required this.selected,
    this.checkbox = false,
    this.dimmed = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final fg = selected
        ? t.textOnAccent
        : dimmed
            ? t.textMuted
            : t.textPrimary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: dimmed ? 0.55 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          decoration: BoxDecoration(
            color: selected ? t.accent : t.surfaceAlt,
            borderRadius: BorderRadius.circular(AppRadius.xs),
            border: Border.all(color: selected ? t.accent : t.border),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            if (checkbox) ...[
              Icon(
                  selected
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank_rounded,
                  size: 15,
                  color: selected ? t.textOnAccent : t.textMuted),
              const SizedBox(width: 6),
            ],
            Text(label, style: ui(size: 13, weight: FontWeight.w600, color: fg)),
            if (sublabel != null) ...[
              const SizedBox(width: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: selected
                        ? t.textOnAccent.withOpacity(0.2)
                        : t.accentBg,
                    borderRadius: BorderRadius.circular(4)),
                child: Text(sublabel!,
                    style: money(
                        size: 10.5,
                        weight: FontWeight.w700,
                        color: selected ? t.textOnAccent : t.accent)),
              ),
            ],
          ]),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  QTY CHIP  — selected multi addon with inline +/- stepper
// ─────────────────────────────────────────────────────────────────────────────
class QtyChip extends StatelessWidget {
  final String label;
  final int price;
  final int qty;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QtyChip({
    super.key,
    required this.label,
    required this.price,
    required this.qty,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      decoration: BoxDecoration(
          color: t.accent,
          borderRadius: BorderRadius.circular(AppRadius.xs)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        _StepBtn(icon: Icons.remove, onTap: onDecrement),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(label,
                style: ui(
                    size: 12,
                    weight: FontWeight.w600,
                    color: t.textOnAccent)),
            if (price > 0)
              Text('+${egp(price * qty)}',
                  style: money(
                      size: 9.5,
                      weight: FontWeight.w700,
                      color: t.textOnAccent.withOpacity(0.85))),
          ]),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
              color: t.textOnAccent.withOpacity(0.22),
              borderRadius: BorderRadius.circular(4)),
          child: Text('$qty',
              style: ui(
                  size: 11,
                  weight: FontWeight.w800,
                  color: t.textOnAccent)),
        ),
        _StepBtn(icon: Icons.add, onTap: onIncrement),
      ]),
    );
  }
}

class _StepBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _StepBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 32,
        height: 38,
        child: Icon(icon, size: 14, color: t.textOnAccent),
      ),
    );
  }
}
