import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/client.dart';
import '../../core/l10n/l10n.dart';
import '../../core/api/shift_api.dart';
import '../../core/providers/shift_notifier.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatting.dart';
import '../../shared/widgets/amount_field.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/responsive_sheet.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  EPHEMERAL STATE — autoDispose provider (resets when the sheet closes).
//  Text controllers stay in the State.
// ─────────────────────────────────────────────────────────────────────────────

class _MovementState {
  final bool isIn; // true = Cash In, false = Cash Out
  final bool loading;
  final String? error;
  const _MovementState({this.isIn = true, this.loading = false, this.error});
}

final _movementProvider =
    NotifierProvider.autoDispose<_MovementController, _MovementState>(
        _MovementController.new);

class _MovementController extends AutoDisposeNotifier<_MovementState> {
  bool _disposed = false;

  @override
  _MovementState build() {
    ref.onDispose(() => _disposed = true);
    return const _MovementState();
  }

  void setDirection(bool isIn) {
    if (_disposed) return;
    state = _MovementState(
        isIn: isIn, loading: state.loading, error: state.error);
  }

  void setError(String message) {
    if (_disposed) return;
    state =
        _MovementState(isIn: state.isIn, loading: state.loading, error: message);
  }

  void start() {
    if (_disposed) return;
    state = _MovementState(isIn: state.isIn, loading: true);
  }

  void fail(String message) {
    if (_disposed) return;
    state = _MovementState(isIn: state.isIn, loading: false, error: message);
  }
}

/// Records a cash in/out movement against the open shift.
///
/// ONLINE-ONLY by design: the backend can't safely dedupe queued cash
/// movements, so when offline the submit is disabled and the sheet says why.
class CashMovementSheet extends ConsumerStatefulWidget {
  final String shiftId;
  final void Function()? onSuccess;

  const CashMovementSheet({
    super.key,
    required this.shiftId,
    this.onSuccess,
  });

  static Future<void> show(
    BuildContext context, {
    required String shiftId,
    void Function()? onSuccess,
  }) =>
      ResponsiveSheet.show(
        context: context,
        builder: (_) => CashMovementSheet(
          shiftId: shiftId,
          onSuccess: onSuccess,
        ),
      );

  @override
  ConsumerState<CashMovementSheet> createState() => _CashMovementSheetState();
}

class _CashMovementSheetState extends ConsumerState<CashMovementSheet> {
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final s = l10n(context);
    final ctl = ref.read(_movementProvider.notifier);
    final piastres = AmountField.parsePiastres(_amountCtrl.text);
    if (piastres == null || piastres <= 0) {
      ctl.setError(s.shiftErrorValidAmount);
      return;
    }
    if (_noteCtrl.text.trim().isEmpty) {
      ctl.setError(s.shiftErrorNoteRequired);
      return;
    }

    final isOnline = ref.read(isOnlineProvider);
    if (!isOnline) {
      ctl.setError(s.commonCashOfflineHint);
      return;
    }

    final isIn = ref.read(_movementProvider).isIn;
    ctl.start();

    final signed = isIn ? piastres : -piastres;

    try {
      await ref.read(shiftApiProvider).addCashMovement(
            widget.shiftId,
            signed,
            _noteCtrl.text.trim(),
          );

      // Refresh system cash to reflect the new movement immediately
      await ref.read(shiftProvider.notifier).loadSystemCash();

      if (mounted) {
        final messenger = ScaffoldMessenger.of(context);
        final amount = egp(piastres);
        Navigator.pop(context);
        widget.onSuccess?.call();
        messenger.showSnackBar(SnackBar(
          content: Text(isIn
              ? s.shiftCashInRecorded(amount)
              : s.shiftCashOutRecorded(amount)),
        ));
      }
    } catch (e) {
      ctl.fail(friendlyError(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    final mq = MediaQuery.of(context);
    final isOnline = ref.watch(isOnlineProvider);
    final movement = ref.watch(_movementProvider);

    return Container(
      decoration: BoxDecoration(
        color: t.surfaceRaised,
        borderRadius: AppRadius.sheetRadius,
      ),
      padding: EdgeInsetsDirectional.fromSTEB(
          AppSpace.xl, 14, AppSpace.xl, mq.viewInsets.bottom + AppSpace.xxl),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: t.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpace.lg),

            Text(s.shiftCashMovement,
                style: ui(size: 19, weight: FontWeight.w700, color: t.textPrimary)),
            const SizedBox(height: AppSpace.lg),

            // Offline explanation — be honest about why submit is disabled.
            if (!isOnline) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: t.warningBg,
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                  border: Border.all(color: t.warning.withOpacity(0.3)),
                ),
                child: Row(children: [
                  Icon(Icons.wifi_off_rounded, size: 16, color: t.warning),
                  const SizedBox(width: AppSpace.sm + 2),
                  Expanded(
                    child: Text(s.shiftCashOfflineBanner,
                        style: ui(
                            size: 12,
                            weight: FontWeight.w600,
                            color: t.warning)),
                  ),
                ]),
              ),
              const SizedBox(height: AppSpace.lg),
            ],

            // Direction — segmented control
            _DirectionSegment(
              isIn: movement.isIn,
              onChanged: (v) =>
                  ref.read(_movementProvider.notifier).setDirection(v),
            ),
            const SizedBox(height: AppSpace.lg),

            // Amount
            AmountField(
              controller: _amountCtrl,
              label: s.shiftAmount,
              autofocus: true,
            ),
            const SizedBox(height: AppSpace.md),

            // Note
            TextField(
              controller: _noteCtrl,
              style: ui(size: 15, color: t.textPrimary),
              decoration: InputDecoration(
                labelText: s.shiftNoteRequired,
                hintText: s.shiftNoteHint,
                prefixIcon:
                    Icon(Icons.notes_rounded, size: 16, color: t.textMuted),
              ),
            ),

            // Error
            if (movement.error != null) ...[
              const SizedBox(height: AppSpace.md),
              Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: t.dangerBg,
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                  border: Border.all(color: t.danger.withOpacity(0.25)),
                ),
                child: Row(children: [
                  Icon(Icons.error_outline_rounded, size: 14, color: t.danger),
                  const SizedBox(width: AppSpace.sm),
                  Expanded(
                    child: Text(movement.error!,
                        style: ui(size: 13, color: t.danger)),
                  ),
                ]),
              ),
            ],
            const SizedBox(height: AppSpace.lg + 4),

            // Submit — disabled offline (online-only by design).
            AppButton(
              label:
                  movement.isIn ? s.shiftRecordCashIn : s.shiftRecordCashOut,
              icon: movement.isIn
                  ? Icons.add_circle_outline_rounded
                  : Icons.remove_circle_outline_rounded,
              variant: movement.isIn ? BtnVariant.primary : BtnVariant.danger,
              width: double.infinity,
              height: 52,
              loading: movement.loading,
              onTap: (!isOnline || movement.loading) ? null : _submit,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Segmented direction control — green money-in, red money-out.
// ─────────────────────────────────────────────────────────────────────────────

class _DirectionSegment extends StatelessWidget {
  final bool isIn;
  final ValueChanged<bool> onChanged;

  const _DirectionSegment({required this.isIn, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: t.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: t.border),
      ),
      child: Row(children: [
        Expanded(
          child: _Segment(
            label: l10n(context).cashIn,
            icon: Icons.add_circle_outline_rounded,
            selected: isIn,
            color: t.success,
            background: t.successBg,
            onTap: () => onChanged(true),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: _Segment(
            label: l10n(context).cashOut,
            icon: Icons.remove_circle_outline_rounded,
            selected: !isIn,
            color: t.danger,
            background: t.dangerBg,
            onTap: () => onChanged(false),
          ),
        ),
      ]),
    );
  }
}

class _Segment extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final Color color;
  final Color background;
  final VoidCallback onTap;

  const _Segment({
    required this.label,
    required this.icon,
    required this.selected,
    required this.color,
    required this.background,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return AnimatedPressScale(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? background : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.sm - 4),
          border: Border.all(
              color: selected ? color.withOpacity(0.45) : Colors.transparent),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 18, color: selected ? color : t.textMuted),
          const SizedBox(width: AppSpace.sm),
          Text(label,
              style: ui(
                  size: 14,
                  weight: FontWeight.w700,
                  color: selected ? color : t.textSecondary)),
        ]),
      ),
    );
  }
}
