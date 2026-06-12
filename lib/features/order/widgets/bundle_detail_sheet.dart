import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/models/bundle.dart';
import '../../../core/models/cart.dart';
import '../../../core/models/menu.dart';
import '../../../core/providers/cart_notifier.dart';
import '../../../core/providers/menu_notifier.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/responsive_sheet.dart';
import '../../../shared/widgets/status_chip.dart';
import '../../../shared/widgets/surface_card.dart';
import 'item_detail_sheet.dart';

bool componentNeedsConfiguration(
  MenuItem item,
  Map<String, List<AddonItem>> addonsByType,
) {
  if (item.sizes.length > 1) return true;
  if (item.optionalFields.any((f) => f.isActive)) return true;
  if (item.addonSlots.isNotEmpty) return true;

  final slotted = item.addonSlots.map((s) => s.addonType).toSet();
  const globalTypes = ['milk_type', 'coffee_type', 'extra'];
  for (final t in globalTypes) {
    if (!slotted.contains(t) &&
        (addonsByType[t] ?? []).any((a) => a.isActive)) {
      return true;
    }
  }
  return false;
}

MenuItem? _menuItemById(List<MenuItem> items, String id) {
  for (final m in items) {
    if (m.id == id) return m;
  }
  return null;
}

/// Captured configuration per component index. autoDispose.family keyed by
/// bundle id: state resets when the sheet closes and stacked sheets for
/// different bundles never share it.
final _bundleConfigsProvider = NotifierProvider.autoDispose.family<
    _BundleConfigsNotifier,
    Map<int, ItemLineConfiguration>,
    String>(_BundleConfigsNotifier.new);

class _BundleConfigsNotifier extends AutoDisposeFamilyNotifier<
    Map<int, ItemLineConfiguration>, String> {
  @override
  Map<int, ItemLineConfiguration> build(String arg) => const {};

  void setConfig(int index, ItemLineConfiguration config) =>
      state = {...state, index: config};
}

// ─────────────────────────────────────────────────────────────────────────────
//  BUNDLE DETAIL SHEET — configure each component, then add one bundle line
// ─────────────────────────────────────────────────────────────────────────────
class BundleDetailSheet extends ConsumerStatefulWidget {
  final Bundle bundle;
  final List<MenuItem> menuItems;

  const BundleDetailSheet({
    super.key,
    required this.bundle,
    required this.menuItems,
  });

  static Future<void> show(
    BuildContext context, {
    required Bundle bundle,
    required List<MenuItem> menuItems,
  }) =>
      ResponsiveSheet.show(
        context: context,
        builder: (_) => BundleDetailSheet(
          bundle: bundle,
          menuItems: menuItems,
        ),
      );

  /// Legacy entry point kept for callers (e.g. bundle_card) — now opens the
  /// bundle sheet, which drives per-component configuration internally.
  static Future<void> configureAndAdd(
    BuildContext context,
    WidgetRef ref, {
    required Bundle bundle,
    required List<MenuItem> menuItems,
  }) =>
      show(context, bundle: bundle, menuItems: menuItems);

  @override
  ConsumerState<BundleDetailSheet> createState() => _BundleDetailSheetState();
}

class _BundleDetailSheetState extends ConsumerState<BundleDetailSheet> {
  late final List<BundleComponent> _sorted;
  late final List<MenuItem?> _items;
  late final List<bool> _needsConfig;

  String get _configKey => widget.bundle.id;

  Map<int, ItemLineConfiguration> get _configs =>
      ref.read(_bundleConfigsProvider(_configKey));

  @override
  void initState() {
    super.initState();
    final addonsByType = ref.read(menuProvider).addonsByType;
    _sorted = List<BundleComponent>.of(widget.bundle.components)
      ..sort((a, b) => a.position.compareTo(b.position));
    _items = _sorted
        .map((c) => _menuItemById(widget.menuItems, c.itemId))
        .toList();
    _needsConfig = List.generate(_sorted.length, (i) {
      final item = _items[i];
      return item != null && componentNeedsConfiguration(item, addonsByType);
    });
  }

  int get _configurableCount => _needsConfig.where((n) => n).length;

  int _configuredCount(Map<int, ItemLineConfiguration> configs) =>
      configs.keys.where((i) => _needsConfig[i]).length;

  int? _nextUnconfigured(Map<int, ItemLineConfiguration> configs) {
    for (var i = 0; i < _sorted.length; i++) {
      if (_needsConfig[i] && !configs.containsKey(i)) return i;
    }
    return null;
  }

  /// Component addon/optional extras are charged on top of the bundle price
  /// (mirrors CartItem.lineTotal for bundle lines).
  int _extrasTotal(Map<int, ItemLineConfiguration> configs) {
    var sum = 0;
    for (final c in configs.values) {
      sum += c.addons.fold(0, (s, a) => s + a.priceModifier * a.quantity);
      sum += c.optionals.fold(0, (s, o) => s + o.price);
    }
    return sum;
  }

  Future<void> _configure(int index) async {
    final item = _items[index];
    if (item == null) return;

    final config = await ItemDetailSheet.showForConfiguration(
      context,
      item: item,
      title:
          '${normaliseName(item.name)} (${normaliseName(widget.bundle.name)})',
      initial: _configs[index],
    );
    if (config == null || !mounted) return;
    ref
        .read(_bundleConfigsProvider(_configKey).notifier)
        .setConfig(index, config);
  }

  /// Builds the snapshots exactly like the previous configureAndAdd flow and
  /// adds one bundle cart line.
  void _addToCart() {
    final configs = _configs;
    final snapshots = <BundleComponentSnapshot>[];

    for (var i = 0; i < _sorted.length; i++) {
      final comp = _sorted[i];
      final item = _items[i];
      if (item == null) {
        snapshots.add(BundleComponentSnapshot(
          itemId: comp.itemId,
          itemName: l10n(context).orderItemFallback,
          quantity: comp.quantity,
        ));
        continue;
      }

      final defaultSize =
          item.sizes.isNotEmpty ? item.sizes.first.label : null;
      final config = configs[i];

      if (config != null) {
        snapshots.add(BundleComponentSnapshot(
          itemId: comp.itemId,
          itemName: item.name,
          quantity: comp.quantity,
          sizeLabel: config.sizeLabel ?? defaultSize,
          addons: config.addons,
          optionals: config.optionals,
        ));
      } else {
        snapshots.add(BundleComponentSnapshot(
          itemId: comp.itemId,
          itemName: item.name,
          quantity: comp.quantity,
          sizeLabel: defaultSize,
        ));
      }
    }

    ref.read(cartProvider.notifier).addBundle(widget.bundle, snapshots);
    Navigator.pop(context);
  }

  String _configSummary(ItemLineConfiguration c) {
    final parts = <String>[
      if (c.sizeLabel != null) normaliseName(c.sizeLabel!),
      ...c.addons.map((a) => a.quantity > 1
          ? '${a.quantity}× ${normaliseName(a.name)}'
          : normaliseName(a.name)),
      ...c.optionals.map((o) => normaliseName(o.name)),
    ];
    return parts.isEmpty
        ? l10n(context).orderDefaultOptions
        : parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    final mq = MediaQuery.of(context);
    final hPad = context.responsive(phone: AppSpace.lg, tablet: AppSpace.xl);
    final bundle = widget.bundle;
    final configs = ref.watch(_bundleConfigsProvider(_configKey));
    final savings = bundle.savingsVsComponents(widget.menuItems);
    final total = bundle.price + _extrasTotal(configs);
    final configuredCount = _configuredCount(configs);
    final allConfigured = configuredCount >= _configurableCount;
    final next = _nextUnconfigured(configs);

    return Container(
      constraints: BoxConstraints(maxHeight: mq.size.height * 0.90),
      decoration: BoxDecoration(
          color: t.surfaceRaised, borderRadius: AppRadius.sheetRadius),
      clipBehavior: Clip.antiAlias,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const _DragHandle(),

        // ── Header: name · combo chip · price · progress ──────────────────
        Container(
          padding: EdgeInsetsDirectional.fromSTEB(
              hPad, AppSpace.xs, hPad, AppSpace.md),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: t.border))),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Flexible(
                              child: Text(normaliseName(bundle.name),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                            ),
                            const SizedBox(width: AppSpace.sm),
                            StatusChip(
                                label: s.orderCombo,
                                icon: Icons.layers_outlined,
                                tone: ChipTone.info),
                          ]),
                          if (bundle.description != null &&
                              bundle.description!.isNotEmpty) ...[
                            const SizedBox(height: AppSpace.xs),
                            Text(bundle.description!,
                                style: ui(
                                    size: 12.5,
                                    color: t.textSecondary,
                                    height: 1.4)),
                          ],
                        ]),
                  ),
                  const SizedBox(width: AppSpace.md),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                              color: t.navyBg,
                              borderRadius:
                                  BorderRadius.circular(AppRadius.sm)),
                          child: Text(egp(bundle.price),
                              style: money(
                                  size: 14,
                                  weight: FontWeight.w700,
                                  color: t.navy)),
                        ),
                        if (savings > 0) ...[
                          const SizedBox(height: AppSpace.xs),
                          StatusChip(
                              label: s.orderComboSave(egp(savings)),
                              tone: ChipTone.success),
                        ],
                      ]),
                ]),
                if (_configurableCount > 0) ...[
                  const SizedBox(height: AppSpace.md),
                  Row(children: [
                    Expanded(
                      child: Text(
                          s.orderConfiguredProgress(
                              configuredCount, _configurableCount),
                          style: ui(
                              size: 12,
                              weight: FontWeight.w600,
                              color: t.textSecondary)),
                    ),
                    if (allConfigured)
                      StatusChip(
                          label: s.orderReady,
                          icon: Icons.check_rounded,
                          tone: ChipTone.success),
                  ]),
                  const SizedBox(height: AppSpace.sm),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    child: LinearProgressIndicator(
                      value: _configurableCount == 0
                          ? 1
                          : configuredCount / _configurableCount,
                      minHeight: 5,
                      backgroundColor: t.borderLight,
                      color: allConfigured ? t.success : t.accent,
                    ),
                  ),
                ],
              ]),
        ),

        // ── Components ─────────────────────────────────────────────────────
        Flexible(
          child: SingleChildScrollView(
            padding: EdgeInsetsDirectional.fromSTEB(
                hPad, AppSpace.lg, hPad, AppSpace.sm),
            child: Column(children: [
              for (var i = 0; i < _sorted.length; i++) ...[
                _ComponentTile(
                  component: _sorted[i],
                  item: _items[i],
                  needsConfig: _needsConfig[i],
                  config: configs[i],
                  summary:
                      configs[i] != null ? _configSummary(configs[i]!) : null,
                  onTap: _needsConfig[i] ? () => _configure(i) : null,
                ),
                const SizedBox(height: AppSpace.md),
              ],
            ]),
          ),
        ),

        // ── Sticky footer: total · add ─────────────────────────────────────
        Container(
          decoration: BoxDecoration(
              color: t.surfaceRaised,
              border: Border(top: BorderSide(color: t.border))),
          padding: EdgeInsetsDirectional.fromSTEB(
              hPad, AppSpace.md, hPad, AppSpace.md),
          child: SafeArea(
            top: false,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(children: [
                Text(s.orderTotal,
                    style: ui(
                        size: 13,
                        weight: FontWeight.w600,
                        color: t.textSecondary)),
                const Spacer(),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  transitionBuilder: (child, anim) =>
                      FadeTransition(opacity: anim, child: child),
                  child: Text(egp(total),
                      key: ValueKey(total),
                      style: money(
                          size: 20,
                          weight: FontWeight.w800,
                          color: t.textPrimary)),
                ),
              ]),
              const SizedBox(height: AppSpace.md),
              AppButton(
                width: double.infinity,
                height: 50,
                label: allConfigured
                    ? s.orderAddToCart
                    : (next != null
                        ? s.orderConfigureItem(
                            normaliseName(_items[next]?.name ?? ''))
                        : s.orderConfigureItems),
                onTap: allConfigured
                    ? _addToCart
                    : (next != null ? () => _configure(next) : null),
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  COMPONENT TILE
// ─────────────────────────────────────────────────────────────────────────────
class _ComponentTile extends StatelessWidget {
  final BundleComponent component;
  final MenuItem? item;
  final bool needsConfig;
  final ItemLineConfiguration? config;
  final String? summary;
  final VoidCallback? onTap;

  const _ComponentTile({
    required this.component,
    required this.item,
    required this.needsConfig,
    required this.config,
    required this.summary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    final missing = item == null;
    final configured = config != null;
    final ready = !needsConfig || configured;

    final (IconData stateIcon, Color stateColor) = missing
        ? (Icons.error_outline_rounded, t.danger)
        : ready
            ? (Icons.check_circle_rounded, t.success)
            : (Icons.tune_rounded, t.accent);

    final String statusLine = missing
        ? s.orderItemUnavailable
        : configured
            ? summary!
            : needsConfig
                ? s.orderTapToChooseOptions
                : s.orderNoOptionsToConfigure;

    final extras = config == null
        ? 0
        : config!.addons
                .fold<int>(0, (s, a) => s + a.priceModifier * a.quantity) +
            config!.optionals.fold<int>(0, (s, o) => s + o.price);

    return SurfaceCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpace.md),
      child: Row(children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              color: t.surfaceAlt,
              borderRadius: BorderRadius.circular(AppRadius.xs)),
          child: Icon(stateIcon, size: 19, color: stateColor),
        ),
        const SizedBox(width: AppSpace.md),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Flexible(
                    child: Text(
                        missing
                            ? s.orderItemFallback
                            : normaliseName(item!.name),
                        style: ui(
                            size: 14,
                            weight: FontWeight.w600,
                            color: t.textPrimary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                  if (component.quantity > 1) ...[
                    const SizedBox(width: AppSpace.xs),
                    Text('×${component.quantity}',
                        style: ui(
                            size: 12,
                            weight: FontWeight.w700,
                            color: t.textMuted)),
                  ],
                ]),
                const SizedBox(height: 2),
                Row(children: [
                  Flexible(
                    child: Text(statusLine,
                        style: ui(
                            size: 12,
                            color: missing
                                ? t.danger
                                : configured
                                    ? t.textSecondary
                                    : needsConfig
                                        ? t.accent
                                        : t.textMuted),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                  ),
                  if (extras > 0) ...[
                    const SizedBox(width: AppSpace.xs),
                    Text('+${egp(extras)}',
                        style: money(
                            size: 12,
                            weight: FontWeight.w700,
                            color: t.accent)),
                  ],
                ]),
              ]),
        ),
        if (needsConfig && !missing) ...[
          const SizedBox(width: AppSpace.sm),
          StatusChip(
            label: configured ? s.commonEdit : s.orderConfigure,
            tone: configured ? ChipTone.neutral : ChipTone.accent,
            onTap: onTap,
          ),
        ],
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  DRAG HANDLE
// ─────────────────────────────────────────────────────────────────────────────
class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            const EdgeInsets.only(top: AppSpace.md, bottom: AppSpace.sm),
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
