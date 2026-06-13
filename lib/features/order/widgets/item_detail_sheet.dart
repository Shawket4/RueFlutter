import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/recipe_api.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/models/cart.dart';
import '../../../core/models/menu.dart';
import '../../../core/providers/cart_notifier.dart';
import '../../../core/providers/menu_notifier.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/responsive_sheet.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/status_chip.dart';
import '../helpers/payment_helpers.dart';
import 'addon_card.dart';
import 'optional_fields_card.dart';
import 'recipe_sheet.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  SHEET-LOCAL CONFIG STATE
//  autoDispose.family keyed by menu item id: stacked sheets for different
//  items never share state, and closing the sheet disposes (resets) it —
//  the same lifecycle the old State fields had.
// ─────────────────────────────────────────────────────────────────────────────

@immutable
class _ItemConfigState {
  final String? selectedSize;
  final int qty;

  /// slotId → addonId (single-select slots).
  final Map<String, String> single;

  /// slotId → addonId → qty (multi-select slots).
  final Map<String, Map<String, int>> multi;

  /// addonType → addonId → qty (unslotted multi types).
  final Map<String, Map<String, int>> extras;

  /// addonType → addonId (unslotted single-select types, e.g. milk).
  final Map<String, String> extrasSingle;

  final Set<String> selectedOptionals;

  final bool recipeLoading;
  final bool recipeError;

  const _ItemConfigState({
    this.selectedSize,
    this.qty = 1,
    this.single = const {},
    this.multi = const {},
    this.extras = const {},
    this.extrasSingle = const {},
    this.selectedOptionals = const {},
    this.recipeLoading = false,
    this.recipeError = false,
  });

  _ItemConfigState copyWith({
    String? selectedSize,
    int? qty,
    Map<String, String>? single,
    Map<String, Map<String, int>>? multi,
    Map<String, Map<String, int>>? extras,
    Map<String, String>? extrasSingle,
    Set<String>? selectedOptionals,
    bool? recipeLoading,
    bool? recipeError,
  }) =>
      _ItemConfigState(
        selectedSize: selectedSize ?? this.selectedSize,
        qty: qty ?? this.qty,
        single: single ?? this.single,
        multi: multi ?? this.multi,
        extras: extras ?? this.extras,
        extrasSingle: extrasSingle ?? this.extrasSingle,
        selectedOptionals: selectedOptionals ?? this.selectedOptionals,
        recipeLoading: recipeLoading ?? this.recipeLoading,
        recipeError: recipeError ?? this.recipeError,
      );
}

class _ItemConfigNotifier
    extends AutoDisposeFamilyNotifier<_ItemConfigState, String> {
  @override
  _ItemConfigState build(String arg) => const _ItemConfigState();

  /// Initial selections (default size, edited cart line, bundle config) are
  /// computed by the sheet's initState — exactly the old init logic — and
  /// installed here in one shot.
  void seed(_ItemConfigState initial) => state = initial;

  void selectSize(String label) => state = state.copyWith(selectedSize: label);

  void setQty(int qty) => state = state.copyWith(qty: qty.clamp(1, 99));

  void toggleSingle(String slotId, String addonId, bool required) {
    final single = Map<String, String>.of(state.single);
    if (single[slotId] == addonId) {
      if (required) return;
      single.remove(slotId);
    } else {
      single[slotId] = addonId;
    }
    state = state.copyWith(single: single);
  }

  void toggleMulti(String slotId, String addonId, int? maxSel) {
    final multi = _copyNested(state.multi);
    final m = multi.putIfAbsent(slotId, () => {});
    if (m.containsKey(addonId)) {
      m.remove(addonId);
      if (m.isEmpty) multi.remove(slotId);
    } else {
      if (maxSel != null && m.length >= maxSel) return;
      m[addonId] = 1;
    }
    state = state.copyWith(multi: multi);
  }

  void incrementMulti(String slotId, String addonId) {
    final multi = _copyNested(state.multi);
    multi.putIfAbsent(slotId, () => {})[addonId] =
        (multi[slotId]![addonId] ?? 1) + 1;
    state = state.copyWith(multi: multi);
  }

  void decrementMulti(String slotId, String addonId) {
    final multi = _copyNested(state.multi);
    final m = multi[slotId];
    if (m == null) return;
    final cur = m[addonId] ?? 1;
    if (cur <= 1) {
      m.remove(addonId);
      if (m.isEmpty) multi.remove(slotId);
    } else {
      m[addonId] = cur - 1;
    }
    state = state.copyWith(multi: multi);
  }

  void toggleExtraSingle(String addonType, String addonId) {
    final extrasSingle = Map<String, String>.of(state.extrasSingle);
    if (extrasSingle[addonType] == addonId) {
      extrasSingle.remove(addonType);
    } else {
      extrasSingle[addonType] = addonId;
    }
    state = state.copyWith(extrasSingle: extrasSingle);
  }

  void toggleExtra(String addonType, String addonId) {
    final extras = _copyNested(state.extras);
    final typeMap = extras.putIfAbsent(addonType, () => {});
    if (typeMap.containsKey(addonId)) {
      typeMap.remove(addonId);
      if (typeMap.isEmpty) extras.remove(addonType);
    } else {
      typeMap[addonId] = 1;
    }
    state = state.copyWith(extras: extras);
  }

  void incrementExtra(String addonType, String addonId) {
    final extras = _copyNested(state.extras);
    final typeMap = extras.putIfAbsent(addonType, () => {});
    typeMap[addonId] = (typeMap[addonId] ?? 1) + 1;
    state = state.copyWith(extras: extras);
  }

  void decrementExtra(String addonType, String addonId) {
    final extras = _copyNested(state.extras);
    final typeMap = extras[addonType];
    if (typeMap == null) return;
    final cur = typeMap[addonId] ?? 1;
    if (cur <= 1) {
      typeMap.remove(addonId);
      if (typeMap.isEmpty) extras.remove(addonType);
    } else {
      typeMap[addonId] = cur - 1;
    }
    state = state.copyWith(extras: extras);
  }

  void toggleOptional(String id) {
    final selected = Set<String>.of(state.selectedOptionals);
    if (!selected.remove(id)) selected.add(id);
    state = state.copyWith(selectedOptionals: selected);
  }

  void recipeStarted() =>
      state = state.copyWith(recipeLoading: true, recipeError: false);

  void recipeFailed() =>
      state = state.copyWith(recipeLoading: false, recipeError: true);

  void recipeLoaded() => state = state.copyWith(recipeLoading: false);

  static Map<String, Map<String, int>> _copyNested(
          Map<String, Map<String, int>> src) =>
      {for (final e in src.entries) e.key: Map<String, int>.of(e.value)};
}

final _itemConfigProvider = NotifierProvider.autoDispose
    .family<_ItemConfigNotifier, _ItemConfigState, String>(
        _ItemConfigNotifier.new);

class ItemDetailSheet extends ConsumerStatefulWidget {
  final MenuItem item;
  final int? editIndex;
  final CartItem? existingItem;
  final bool configureOnly;
  final String? configureTitle;
  final ItemLineConfiguration? initialConfig;

  const ItemDetailSheet({
    super.key,
    required this.item,
    this.editIndex,
    this.existingItem,
    this.configureOnly = false,
    this.configureTitle,
    this.initialConfig,
  });

  static Future<void> show(BuildContext ctx, MenuItem item,
          {int? editIndex, CartItem? existingItem}) =>
      ResponsiveSheet.show(
          context: ctx,
          builder: (_) => ItemDetailSheet(
              item: item, editIndex: editIndex, existingItem: existingItem));

  /// Collects size/addon/optional choices for a bundle component (same UI as a normal item).
  static Future<ItemLineConfiguration?> showForConfiguration(
    BuildContext ctx, {
    required MenuItem item,
    String? title,
    ItemLineConfiguration? initial,
  }) =>
      ResponsiveSheet.show<ItemLineConfiguration?>(
        context: ctx,
        builder: (_) => ItemDetailSheet(
          item: item,
          configureOnly: true,
          configureTitle: title,
          initialConfig: initial,
        ),
      );

  @override
  ConsumerState<ItemDetailSheet> createState() => _ItemDetailSheetState();
}

class _ItemDetailSheetState extends ConsumerState<ItemDetailSheet> {
  /// Base price of the default milk/coffee swap — fixed per item, so it stays
  /// out of the provider.
  final Map<String, int> _baseSwapPrices = {};

  static const _singleSelectTypes = {'milk_type'};

  late List<OptionalField> _optionalFields;

  bool get _isEdit =>
      !widget.configureOnly &&
      widget.editIndex != null &&
      widget.existingItem != null;

  String get _configKey => widget.item.id;

  _ItemConfigNotifier get _config =>
      ref.read(_itemConfigProvider(_configKey).notifier);

  @override
  void initState() {
    super.initState();
    _optionalFields =
        widget.item.optionalFields.where((f) => f.isActive).toList();

    // Build the initial selections exactly like the old initState did, then
    // seed the sheet-local provider in one shot.
    String? selectedSize;
    var qty = 1;
    final single = <String, String>{};
    final multi = <String, Map<String, int>>{};
    final extras = <String, Map<String, int>>{};
    final extrasSingle = <String, String>{};
    final selectedOptionals = <String>{};

    if (widget.item.sizes.isNotEmpty) {
      selectedSize = widget.item.sizes.first.label;
    }

    _initBaseMilk(extrasSingle);

    final initial = widget.initialConfig;
    if (initial != null) {
      selectedSize = initial.sizeLabel ?? selectedSize;
      for (final o in initial.optionals) {
        selectedOptionals.add(o.optionalFieldId);
      }
      final allAddons = ref.read(menuProvider).allAddons;
      for (final sa in initial.addons) {
        final addon = allAddons.where((a) => a.id == sa.addonItemId);
        if (addon.isEmpty) continue;
        final addonType = addon.first.addonType;
        final matchingSlot =
            widget.item.addonSlots.where((s) => s.addonType == addonType);
        if (matchingSlot.isNotEmpty) {
          final slot = matchingSlot.first;
          final isMulti = (slot.maxSelections ?? 2) > 1;
          if (isMulti) {
            multi.putIfAbsent(slot.id, () => {})[sa.addonItemId] = sa.quantity;
          } else {
            single[slot.id] = sa.addonItemId;
          }
        } else {
          if (_singleSelectTypes.contains(addonType)) {
            extrasSingle[addonType] = sa.addonItemId;
          } else {
            extras.putIfAbsent(addonType, () => {})[sa.addonItemId] =
                sa.quantity;
          }
        }
      }
    }

    if (_isEdit) {
      final existing = widget.existingItem!;
      selectedSize = existing.sizeLabel;
      qty = existing.quantity;

      final allAddons = ref.read(menuProvider).allAddons;
      final slottedTypes =
          widget.item.addonSlots.map((s) => s.addonType).toSet();
      for (final so in existing.optionals) {
        selectedOptionals.add(so.optionalFieldId);
      }

      for (final sa in existing.addons) {
        final addon = allAddons.where((a) => a.id == sa.addonItemId);
        if (addon.isEmpty) continue;
        final addonType = addon.first.addonType;

        final matchingSlot =
            widget.item.addonSlots.where((s) => s.addonType == addonType);

        if (matchingSlot.isNotEmpty) {
          final slot = matchingSlot.first;
          final isMulti = (slot.maxSelections ?? 2) > 1;
          if (isMulti) {
            multi.putIfAbsent(slot.id, () => {})[sa.addonItemId] = sa.quantity;
          } else {
            single[slot.id] = sa.addonItemId;
          }
        } else if (!slottedTypes.contains(addonType)) {
          if (_singleSelectTypes.contains(addonType)) {
            extrasSingle[addonType] = sa.addonItemId;
          } else {
            extras.putIfAbsent(addonType, () => {})[sa.addonItemId] =
                sa.quantity;
          }
        }
      }
    }

    // Riverpod forbids provider mutations inside widget lifecycles — seed
    // after the first frame. The default (empty) config renders for exactly
    // one frame behind the sheet-opening animation.
    final seeded = _ItemConfigState(
      selectedSize: selectedSize,
      qty: qty,
      single: single,
      multi: multi,
      extras: extras,
      extrasSingle: extrasSingle,
      selectedOptionals: selectedOptionals,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _config.seed(seeded);
    });
  }

  int _unitPrice(_ItemConfigState c) =>
      widget.item.priceForSize(c.selectedSize);

  int _optionalsTotal(_ItemConfigState c) => _optionalFields
      .where((f) => c.selectedOptionals.contains(f.id))
      .fold(0, (s, f) => s + f.price);

  int _adjustedPrice(AddonItem a) {
    if (a.addonType == 'milk_type' || a.addonType == 'coffee_type') {
      final base = _baseSwapPrices[a.addonType] ?? 0;
      final diff = a.defaultPrice - base;
      return diff > 0 ? diff : 0;
    }
    return a.defaultPrice;
  }

  int _addonsTotal(_ItemConfigState c) {
    final allAddons = ref.read(menuProvider).allAddons;
    int t = 0;

    for (final aId in c.single.values) {
      final matches = allAddons.where((a) => a.id == aId);
      if (matches.isNotEmpty) t += _adjustedPrice(matches.first);
    }
    for (final qtyMap in c.multi.values) {
      for (final entry in qtyMap.entries) {
        final matches = allAddons.where((a) => a.id == entry.key);
        if (matches.isNotEmpty) {
          t += _adjustedPrice(matches.first) * entry.value;
        }
      }
    }
    for (final typeMap in c.extras.values) {
      for (final entry in typeMap.entries) {
        final matches = allAddons.where((a) => a.id == entry.key);
        if (matches.isNotEmpty) {
          t += _adjustedPrice(matches.first) * entry.value;
        }
      }
    }
    for (final aId in c.extrasSingle.values) {
      final matches = allAddons.where((a) => a.id == aId);
      if (matches.isNotEmpty) t += _adjustedPrice(matches.first);
    }
    return t;
  }

  String? _firstUnsatisfiedSlot(_ItemConfigState c) {
    for (final s in widget.item.addonSlots) {
      if (!s.isRequired) continue;
      final min = s.minSelections.clamp(1, 999);
      final isMulti = (s.maxSelections ?? 2) > 1;
      final count = isMulti
          ? (c.multi[s.id]?.length ?? 0)
          : (c.single.containsKey(s.id) ? 1 : 0);
      if (count < min) return s.displayName;
    }
    return null;
  }

  Future<List<RecipeIngredient>> _fetchRecipe() {
    final c = ref.read(_itemConfigProvider(_configKey));
    return ref.read(recipeApiProvider).preview(
          menuItemId: widget.item.id,
          sizeLabel: c.selectedSize,
          addons: _buildSelectedAddons(c),
          optionals: _buildSelectedOptionals(c),
          menuItem: widget.item,
          allAddonItems: ref.read(menuProvider).allAddons,
        );
  }

  /// Pre-fetches the recipe (real loading state on the button), then opens
  /// the recipe sheet. On failure the button flips to a retry affordance.
  Future<void> _showRecipeSheet() async {
    if (ref.read(_itemConfigProvider(_configKey)).recipeLoading) return;
    _config.recipeStarted();

    List<RecipeIngredient> data;
    try {
      data = await _fetchRecipe();
    } catch (_) {
      if (!mounted) return;
      _config.recipeFailed();
      return;
    }

    if (!mounted) return;
    _config.recipeLoaded();

    RecipeSheet.show(
      context,
      itemName: normaliseName(widget.item.name),
      sizeLabel: ref.read(_itemConfigProvider(_configKey)).selectedSize,
      initialData: data,
      fetchRecipe: _fetchRecipe,
    );
  }

  void _initBaseMilk(Map<String, String> extrasSingle) {
    final defaultId = widget.item.defaultMilkAddonId;
    if (defaultId == null) return;

    final allAddons = ref.read(menuProvider).allAddons;
    final defaultMilkAddon =
        allAddons.where((a) => a.id == defaultId).firstOrNull;

    if (defaultMilkAddon != null) {
      _baseSwapPrices['milk_type'] = defaultMilkAddon.defaultPrice;
      if (!_isEdit && extrasSingle['milk_type'] == null) {
        extrasSingle['milk_type'] = defaultMilkAddon.id;
      }
    }
  }

  List<SelectedOptional> _buildSelectedOptionals(_ItemConfigState c) {
    return _optionalFields
        .where((f) => c.selectedOptionals.contains(f.id))
        .map((f) => SelectedOptional(
              optionalFieldId: f.id,
              name: f.name,
              price: f.price,
            ))
        .toList();
  }

  List<SelectedAddon> _buildSelectedAddons(_ItemConfigState c) {
    final allAddons = ref.read(menuProvider).allAddons;
    final result = <SelectedAddon>[];

    AddonItem? findAddon(String id) {
      final matches = allAddons.where((a) => a.id == id);
      return matches.isNotEmpty ? matches.first : null;
    }

    for (final aId in c.single.values) {
      final a = findAddon(aId);
      if (a != null) {
        result.add(SelectedAddon(
            addonItemId: a.id,
            name: a.name,
            priceModifier: _adjustedPrice(a),
            quantity: 1));
      }
    }

    for (final qtyMap in c.multi.values) {
      for (final entry in qtyMap.entries) {
        final a = findAddon(entry.key);
        if (a != null) {
          result.add(SelectedAddon(
              addonItemId: a.id,
              name: a.name,
              priceModifier: _adjustedPrice(a),
              quantity: entry.value));
        }
      }
    }

    for (final typeMap in c.extras.values) {
      for (final entry in typeMap.entries) {
        final a = findAddon(entry.key);
        if (a != null) {
          result.add(SelectedAddon(
              addonItemId: a.id,
              name: a.name,
              priceModifier: _adjustedPrice(a),
              quantity: entry.value));
        }
      }
    }

    for (final aId in c.extrasSingle.values) {
      final a = findAddon(aId);
      if (a != null) {
        result.add(SelectedAddon(
            addonItemId: a.id,
            name: a.name,
            priceModifier: _adjustedPrice(a),
            quantity: 1));
      }
    }

    return result;
  }

  void _addToCart() {
    final c = ref.read(_itemConfigProvider(_configKey));
    final addons = _buildSelectedAddons(c);
    final optionals = _buildSelectedOptionals(c);

    if (widget.configureOnly) {
      Navigator.pop(
        context,
        ItemLineConfiguration(
          sizeLabel: c.selectedSize,
          addons: addons,
          optionals: optionals,
        ),
      );
      return;
    }

    final cartItem = CartItem(
      menuItemId: widget.item.id,
      itemName: normaliseName(widget.item.name),
      sizeLabel: c.selectedSize,
      unitPrice: _unitPrice(c),
      quantity: c.qty,
      addons: addons,
      optionals: optionals,
    );

    final notifier = ref.read(cartProvider.notifier);
    if (_isEdit) {
      notifier.replaceAt(widget.editIndex!, cartItem);
    } else {
      notifier.add(cartItem);
    }
    Navigator.pop(context);
  }

  // ───────────────────────────────────────────────────────────────────────────
  //  UI
  // ───────────────────────────────────────────────────────────────────────────

  Widget _recipeChip(_ItemConfigState config) {
    final s = l10n(context);
    if (config.recipeLoading) {
      return StatusChip(
        label: s.orderRecipe,
        icon: Icons.autorenew_rounded,
        spinning: true,
        tone: ChipTone.info,
      );
    }
    if (config.recipeError) {
      return StatusChip(
        label: s.orderRecipeRetry,
        icon: Icons.refresh_rounded,
        tone: ChipTone.danger,
        onTap: _showRecipeSheet,
      );
    }
    return StatusChip(
      label: s.orderRecipe,
      icon: Icons.science_outlined,
      tone: ChipTone.info,
      onTap: _showRecipeSheet,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    final mq = MediaQuery.of(context);
    final config = ref.watch(_itemConfigProvider(_configKey));
    final byType = ref.watch(menuProvider).addonsByType;
    final hPad = context.responsive(phone: AppSpace.lg, tablet: AppSpace.xl);

    final headerTotal =
        _unitPrice(config) + _addonsTotal(config) + _optionalsTotal(config);
    final lineTotal = headerTotal * config.qty;
    final firstUnsatisfiedSlot = _firstUnsatisfiedSlot(config);
    final canAdd = firstUnsatisfiedSlot == null;

    final slottedTypes = widget.item.addonSlots.map((s) => s.addonType).toSet();

    const globalTypes = ['milk_type', 'coffee_type', 'extra'];
    final unslottedTypes = globalTypes
        .where((type) => !slottedTypes.contains(type))
        .where((type) => (byType[type] ?? []).any((a) => a.isActive))
        .toList();

    // Slots arrive in server order (the API dropped `display_order`).
    final sortedSlots = widget.item.addonSlots.toList();

    List<AddonItem> getItemsWithAdjustedPrice(String type) {
      final list = (byType[type] ?? []).where((a) => a.isActive).toList();
      if (type == 'milk_type' || type == 'coffee_type') {
        return list.map((a) => a.copyWith(defaultPrice: _adjustedPrice(a))).toList();
      }
      return list;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
      child: Container(
        constraints: BoxConstraints(maxHeight: mq.size.height * 0.90),
        decoration: BoxDecoration(
            color: t.surfaceRaised, borderRadius: AppRadius.sheetRadius),
        clipBehavior: Clip.antiAlias,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const _DragHandle(),

          // ── Header: title · recipe · live price ─────────────────────────
          Container(
            padding: EdgeInsetsDirectional.fromSTEB(
                hPad, AppSpace.xs, hPad, AppSpace.md),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: t.border))),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                        normaliseName(
                            widget.configureTitle ?? widget.item.name),
                        style: Theme.of(context).textTheme.headlineSmall),
                    if (widget.item.description != null) ...[
                      const SizedBox(height: AppSpace.xs),
                      Text(widget.item.description!,
                          style: ui(
                              size: 12.5,
                              color: t.textSecondary,
                              height: 1.4)),
                    ],
                  ])),
              const SizedBox(width: AppSpace.md),
              _recipeChip(config),
              const SizedBox(width: AppSpace.md),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, anim) => SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(0, -0.3), end: Offset.zero)
                        .animate(anim),
                    child: FadeTransition(opacity: anim, child: child)),
                child: Container(
                  key: ValueKey(headerTotal),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: t.navyBg,
                      borderRadius: BorderRadius.circular(AppRadius.sm)),
                  child: Text(egp(headerTotal),
                      style: money(
                          size: 14, weight: FontWeight.w700, color: t.navy)),
                ),
              ),
            ]),
          ),

          // ── Scrollable options ───────────────────────────────────────────
          Flexible(
              child: SingleChildScrollView(
            padding: EdgeInsetsDirectional.fromSTEB(
                hPad, AppSpace.lg, hPad, AppSpace.sm),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.item.sizes.isNotEmpty) ...[
                    SectionHeader(
                        title: s.orderSizeHeader,
                        padding: const EdgeInsetsDirectional.only(
                            bottom: AppSpace.sm)),
                    Wrap(
                        spacing: AppSpace.sm,
                        runSpacing: AppSpace.sm,
                        children: widget.item.sizes
                            .map((s) => OptionChip(
                                  label: normaliseName(s.label),
                                  sublabel: egp(s.price),
                                  selected: s.label == config.selectedSize,
                                  onTap: () => _config.selectSize(s.label),
                                ))
                            .toList()),
                    const SizedBox(height: AppSpace.lg),
                  ],

                  for (final s in sortedSlots) ...[
                    AddonCard(
                      id: s.id,
                      title: s.displayName,
                      isRequired: s.isRequired,
                      isMulti: (s.maxSelections ?? 2) > 1,
                      maxSelections: s.maxSelections,
                      items: getItemsWithAdjustedPrice(s.addonType),
                      selectedSingle: config.single[s.id],
                      selectedMulti: config.multi[s.id] ?? {},
                      onToggleSingle: (aId) =>
                          _config.toggleSingle(s.id, aId, s.isRequired),
                      onToggleMulti: (aId) =>
                          _config.toggleMulti(s.id, aId, s.maxSelections),
                      onIncrement: (aId) => _config.incrementMulti(s.id, aId),
                      onDecrement: (aId) => _config.decrementMulti(s.id, aId),
                    ),
                    const SizedBox(height: AppSpace.md),
                  ],

                  if (unslottedTypes.contains('milk_type')) ...[
                    AddonCard(
                      id: 'milk_type',
                      title: addonTypeLabel('milk_type'),
                      isRequired: false,
                      isMulti: false,
                      maxSelections: null,
                      items: getItemsWithAdjustedPrice('milk_type'),
                      selectedSingle: config.extrasSingle['milk_type'],
                      selectedMulti: const {},
                      onToggleSingle: (aId) =>
                          _config.toggleExtraSingle('milk_type', aId),
                      onToggleMulti: (_) {},
                      onIncrement: (_) {},
                      onDecrement: (_) {},
                    ),
                    const SizedBox(height: AppSpace.md),
                  ],

                  if (_optionalFields.isNotEmpty) ...[
                    OptionalFieldsCard(
                      fields: _optionalFields,
                      selected: config.selectedOptionals,
                      sizeLabel: config.selectedSize,
                      onToggle: (id) => _config.toggleOptional(id),
                    ),
                    const SizedBox(height: AppSpace.md),
                  ],

                  for (final addonType
                      in unslottedTypes.where((x) => x != 'milk_type')) ...[
                    if (_singleSelectTypes.contains(addonType))
                      AddonCard(
                        id: addonType,
                        title: addonTypeLabel(addonType),
                        isRequired: false,
                        isMulti: false,
                        maxSelections: null,
                        items: getItemsWithAdjustedPrice(addonType),
                        selectedSingle: config.extrasSingle[addonType],
                        selectedMulti: const {},
                        onToggleSingle: (aId) =>
                            _config.toggleExtraSingle(addonType, aId),
                        onToggleMulti: (_) {},
                        onIncrement: (_) {},
                        onDecrement: (_) {},
                      )
                    else
                      AddonCard(
                        id: addonType,
                        title: addonTypeLabel(addonType),
                        isRequired: false,
                        isMulti: true,
                        maxSelections: null,
                        items: getItemsWithAdjustedPrice(addonType),
                        selectedSingle: null,
                        selectedMulti: config.extras[addonType] ?? {},
                        onToggleSingle: (_) {},
                        onToggleMulti: (aId) =>
                            _config.toggleExtra(addonType, aId),
                        onIncrement: (aId) =>
                            _config.incrementExtra(addonType, aId),
                        onDecrement: (aId) =>
                            _config.decrementExtra(addonType, aId),
                      ),
                    const SizedBox(height: AppSpace.md),
                  ],

                  const SizedBox(height: AppSpace.xs),
                ]),
          )),

          // ── Sticky footer: total · qty · add ─────────────────────────────
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
                    child: Text(egp(lineTotal),
                        key: ValueKey(lineTotal),
                        style: money(
                            size: 20,
                            weight: FontWeight.w800,
                            color: t.textPrimary)),
                  ),
                ]),
                const SizedBox(height: AppSpace.md),
                if (widget.configureOnly)
                  AppButton(
                    label: canAdd
                        ? s.commonContinue
                        : s.orderSelectOptions(firstUnsatisfiedSlot),
                    height: 50,
                    width: double.infinity,
                    onTap: canAdd ? _addToCart : null,
                  )
                else
                  Row(children: [
                    _QtyStepper(
                      qty: config.qty,
                      onDecrement: () => _config.setQty(config.qty - 1),
                      onIncrement: () => _config.setQty(config.qty + 1),
                    ),
                    const SizedBox(width: AppSpace.md),
                    Expanded(
                        child: AppButton(
                      label: canAdd
                          ? (_isEdit ? s.orderUpdateItem : s.orderAddToCart)
                          : s.orderSelectOptions(firstUnsatisfiedSlot),
                      height: 50,
                      onTap: canAdd ? _addToCart : null,
                    )),
                  ]),
              ]),
            ),
          ),
        ]),
      ),
    );
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

class _QtyStepper extends StatelessWidget {
  final int qty;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _QtyStepper({
    required this.qty,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: t.surfaceAlt,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: t.border)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        _QtyBtn(icon: Icons.remove, onTap: onDecrement),
        SizedBox(
            width: 40,
            child: Center(
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 150),
                    transitionBuilder: (child, anim) =>
                        ScaleTransition(scale: anim, child: child),
                    child: Text('$qty',
                        key: ValueKey(qty),
                        style: ui(
                            size: 16,
                            weight: FontWeight.w700,
                            color: t.textPrimary))))),
        _QtyBtn(icon: Icons.add, onTap: onIncrement),
      ]),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
            width: 42,
            height: 48,
            child: Icon(icon, size: 18, color: context.tokens.textPrimary)),
      );
}
