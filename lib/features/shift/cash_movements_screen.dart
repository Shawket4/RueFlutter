import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/client.dart';
import '../../core/api/shift_api.dart';
import '../../core/l10n/l10n.dart';
import '../../core/models/cash_movement.dart';
import '../../core/providers/shift_notifier.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatting.dart';
import '../../shared/widgets/app_top_bar.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/refresh_button.dart';
import '../../shared/widgets/surface_card.dart';
import 'cash_movement_sheet.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  EPHEMERAL STATE — the open shift's cash movements (autoDispose: reset on exit)
// ─────────────────────────────────────────────────────────────────────────────

class _CashState {
  final List<CashMovement> movements;
  final bool loading;
  final String? error;
  const _CashState(
      {this.movements = const [], this.loading = true, this.error});
}

final _cashProvider = NotifierProvider.autoDispose<_CashController, _CashState>(
    _CashController.new);

class _CashController extends AutoDisposeNotifier<_CashState> {
  bool _disposed = false;

  @override
  _CashState build() {
    ref.onDispose(() => _disposed = true);
    return const _CashState();
  }

  Future<void> load(String shiftId) async {
    state = _CashState(movements: state.movements, loading: true);
    try {
      final list = await ref.read(shiftApiProvider).listCashMovements(shiftId)
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      if (!_disposed) state = _CashState(movements: list, loading: false);
    } catch (e) {
      if (!_disposed) {
        state = _CashState(
            movements: state.movements,
            loading: false,
            error: friendlyError(e));
      }
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SCREEN — the open shift's cash in/out, with a "New movement" action.
// ─────────────────────────────────────────────────────────────────────────────

class CashMovementsScreen extends ConsumerStatefulWidget {
  const CashMovementsScreen({super.key});

  @override
  ConsumerState<CashMovementsScreen> createState() =>
      _CashMovementsScreenState();
}

class _CashMovementsScreenState extends ConsumerState<CashMovementsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  String? get _shiftId => ref.read(shiftProvider).shift?.id;

  void _load() {
    if (!mounted) return;
    final id = _shiftId;
    if (id != null) ref.read(_cashProvider.notifier).load(id);
  }

  void _newMovement() {
    final id = _shiftId;
    if (id == null) return;
    CashMovementSheet.show(context, shiftId: id, onSuccess: _load);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    final hasShift = ref.watch(shiftProvider.select((x) => x.shift != null));

    return Scaffold(
      body: Column(children: [
        AppTopBar(
          title: s.cashMovementsTitle,
          subtitle: s.cashMovementsSubtitle,
          actions: [
            RefreshButton(
              onTap: _load,
              loading: ref.watch(_cashProvider.select((cs) => cs.loading)),
            ),
          ],
        ),
        Expanded(
          child: hasShift
              ? _buildBody()
              : EmptyState(
                  icon: Icons.point_of_sale_rounded,
                  title: s.shiftNoCashMovements,
                  body: s.cashMovementsNeedShift,
                ),
        ),
      ]),
      floatingActionButton: hasShift
          ? FloatingActionButton.extended(
              onPressed: _newMovement,
              backgroundColor: t.accent,
              foregroundColor: t.textOnAccent,
              icon: const Icon(Icons.add_rounded, size: 20),
              label: Text(s.cashMovementsNew),
            )
          : null,
    );
  }

  Widget _buildBody() {
    final t = context.tokens;
    final s = l10n(context);
    final state = ref.watch(_cashProvider);

    if (state.loading && state.movements.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.error != null) {
      return ErrorState(message: state.error!, onRetry: _load);
    }
    if (state.movements.isEmpty) {
      return EmptyState(
        icon: Icons.payments_outlined,
        title: s.shiftNoCashMovements,
        body: s.cashMovementsEmptyBody,
      );
    }

    final movements = state.movements;
    var totalIn = 0, totalOut = 0;
    for (final m in movements) {
      if (m.amount >= 0) {
        totalIn += m.amount;
      } else {
        totalOut += -m.amount;
      }
    }

    return ListView(
      // Extra bottom room so the FAB never covers the last row.
      padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpace.lg, AppSpace.lg, AppSpace.lg, 88),
      children: [
        _SummaryStrip(totalIn: totalIn, totalOut: totalOut),
        const SizedBox(height: AppSpace.lg),
        SurfaceCard(
          padding: EdgeInsets.zero,
          radius: AppRadius.lg,
          clipBehavior: Clip.antiAlias,
          child: Column(children: [
            for (final (i, m) in movements.indexed) ...[
              if (i > 0) Divider(height: 1, color: t.borderLight),
              _MovementRow(movement: m),
            ],
          ]),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SUMMARY — cash in / cash out / net
// ─────────────────────────────────────────────────────────────────────────────

class _SummaryStrip extends StatelessWidget {
  final int totalIn;
  final int totalOut;
  const _SummaryStrip({required this.totalIn, required this.totalOut});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    final net = totalIn - totalOut;

    Widget metric(String label, String value, Color color) => Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: ui(size: 12, color: t.textSecondary)),
            const SizedBox(height: 3),
            Text(value,
                style: money(size: 16, weight: FontWeight.w700, color: color)),
          ]),
        );

    return SurfaceCard(
      child: Row(children: [
        metric(s.cashIn, '+ ${egp(totalIn)}', t.success),
        metric(s.cashOut, '− ${egp(totalOut)}', t.danger),
        metric(s.cashMovementsNet, egp(net),
            net >= 0 ? t.textPrimary : t.danger),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  ROW
// ─────────────────────────────────────────────────────────────────────────────

class _MovementRow extends StatelessWidget {
  final CashMovement movement;
  const _MovementRow({required this.movement});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    final isIn = movement.amount >= 0;
    final color = isIn ? t.success : t.danger;
    final bg = isIn ? t.successBg : t.dangerBg;
    final note = movement.note.trim();

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpace.lg, AppSpace.md, AppSpace.lg, AppSpace.md),
      child: Row(children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
          child: Icon(
              isIn ? Icons.south_west_rounded : Icons.north_east_rounded,
              size: 18,
              color: color),
        ),
        const SizedBox(width: AppSpace.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.isEmpty ? (isIn ? s.cashIn : s.cashOut) : note,
                  style: ui(
                      size: 14, weight: FontWeight.w600, color: t.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Text('${movement.movedByName} · ${dateTime(movement.createdAt)}',
                  style: ui(size: 12, color: t.textSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        const SizedBox(width: AppSpace.sm),
        Text('${isIn ? '+' : '−'} ${egp(movement.amount.abs())}',
            style: money(size: 14, weight: FontWeight.w700, color: color)),
      ]),
    );
  }
}
