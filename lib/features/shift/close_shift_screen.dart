import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/l10n/l10n.dart';
import '../../core/models/branch.dart';
import '../../core/models/shift.dart';
import '../../core/providers/auth_notifier.dart';
import '../../core/providers/payment_method_notifier.dart';
import '../../core/providers/shift_notifier.dart';
import '../../core/repositories/shift_repository.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/services/printer_service.dart';
import '../../core/storage/storage_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatting.dart';
import '../../core/utils/responsive.dart';
import '../../shared/widgets/amount_field.dart';
import '../../shared/widgets/animated_icons.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_top_bar.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/surface_card.dart';
import 'shift_report_preview_sheet.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  EPHEMERAL STATE — autoDispose provider (resets when the screen unmounts).
//  Text/inventory controllers and the draft-save Timer stay in the State.
// ─────────────────────────────────────────────────────────────────────────────

class _CloseShiftState {
  static const _unset = Object();

  final bool submitting;
  final bool printing;
  final String? error;
  final int declaredCash;
  final bool hasCashText;

  const _CloseShiftState({
    this.submitting = false,
    this.printing = false,
    this.error,
    this.declaredCash = 0,
    this.hasCashText = false,
  });

  _CloseShiftState copyWith({
    bool? submitting,
    bool? printing,
    Object? error = _unset,
    int? declaredCash,
    bool? hasCashText,
  }) =>
      _CloseShiftState(
        submitting: submitting ?? this.submitting,
        printing: printing ?? this.printing,
        error: identical(error, _unset) ? this.error : error as String?,
        declaredCash: declaredCash ?? this.declaredCash,
        hasCashText: hasCashText ?? this.hasCashText,
      );
}

final _closeShiftProvider =
    NotifierProvider.autoDispose<_CloseShiftController, _CloseShiftState>(
        _CloseShiftController.new);

class _CloseShiftController extends AutoDisposeNotifier<_CloseShiftState> {
  bool _disposed = false;

  @override
  _CloseShiftState build() {
    ref.onDispose(() => _disposed = true);
    return const _CloseShiftState();
  }

  void setCash(int declared, bool hasText) {
    if (_disposed) return;
    state = state.copyWith(declaredCash: declared, hasCashText: hasText);
  }

  void setPrinting(bool value) {
    if (_disposed) return;
    state = state.copyWith(printing: value);
  }

  void setError(String? message) {
    if (_disposed) return;
    state = state.copyWith(error: message);
  }

  void startSubmit() {
    if (_disposed) return;
    state = state.copyWith(submitting: true, error: null);
  }

  void failSubmit(String message) {
    if (_disposed) return;
    state = state.copyWith(submitting: false, error: message);
  }
}

class CloseShiftScreen extends ConsumerStatefulWidget {
  const CloseShiftScreen({super.key});
  @override
  ConsumerState<CloseShiftScreen> createState() => _CloseShiftScreenState();
}

class _CloseShiftScreenState extends ConsumerState<CloseShiftScreen> {
  final _cashCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();

  // Set to true the moment the user presses Back so that any in-flight close
  // that completes after navigation (but before the frame where mounted→false)
  // doesn't trigger a logout.
  bool _navigatedAway = false;

  Timer? _draftTimer;

  _CloseShiftController get _ctl => ref.read(_closeShiftProvider.notifier);

  @override
  void initState() {
    super.initState();
    _cashCtrl.addListener(_onCashChanged);
    _noteCtrl.addListener(_scheduleDraftSave);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(shiftProvider.notifier).loadSystemCash();
      if (!mounted) return;
      _restoreDraft();
    });
  }

  @override
  void dispose() {
    _draftTimer?.cancel();
    _cashCtrl
      ..removeListener(_onCashChanged)
      ..dispose();
    _noteCtrl
      ..removeListener(_scheduleDraftSave)
      ..dispose();
    super.dispose();
  }

  void _onBack() {
    _navigatedAway = true;
    // Stay on the order screen if the shift is still open; only go to
    // open-shift when the shift has already been cleared (shouldn't normally
    // happen via the back button, but handle it gracefully).
    context.go(ref.read(shiftProvider).hasOpenShift ? '/order' : '/open-shift');
  }

  void _onCashChanged() {
    if (!mounted) return;
    final raw = double.tryParse(_cashCtrl.text);
    _ctl.setCash(raw != null ? (raw * 100).round() : 0,
        _cashCtrl.text.isNotEmpty);
    _scheduleDraftSave();
  }

  // ── Draft auto-save ────────────────────────────────────────────────────────
  // Counting a drawer + stockroom takes minutes; a crash must not lose it.

  String? get _draftKey {
    final shiftId = ref.read(shiftProvider).shift?.id;
    return shiftId == null ? null : 'close_draft_$shiftId';
  }

  void _scheduleDraftSave() {
    _draftTimer?.cancel();
    _draftTimer = Timer(const Duration(milliseconds: 400), _saveDraft);
  }

  Future<void> _saveDraft() async {
    if (!mounted) return;
    final key = _draftKey;
    if (key == null) return;
    final draft = {
      'cash': _cashCtrl.text,
      'note': _noteCtrl.text,
    };
    await ref.read(storageServiceProvider).raw.setString(key, jsonEncode(draft));
  }

  void _restoreDraft() {
    final key = _draftKey;
    if (key == null) return;
    final raw = ref.read(storageServiceProvider).raw.getString(key);
    if (raw == null) return;
    try {
      final draft = jsonDecode(raw) as Map<String, dynamic>;
      final cash = draft['cash'] as String? ?? '';
      if (cash.isNotEmpty) _cashCtrl.text = cash;
      final note = draft['note'] as String? ?? '';
      if (note.isNotEmpty) _noteCtrl.text = note;
    } catch (_) {}
  }

  Future<void> _clearDraft(String shiftId) =>
      ref.read(storageServiceProvider).raw.remove('close_draft_$shiftId');

  // ── Print ──────────────────────────────────────────────────────────────────

  Future<void> _printReport() async {
    final t = context.tokens;
    final shift = ref.read(shiftProvider).shift;
    if (shift == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l10n(context).shiftNoOpenShift),
          backgroundColor: t.warning));
      return;
    }
    _ctl.setPrinting(true);
    try {
      final report = await ref.read(shiftRepositoryProvider).getReport(shift.id);
      if (mounted) {
        _ctl.setPrinting(false);
        await ShiftReportPreviewSheet.show(context, report);
      }
    } catch (e) {
      if (mounted) {
        _ctl.setPrinting(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(l10n(context).commonFailedLoadReport('$e')),
            backgroundColor: t.danger));
      }
    }
  }

  /// Print the final, backend-sourced shift report straight to the branch
  /// printer right after an online close. Best-effort: a failure is surfaced
  /// in a snackbar but never blocks the teller from leaving the closed shift.
  Future<void> _autoPrintReport(String shiftId) async {
    final branch = ref.read(authProvider).branch;
    // Nothing to print to — the manual print flow guards the same way.
    if (branch == null || !branch.hasPrinter) return;

    try {
      // Re-fetch from the backend so the printout reflects the just-closed
      // shift (closing cash, closed-at, final totals) — not the local draft.
      final report = await ref.read(shiftRepositoryProvider).getReport(shiftId);
      final methods = ref.read(paymentMethodProvider).items;
      final err = await PrinterService.printShiftReport(
        ip: branch.printerIp!,
        port: branch.printerPort ?? 9100,
        brand: branch.printerBrand!,
        report: report,
        paymentMethods: methods,
        branchName: branch.name,
        logoUrl: branch.orgLogoUrl,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err ?? l10n(context).shiftReportPrinted),
        backgroundColor: err == null ? context.tokens.success : context.tokens.danger,
      ));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(l10n(context).commonFailedLoadReport('$e')),
        backgroundColor: context.tokens.danger,
      ));
    }
  }

  // ── Close ──────────────────────────────────────────────────────────────────

  Future<void> _close() async {
    final s = l10n(context);
    final piastres = AmountField.parsePiastres(_cashCtrl.text);
    if (piastres == null || piastres < 0) {
      _ctl.setError(s.shiftErrorValidClosingCash);
      return;
    }

    _ctl.startSubmit();

    final branchId = ref.read(authProvider).user!.branchId!;
    final shiftId = ref.read(shiftProvider).shift?.id;
    // Offline/queued closes don't reach the backend yet, so the report wouldn't
    // be final — only auto-print when the close lands on the server live.
    final willQueue =
        !ref.read(isOnlineProvider) || ref.read(authProvider).isOfflineSession;
    final ok = await ref.read(shiftProvider.notifier).closeShift(
          branchId: branchId,
          closingCash: piastres,
          note: _noteCtrl.text.isEmpty ? null : _noteCtrl.text,
        );

    if (!mounted || _navigatedAway) return;

    if (ok) {
      _draftTimer?.cancel();
      if (shiftId != null) await _clearDraft(shiftId);
      if (!mounted || _navigatedAway) return;
      // Auto-print the final report before logout/navigation tears the branch
      // printer config down.
      if (shiftId != null && !willQueue) {
        await _autoPrintReport(shiftId);
        if (!mounted || _navigatedAway) return;
      }
      final canNowLogout = await ref.read(authProvider.notifier).canLogout();
      if (!mounted || _navigatedAway) return;
      if (canNowLogout) {
        await ref.read(authProvider.notifier).logout();
        if (mounted && !_navigatedAway) context.go('/login');
      } else {
        context.go('/open-shift');
      }
    } else {
      _ctl.failSubmit(
          ref.read(shiftProvider).error ?? l10n(context).shiftCloseFailed);
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final shift = ref.watch(shiftProvider.select((s) => s.shift));
    // Watched at the root so the provider stays alive for the whole screen.
    final printing =
        ref.watch(_closeShiftProvider.select((s) => s.printing));
    final submitting =
        ref.watch(_closeShiftProvider.select((s) => s.submitting));

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTopBar(
            title: l10n(context).shiftClose,
            subtitle: shift?.tellerName,
            // Disable back during submission so a fast close + back press can't
            // trigger a spurious logout before the widget unmounts.
            onBack: submitting ? null : _onBack,
            actions: [
              if (shift != null)
                printing
                    // Print-in-progress: the receipt feeds out of the printer
                    // on a gentle loop while the report prints.
                    ? Padding(
                        padding: const EdgeInsetsDirectional.only(
                            end: AppSpace.md),
                        child: SizedBox(
                          width: 22,
                          height: 22,
                          child: LoopingIcon(
                            duration: const Duration(milliseconds: 1500),
                            builder: (_, a) => CustomPaint(
                                size: const Size(22, 22),
                                painter: PrinterPainter(
                                    t: a,
                                    color: t.navy,
                                    paperFill: t.surface)),
                          ),
                        ),
                      )
                    : IconButton(
                        onPressed: _printReport,
                        tooltip: l10n(context).commonPrintReport,
                        icon: Icon(Icons.print_rounded,
                            size: 20, color: t.textPrimary),
                      ),
            ],
          ),
          Expanded(
            child: shift == null
                ? EmptyState(
                    icon: Icons.lock_outline_rounded,
                    title: l10n(context).shiftNoOpenShift,
                    body: l10n(context).shiftNothingToClose,
                  )
                : context.isPhone
                    ? _buildPhone(shift)
                    : _buildWide(shift),
          ),
        ],
      ),
    );
  }

  Widget _buildPhone(Shift shift) => SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpace.lg),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SummaryCard(shift: shift),
                const SizedBox(height: AppSpace.lg),
                _CashCard(state: this),
                const SizedBox(height: AppSpace.lg),
                _SubmitSection(state: this),
                const SizedBox(height: AppSpace.xxl),
              ],
            ),
          ),
        ),
      );

  Widget _buildWide(Shift shift) => Column(children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpace.xl, AppSpace.xl, AppSpace.xl, 0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(children: [
                        _SummaryCard(shift: shift),
                        const SizedBox(height: AppSpace.lg),
                        _CashCard(state: this),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpace.xl, AppSpace.md, AppSpace.xl, AppSpace.xl),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: _SubmitSection(state: this),
            ),
          ),
        ),
      ]);
}

// ─────────────────────────────────────────────────────────────────────────────
//  Section cards
// ─────────────────────────────────────────────────────────────────────────────

class _CardTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  const _CardTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Row(children: [
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: t.navyBg,
          borderRadius: BorderRadius.circular(AppRadius.xs),
        ),
        child: Icon(icon, color: t.navy, size: 18),
      ),
      const SizedBox(width: AppSpace.md),
      Text(title,
          style: ui(size: 14, weight: FontWeight.w600, color: t.textPrimary)),
    ]);
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isMoney;
  const _InfoRow(this.label, this.value, {this.isMoney = false});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpace.xs),
      child: Row(children: [
        Expanded(
          child: Text(label, style: ui(size: 13, color: t.textSecondary)),
        ),
        Text(value,
            style: isMoney
                ? money(size: 14, color: t.textPrimary)
                : ui(size: 13, weight: FontWeight.w600, color: t.textPrimary)),
      ]),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final Shift shift;
  const _SummaryCard({required this.shift});

  @override
  Widget build(BuildContext context) {
    final s = l10n(context);
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(icon: Icons.summarize_outlined, title: s.shiftSummary),
          const SizedBox(height: AppSpace.lg),
          _InfoRow(s.commonTeller, shift.tellerName),
          _InfoRow(s.shiftOpeningCash, egp(shift.openingCash), isMoney: true),
          _InfoRow(s.shiftOpenedAtLabel, dateTime(shift.openedAt)),
        ],
      ),
    );
  }
}

class _CashCard extends ConsumerWidget {
  final _CloseShiftScreenState state;
  const _CashCard({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final s = l10n(context);
    final systemCash =
        ref.watch(shiftProvider.select((st) => st.systemCash));
    final cashLoading =
        ref.watch(shiftProvider.select((st) => st.systemCashLoading));
    final declaredCash =
        ref.watch(_closeShiftProvider.select((st) => st.declaredCash));
    final hasCashText =
        ref.watch(_closeShiftProvider.select((st) => st.hasCashText));
    final showDiscrep = !cashLoading && hasCashText;

    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(icon: Icons.payments_outlined, title: s.shiftCashCount),
          const SizedBox(height: AppSpace.lg),
          Container(
            padding: const EdgeInsets.all(AppSpace.lg - 2),
            decoration: BoxDecoration(
              color: t.surfaceAlt,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Row(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.shiftSystemCash,
                        style: ui(
                            size: 12,
                            weight: FontWeight.w600,
                            color: t.textSecondary)),
                    const SizedBox(height: 2),
                    Text(s.shiftSystemCashExplain,
                        style: ui(size: 11, color: t.textMuted)),
                  ],
                ),
              ),
              cashLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(egp(systemCash),
                      style: money(
                          size: 20,
                          weight: FontWeight.w800,
                          color: t.textPrimary)),
            ]),
          ),
          const SizedBox(height: AppSpace.lg),
          AmountField(
            controller: state._cashCtrl,
            label: s.shiftActualCash,
            hint: '0.00',
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: showDiscrep
                ? Padding(
                    padding: const EdgeInsets.only(top: AppSpace.md),
                    child: _DiscrepancyBanner(
                        declared: declaredCash, systemCash: systemCash),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: AppSpace.lg),
          TextField(
            controller: state._noteCtrl,
            decoration: InputDecoration(
              hintText: s.shiftCashNoteOptional,
              prefixIcon: Icon(Icons.notes_rounded, size: 16, color: t.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubmitSection extends ConsumerWidget {
  final _CloseShiftScreenState state;
  const _SubmitSection({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final isOnline = ref.watch(isOnlineProvider);
    final offlineSession =
        ref.watch(authProvider.select((a) => a.isOfflineSession));
    final error = ref.watch(_closeShiftProvider.select((st) => st.error));
    final submitting =
        ref.watch(_closeShiftProvider.select((st) => st.submitting));
    final willQueue = !isOnline || offlineSession;

    return Column(children: [
      AnimatedSize(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: error != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: AppSpace.md),
                child: _NoticeBanner(
                  icon: Icons.error_outline_rounded,
                  text: error,
                  color: t.danger,
                  background: t.dangerBg,
                ),
              )
            : const SizedBox.shrink(),
      ),
      if (willQueue)
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpace.md),
          child: _NoticeBanner(
            icon: Icons.wifi_off_rounded,
            text: l10n(context).shiftCloseOfflineNote,
            color: t.navy,
            background: t.navyBg,
          ),
        ),
      AppButton(
        label: l10n(context).shiftClose,
        variant: BtnVariant.danger,
        loading: submitting,
        width: double.infinity,
        icon: Icons.lock_outline_rounded,
        onTap: submitting ? null : state._close,
      ),
    ]);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Small widgets
// ─────────────────────────────────────────────────────────────────────────────

class _NoticeBanner extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color background;

  const _NoticeBanner({
    required this.icon,
    required this.text,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(AppRadius.xs),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: AppSpace.sm),
          Expanded(
            child: Text(text,
                style: ui(size: 12, weight: FontWeight.w600, color: color)),
          ),
        ]),
      );
}

/// Explicit drawer-versus-system wording: no sign ambiguity for the teller.
class _DiscrepancyBanner extends StatelessWidget {
  final int declared;
  final int systemCash;
  const _DiscrepancyBanner({required this.declared, required this.systemCash});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    final diff = declared - systemCash;
    final (color, bg, icon, label) = diff == 0
        ? (
            t.success,
            t.successBg,
            Icons.check_circle_outline_rounded,
            s.shiftDrawerMatches
          )
        : diff > 0
            ? (
                t.warning,
                t.warningBg,
                Icons.arrow_upward_rounded,
                s.shiftDrawerOver(egp(diff))
              )
            : (
                t.danger,
                t.dangerBg,
                Icons.arrow_downward_rounded,
                s.shiftDrawerShort(egp(diff.abs()))
              );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(children: [
        Icon(icon, size: 15, color: color),
        const SizedBox(width: AppSpace.sm),
        Expanded(
          child: Text(label,
              style: ui(size: 13, weight: FontWeight.w600, color: color)),
        ),
        if (diff != 0)
          Text(s.shiftSystemAmount(egp(systemCash)),
              style: money(
                  size: 11, weight: FontWeight.w600,
                  color: color.withOpacity(0.75))),
      ]),
    );
  }
}
