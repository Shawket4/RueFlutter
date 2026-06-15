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
  final _reasonCtrl = TextEditingController();
  StreamSubscription<bool>? _connectivitySub;

  /// Guards the one-time auto-fill from the last close so a later network
  /// refresh (or a rebuild) can't overwrite the field once it's been set.
  bool _prefilled = false;

  /// Fills the opening-cash field from the last closed shift's declared cash,
  /// but only while the field is still untouched. The suggestion arrives from
  /// the network (phase-2 of [ShiftNotifier.load]) — often AFTER first frame —
  /// so this is driven reactively from [build]'s listener, not read once.
  void _maybePrefill(int suggested) {
    if (_prefilled || suggested <= 0) return;
    if (_ctrl.text.trim().isNotEmpty) return;
    _ctrl.text = (suggested / 100).toStringAsFixed(0);
    _prefilled = true;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Auth seeding only carries the open shift, not the prefill — so fetch
      // fresh shift state here to populate suggestedOpeningCash. Already-known
      // values fill immediately; a network value fills via build's listener.
      // (If the token has expired, this load()'s 401 trips the Dio interceptor
      // → force-logout → /login; we don't try to reason about shift state from
      // an unauthenticated screen.)
      final branchId = ref.read(authProvider).user?.branchId;
      if (branchId != null && ConnectivityService.instance.isOnline) {
        ref.read(shiftProvider.notifier).load(branchId);
      }
      _maybePrefill(ref.read(shiftProvider).suggestedOpeningCash);
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
    _reasonCtrl.dispose();
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

    // Cash continuity: deviating from the carried-over closing needs a reason.
    // (suggested == 0 means no carryover to continue from — no reason required.)
    final suggested = ref.read(shiftProvider).suggestedOpeningCash;
    final needsReason = suggested > 0 && piastres != suggested;
    final reason = _reasonCtrl.text.trim();
    if (needsReason && reason.isEmpty) {
      ctl.setError(s.shiftOpeningReasonRequired);
      return;
    }
    final editReason = needsReason ? reason : null;

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
        .openShift(branchId, piastres, editReason: editReason);

    if (!mounted) return;
    if (ok) {
      context.go('/order');
    } else {
      ctl.fail(ref.read(shiftProvider).error ?? l10n(context).shiftOpenFailed);
    }
  }

  /// Escape hatch from the open-shift screen. The teller can land here in a
  /// session with no usable token — an expired JWT, or an offline PIN unlock
  /// that was never upgraded to a real login — in which case opening a shift
  /// only ever fails (401 / "shift already open"). Signing out clears the
  /// session so the router redirect lands on /login for a clean sign-in.
  /// (No open shift exists on this screen, so there's nothing to close first.)
  Future<void> _signOut() async {
    final s = l10n(context);
    final confirmed = await ConfirmSheet.show(
      context,
      title: s.settingsSignOutTitle,
      body: s.settingsSignOutBody,
      confirmLabel: s.commonSignOut,
      destructive: true,
      icon: Icons.logout_rounded,
    );
    if (!confirmed || !mounted) return;
    await ref.read(authProvider.notifier).logout();
    if (mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final suggested =
        ref.watch(shiftProvider.select((s) => s.suggestedOpeningCash));
    // Auto-fill the field the moment the suggestion lands (it usually arrives
    // from the network after the first frame).
    ref.listen<int>(shiftProvider.select((s) => s.suggestedOpeningCash),
        (_, next) => _maybePrefill(next));
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
            actions: [
              IconButton(
                icon: Icon(Icons.logout_rounded, color: t.textPrimary, size: 22),
                tooltip: l10n(context).commonSignOut,
                onPressed: _signOut,
              ),
            ],
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

          // ── Reason (required when the opening deviates from the carryover) ─
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _ctrl,
            builder: (context, value, _) {
              final entered = AmountField.parsePiastres(value.text);
              final needsReason =
                  suggested > 0 && entered != null && entered != suggested;
              if (!needsReason) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(top: AppSpace.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline_rounded,
                            size: 15, color: t.warning),
                        const SizedBox(width: AppSpace.sm),
                        Expanded(
                          child: Text(s.shiftOpeningDiffersHint(egp(suggested)),
                              style: ui(size: 12, color: t.textSecondary)),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpace.sm),
                    TextField(
                      controller: _reasonCtrl,
                      minLines: 1,
                      maxLines: 2,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: s.shiftOpeningReasonLabel,
                        hintText: s.shiftOpeningReasonHint,
                        border: const OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
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
