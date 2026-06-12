import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/recipe_api.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/responsive_sheet.dart';
import '../../../shared/widgets/status_chip.dart';

/// Holds the in-flight recipe future (seeded on open, replaced on retry).
/// autoDispose.family keyed by item+size so the sheet resets per open and
/// never shares state with another configured drink.
final _recipeFutureProvider = NotifierProvider.autoDispose.family<
    _RecipeFutureNotifier,
    Future<List<RecipeIngredient>>?,
    String>(_RecipeFutureNotifier.new);

class _RecipeFutureNotifier extends AutoDisposeFamilyNotifier<
    Future<List<RecipeIngredient>>?, String> {
  @override
  Future<List<RecipeIngredient>>? build(String arg) => null;

  void set(Future<List<RecipeIngredient>> future) => state = future;
}

// ─────────────────────────────────────────────────────────────────────────────
//  RECIPE SHEET — ingredient composition preview for the configured drink
// ─────────────────────────────────────────────────────────────────────────────
class RecipeSheet extends ConsumerStatefulWidget {
  final String itemName;
  final String? sizeLabel;
  final Future<List<RecipeIngredient>> Function() fetchRecipe;

  /// Pre-fetched data (e.g. the recipe button already loaded it) — shown
  /// instantly. Retry still goes through [fetchRecipe].
  final List<RecipeIngredient>? initialData;

  const RecipeSheet({
    super.key,
    required this.itemName,
    required this.sizeLabel,
    required this.fetchRecipe,
    this.initialData,
  });

  static Future<void> show(
    BuildContext context, {
    required String itemName,
    String? sizeLabel,
    required Future<List<RecipeIngredient>> Function() fetchRecipe,
    List<RecipeIngredient>? initialData,
  }) =>
      ResponsiveSheet.show(
        context: context,
        builder: (_) => RecipeSheet(
          itemName: itemName,
          sizeLabel: sizeLabel,
          fetchRecipe: fetchRecipe,
          initialData: initialData,
        ),
      );

  @override
  ConsumerState<RecipeSheet> createState() => _RecipeSheetState();
}

class _RecipeSheetState extends ConsumerState<RecipeSheet> {
  String get _key => '${widget.itemName}|${widget.sizeLabel ?? ''}';

  @override
  void initState() {
    super.initState();
    // Riverpod forbids provider mutations inside widget lifecycles — seed
    // after the first frame (which renders the skeleton from the null
    // default, so the one-frame gap is invisible behind the sheet animation).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(_recipeFutureProvider(_key).notifier).set(
          widget.initialData != null
              ? Future.value(widget.initialData)
              : widget.fetchRecipe());
    });
  }

  void _retry() {
    ref.read(_recipeFutureProvider(_key).notifier).set(widget.fetchRecipe());
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final future = ref.watch(_recipeFutureProvider(_key));
    final maxH = MediaQuery.of(context).size.height * 0.75;

    return Container(
      constraints: BoxConstraints(maxHeight: maxH),
      decoration: BoxDecoration(
        color: t.surfaceRaised,
        borderRadius: AppRadius.sheetRadius,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _DragHandle(),

          // ── Header ──────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpace.lg, 0, AppSpace.lg, AppSpace.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration:
                      BoxDecoration(color: t.navyBg, shape: BoxShape.circle),
                  child: Icon(Icons.science_rounded, size: 16, color: t.navy),
                ),
                const SizedBox(width: AppSpace.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.itemName,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (widget.sizeLabel != null)
                        Text(
                          l10n(context).orderRecipeSizeLabel(
                              normaliseName(widget.sizeLabel!)),
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

          // ── Dynamic body ────────────────────────────────────────────────
          Flexible(
            child: FutureBuilder<List<RecipeIngredient>>(
              future: future,
              builder: (context, snapshot) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  child: _buildStateContent(snapshot),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateContent(AsyncSnapshot<List<RecipeIngredient>> snapshot) {
    // `none` only occurs in the (theoretically impossible) frame before the
    // initState seed lands — treat it as loading rather than empty.
    if (snapshot.connectionState == ConnectionState.waiting ||
        snapshot.connectionState == ConnectionState.none) {
      return ListView.builder(
        key: const ValueKey('loading'),
        padding: const EdgeInsets.all(AppSpace.lg),
        itemCount: 4,
        itemBuilder: (_, __) => const _RecipeRowSkeleton(),
      );
    }

    if (snapshot.hasError) {
      return SingleChildScrollView(
        key: const ValueKey('error'),
        child: ErrorState(
          message: l10n(context).orderRecipeLoadError,
          onRetry: _retry,
        ),
      );
    }

    final result = snapshot.data;
    if (result == null || result.isEmpty) {
      return SingleChildScrollView(
        key: const ValueKey('empty'),
        child: EmptyState(
          icon: Icons.science_outlined,
          title: l10n(context).orderNoIngredients,
          body: l10n(context).orderNoRecipeYet,
        ),
      );
    }

    return ListView.separated(
      key: const ValueKey('data'),
      padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpace.lg, AppSpace.lg, AppSpace.lg, AppSpace.xxl),
      itemCount: result.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpace.sm),
      itemBuilder: (_, i) => _RecipeIngredientRow(ingredient: result[i]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  INGREDIENT ROW
// ─────────────────────────────────────────────────────────────────────────────
class _RecipeIngredientRow extends StatelessWidget {
  final RecipeIngredient ingredient;

  const _RecipeIngredientRow({required this.ingredient});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final isBase = ingredient.isBase;

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
            width: 54,
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
                  ingredient.quantity % 1 == 0
                      ? ingredient.quantity.toInt().toString()
                      : ingredient.quantity.toStringAsFixed(1),
                  style: ui(
                      size: 14,
                      weight: FontWeight.w700,
                      color: t.textPrimary,
                      height: 1.1),
                ),
                Text(
                  ingredient.unit,
                  style: ui(
                      size: 10, weight: FontWeight.w600, color: t.textMuted),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpace.md),
          Expanded(
            child: Text(
              ingredient.name,
              style: ui(
                  size: 14,
                  weight: isBase ? FontWeight.w700 : FontWeight.w600,
                  color: t.textPrimary),
            ),
          ),
          const SizedBox(width: AppSpace.sm),
          StatusChip(
            label: ingredient.sourceLabel.toUpperCase(),
            tone: isBase ? ChipTone.info : ChipTone.neutral,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SKELETON LOADER
// ─────────────────────────────────────────────────────────────────────────────
class _RecipeRowSkeleton extends StatefulWidget {
  const _RecipeRowSkeleton();

  @override
  State<_RecipeRowSkeleton> createState() => _RecipeRowSkeletonState();
}

class _RecipeRowSkeletonState extends State<_RecipeRowSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        final c = Color.lerp(t.surfaceAlt, t.borderLight, _anim.value)!;
        return Container(
          margin: const EdgeInsets.only(bottom: AppSpace.sm),
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.md, vertical: AppSpace.md),
          decoration: BoxDecoration(
            color: t.surface,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: t.borderLight),
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 40,
                decoration: BoxDecoration(
                  color: c,
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                ),
              ),
              const SizedBox(width: AppSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 120, height: 14, color: c),
                    const SizedBox(height: AppSpace.sm),
                    Container(width: 60, height: 10, color: c),
                  ],
                ),
              ),
              Container(
                width: 48,
                height: 20,
                decoration: BoxDecoration(
                  color: c,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
            ],
          ),
        );
      },
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
