import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/l10n/l10n.dart';
import '../../core/providers/auth_notifier.dart';
import '../../core/providers/shift_notifier.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatting.dart';
import '../../core/utils/responsive.dart';
import '../../shared/widgets/amount_field.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_top_bar.dart';
import '../../shared/widgets/confirm_sheet.dart';
import '../../shared/widgets/offline_banner.dart';
import '../../shared/widgets/surface_card.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  EPHEMERAL STATE — autoDispose provider (resets when the screen unmounts).
//  The amount controller stays in the State.
// ─────────────────────────────────────────────────────────────────────────────

class _OpenShiftFormState {
  final bool loading;
  final String? error;
  const _OpenShiftFormState({this.loading = false, this.error});
}

final _openShiftFormProvider = NotifierProvider.autoDispose<
    _OpenShiftFormController, _OpenShiftFormState>(_OpenShiftFormController.new);

class _OpenShiftFormController extends AutoDisposeNotifier<_OpenShiftFormState> {
  bool _disposed = false;

  @override
  _OpenShiftFormState build() {
    ref.onDispose(() => _disposed = true);
    return const _OpenShiftFormState();
  }

  void setError(String message) {
    if (_disposed) return;
    state = _OpenShiftFormState(loading: state.loading, error: message);
  }

  void start() {
    if (_disposed) return;
    state = const _OpenShiftFormState(loading: true);
  }

  void fail(String message) {
    if (_disposed) return;
    state = _OpenShiftFormState(loading: false, error: message);
  }
}

class OpenShiftScreen extends ConsumerStatefulWidget {
  const OpenShiftScreen({super.key});

  @override
  ConsumerState<OpenShiftScreen> createState() => _OpenShiftScreenState();
}

class _OpenShiftScreenState extends ConsumerState<OpenShiftScreen> {
  final _ctrl = TextEditingController();
  StreamSubscription<bool>? _connectivitySub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final s = ref.read(shiftProvider).suggestedOpeningCash;
      if (s > 0) _ctrl.text = (s / 100).toStringAsFixed(0);
    });
    // On reconnect, re-check shift state — another device may have opened one.
    _connectivitySub = ConnectivityService.instance.stream.listen((online) {
      if (!online || !mounted) return;
      final branchId = ref.read(authProvider).user?.branchId;
      if (branchId == null) return;
      ref.read(shiftProvider.notifier).load(branchId).then((_) {
        if (mounted && ref.read(shiftProvider).hasOpenShift) {
          context.go('/order');
        }
      });
    });
  }

  @override
  void dispose() {
    _connectivitySub?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final s = l10n(context);
    final ctl = ref.read(_openShiftFormProvider.notifier);
    final piastres = AmountField.parsePiastres(_ctrl.text);
    if (piastres == null || piastres < 0) {
      ctl.setError(s.shiftErrorValidCash);
      return;
    }
    final branchId = ref.read(authProvider).user?.branchId;
    if (branchId == null) {
      ctl.setError(s.shiftErrorNoBranch);
      return;
    }

    // ── Confirmation step ──────────────────────────────────────────────────
    final isOnline = ConnectivityService.instance.isOnline;
    final confirmed = await ConfirmSheet.show(
      context,
      title: s.shiftOpen,
      body: isOnline
          ? s.shiftOpenConfirmBody(egp(piastres))
          : '${s.shiftOpenConfirmBody(egp(piastres))}\n\n'
              '${s.shiftOpenOfflineNote}',
      confirmLabel: s.shiftOpen,
      icon: Icons.point_of_sale_rounded,
    );
    if (!confirmed || !mounted) return;

    ctl.start();

    final ok = await ref
        .read(shiftProvider.notifier)
        .openShift(branchId, piastres);

    if (!mounted) return;
    if (ok) {
      context.go('/order');
    } else {
      ctl.fail(ref.read(shiftProvider).error ?? l10n(context).shiftOpenFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final suggested =
        ref.watch(shiftProvider.select((s) => s.suggestedOpeningCash));
    final isOnline = ref.watch(isOnlineProvider);
    final form = ref.watch(_openShiftFormProvider);

    return Scaffold(
      backgroundColor: t.bg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTopBar(
            title: l10n(context).shiftOpen,
            subtitle: l10n(context).shiftOpenSubtitle,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Padding(
                    padding: EdgeInsets.all(
                        context.responsive(phone: 20, tablet: 32)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const OfflineBanner(),
                        _buildCard(context, t, suggested, isOnline, form),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, AppTokens t, int suggested,
      bool isOnline, _OpenShiftFormState form) {
    final s = l10n(context);
    return SurfaceCard(
      padding: EdgeInsets.all(
          context.responsive(phone: AppSpace.xl, tablet: AppSpace.xxl)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ─────────────────────────────────────────────────────
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: t.accentBg,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child:
                    Icon(Icons.point_of_sale_rounded, color: t.accent, size: 22),
              ),
              const SizedBox(width: AppSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.shiftOpenCardTitle,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 2),
                    Text(s.shiftOpenCardBody,
                        style: ui(size: 12, color: t.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpace.xl),

          // ── Opening cash ───────────────────────────────────────────────
          AmountField(
            controller: _ctrl,
            label: s.shiftOpeningCash,
            hint: '0.00',
            autofocus: true,
          ),
          if (suggested > 0) ...[
            const SizedBox(height: AppSpace.md),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpace.md, vertical: AppSpace.sm + 2),
              decoration: BoxDecoration(
                color: t.surfaceAlt,
                borderRadius: BorderRadius.circular(AppRadius.xs),
                border: Border.all(color: t.borderLight),
              ),
              child: Row(
                children: [
                  Icon(Icons.history_rounded, size: 15, color: t.textMuted),
                  const SizedBox(width: AppSpace.sm),
                  Expanded(
                    child: Text(s.shiftSuggestedFromLastClose,
                        style: ui(size: 12, color: t.textSecondary)),
                  ),
                  Text(egp(suggested),
                      style: money(size: 13, color: t.textSecondary)),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpace.xl),

          // ── Error (from the shift notifier / validation) ───────────────
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            alignment: Alignment.topCenter,
            child: form.error == null
                ? const SizedBox.shrink()
                : Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: AppSpace.lg),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpace.md, vertical: AppSpace.sm + 2),
                    decoration: BoxDecoration(
                      color: t.dangerBg,
                      borderRadius: BorderRadius.circular(AppRadius.xs),
                      border: Border.all(color: t.danger.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline_rounded,
                            size: 16, color: t.danger),
                        const SizedBox(width: AppSpace.sm),
                        Expanded(
                          child: Text(form.error!,
                              style: ui(
                                  size: 13,
                                  weight: FontWeight.w600,
                                  color: t.danger)),
                        ),
                      ],
                    ),
                  ),
          ),

          AppButton(
            label: s.shiftOpen,
            loading: form.loading,
            width: double.infinity,
            icon: Icons.play_arrow_rounded,
            onTap: form.loading ? null : _submit,
          ),
          if (!isOnline) ...[
            const SizedBox(height: AppSpace.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi_off_rounded, size: 14, color: t.warning),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(s.shiftOpenedOfflineFooter,
                      style: ui(
                          size: 12,
                          weight: FontWeight.w600,
                          color: t.warning)),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
