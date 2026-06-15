import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../core/api/client.dart';
import '../../core/l10n/l10n.dart';
import '../../core/utils/haptics.dart';
import '../../core/api/order_api.dart';
import '../../core/models/order.dart';
import '../../core/models/pending_action.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/services/offline_queue.dart';
import '../../core/theme/app_theme.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/confirm_sheet.dart';
import '../../shared/widgets/responsive_sheet.dart';
import '../../shared/widgets/section_header.dart';

/// Form state for one void sheet. autoDispose.family keyed by order id:
/// resets when the sheet closes, never shared between orders.
@immutable
class _VoidFormState {
  final String? reason;
  final bool restore;
  final bool loading;
  final String? error;

  const _VoidFormState({
    this.reason,
    this.restore = true,
    this.loading = false,
    this.error,
  });

  _VoidFormState copyWith({
    String? reason,
    bool? restore,
    bool? loading,
    String? error,
    bool clearError = false,
  }) =>
      _VoidFormState(
        reason: reason ?? this.reason,
        restore: restore ?? this.restore,
        loading: loading ?? this.loading,
        error: clearError ? null : (error ?? this.error),
      );
}

class _VoidFormNotifier
    extends AutoDisposeFamilyNotifier<_VoidFormState, String> {
  @override
  _VoidFormState build(String arg) => const _VoidFormState();

  void selectReason(String reason) =>
      state = state.copyWith(reason: reason, clearError: true);

  void setRestore(bool value) => state = state.copyWith(restore: value);

  void setError(String message) => state = state.copyWith(error: message);

  void clearError() => state = state.copyWith(clearError: true);

  void startSubmitting() =>
      state = state.copyWith(loading: true, clearError: true);

  void fail(String message) =>
      state = state.copyWith(loading: false, error: message);
}

final _voidFormProvider = NotifierProvider.autoDispose
    .family<_VoidFormNotifier, _VoidFormState, String>(_VoidFormNotifier.new);

class VoidOrderSheet extends ConsumerStatefulWidget {
  final Order order;
  final void Function(Order) onVoided;
  const VoidOrderSheet(
      {super.key, required this.order, required this.onVoided});

  static Future<void> show(
          BuildContext ctx, Order order, void Function(Order) onVoided) =>
      ResponsiveSheet.show(
          context: ctx,
          builder: (_) => VoidOrderSheet(order: order, onVoided: onVoided));

  @override
  ConsumerState<VoidOrderSheet> createState() => _VoidOrderSheetState();
}

class _VoidOrderSheetState extends ConsumerState<VoidOrderSheet> {
  final _otherCtrl = TextEditingController();

  _VoidFormNotifier get _form =>
      ref.read(_voidFormProvider(widget.order.id).notifier);

  List<(String, String)> _reasons(AppLocalizations s) => [
        ('customer_request', s.orderVoidReasonCustomerRequest),
        ('wrong_order', s.orderVoidReasonWrongOrder),
        ('quality_issue', s.orderVoidReasonQualityIssue),
        ('other', s.orderVoidReasonOther),
      ];

  @override
  void dispose() {
    _otherCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final s = l10n(context);
    final form = ref.read(_voidFormProvider(widget.order.id));

    if (form.reason == null) {
      Haptics.warning();
      _form.setError(s.orderVoidSelectReason);
      return;
    }

    final reason = form.reason!;
    String? note;
    if (reason == 'other') {
      final otherText = _otherCtrl.text.trim();
      if (otherText.isEmpty) {
        Haptics.warning();
        _form.setError(s.orderVoidSpecifyReason);
        return;
      }
      note = otherText;
    }

    final isOnline = ConnectivityService.instance.isOnline;

    // Voiding is irreversible — always pass through the confirm sheet.
    final confirmed = await ConfirmSheet.show(
      context,
      title: widget.order.orderRef != null
          ? '${s.orderVoidConfirmTitle(widget.order.orderNumber)} (${widget.order.orderRef})'
          : s.orderVoidConfirmTitle(widget.order.orderNumber),
      body: isOnline
          ? s.orderVoidConfirmBodyOnline
          : s.orderVoidConfirmBodyOffline,
      confirmLabel: s.orderVoidConfirmAction,
      destructive: true,
    );
    if (!confirmed || !mounted) return;

    _form.startSubmitting();
    final now = DateTime.now();

    try {
      if (isOnline) {
        final updated = await ref.read(orderApiProvider).voidOrder(
              widget.order.id,
              reason: reason,
              note: note,
              restoreInventory: form.restore,
              voidedAt: now,
            );
        if (mounted) {
          Navigator.pop(context);
          widget.onVoided(updated);
        }
      } else {
        await ref.read(offlineQueueProvider.notifier).enqueueVoid(
              PendingVoidOrder(
                localId: const Uuid().v4(),
                createdAt: now,
                orderId: widget.order.id,
                reason: reason,
                note: note,
                restoreInventory: form.restore,
                voidedAt: now,
              ),
            );
        final optimistic = widget.order.copyWith(
          status: 'voided',
          voidReason: reason,
        );
        if (mounted) {
          Navigator.pop(context);
          widget.onVoided(optimistic);
        }
      }
    } catch (e) {
      if (mounted) {
        // OfflineVoidBlockedError carries its own actionable message.
        _form.fail(
            e is OfflineVoidBlockedError ? e.toString() : friendlyError(e));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    final form = ref.watch(_voidFormProvider(widget.order.id));
    final isOnline = ConnectivityService.instance.isOnline;

    return Container(
      margin: const EdgeInsets.all(AppSpace.md),
      padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpace.xl, AppSpace.lg, AppSpace.xl, AppSpace.xxl),
      decoration: BoxDecoration(
        color: t.surfaceRaised,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: t.border),
      ),
      child: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Grab handle
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                      color: t.border, borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: AppSpace.lg),
              Text(s.orderVoidTitle(widget.order.orderNumber),
                  style: Theme.of(context).textTheme.titleLarge),
              if (widget.order.orderRef != null)
                Text(widget.order.orderRef!,
                    style: ui(size: 13, color: t.textSecondary)),
              const SizedBox(height: AppSpace.xs),
              Text(
                s.orderVoidCannotUndo,
                style: ui(size: 13, color: t.textSecondary),
              ),
              if (!isOnline) ...[
                const SizedBox(height: AppSpace.md),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: AppSpace.md, vertical: AppSpace.sm),
                  decoration: BoxDecoration(
                    color: t.warningBg,
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                    border: Border.all(color: t.warning.withOpacity(0.3)),
                  ),
                  child: Row(children: [
                    Icon(Icons.wifi_off_rounded, size: 16, color: t.warning),
                    const SizedBox(width: AppSpace.sm),
                    Expanded(
                      child: Text(
                        s.orderVoidOfflineQueued,
                        style: ui(
                            size: 12,
                            weight: FontWeight.w600,
                            color: t.warning),
                      ),
                    ),
                  ]),
                ),
              ],
              SectionHeader(
                title: s.orderVoidReasonHeader,
                padding: const EdgeInsetsDirectional.only(
                    top: AppSpace.lg, bottom: AppSpace.sm),
              ),
              for (final r in _reasons(s)) ...[
                _ReasonTile(
                  label: r.$2,
                  selected: form.reason == r.$1,
                  onTap: () => _form.selectReason(r.$1),
                ),
                // 'Other' free-text field, nested under its option.
                if (r.$1 == 'other')
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    alignment: AlignmentDirectional.topStart,
                    child: form.reason == 'other'
                        ? Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 30, bottom: AppSpace.sm),
                            child: IntrinsicHeight(
                              child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      width: 2,
                                      margin: const EdgeInsetsDirectional.only(
                                          end: AppSpace.md),
                                      decoration: BoxDecoration(
                                        color: t.danger.withOpacity(0.35),
                                        borderRadius:
                                            BorderRadius.circular(1),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: _otherCtrl,
                                        style: ui(size: 14),
                                        decoration: InputDecoration(
                                          hintText: s.orderVoidDescribeHint,
                                          isDense: true,
                                        ),
                                        onChanged: (_) {
                                          final hasError = ref
                                                  .read(_voidFormProvider(
                                                      widget.order.id))
                                                  .error !=
                                              null;
                                          if (hasError) _form.clearError();
                                        },
                                      ),
                                    ),
                                  ]),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
              ],
              const SizedBox(height: AppSpace.sm),
              const Divider(),
              const SizedBox(height: AppSpace.md),
              Row(children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.orderVoidRestoreTitle,
                            style: ui(size: 14, weight: FontWeight.w700)),
                        const SizedBox(height: 2),
                        Text(s.orderVoidRestoreBody,
                            style: ui(size: 12, color: t.textSecondary)),
                      ]),
                ),
                Switch(
                  value: form.restore,
                  onChanged: _form.setRestore,
                ),
              ]),
              if (form.error != null) ...[
                const SizedBox(height: AppSpace.md),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpace.md),
                  decoration: BoxDecoration(
                    color: t.dangerBg,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(color: t.danger.withOpacity(0.25)),
                  ),
                  child: Row(children: [
                    Icon(Icons.error_outline_rounded,
                        size: 16, color: t.danger),
                    const SizedBox(width: AppSpace.sm),
                    Expanded(
                      child: Text(form.error!,
                          style: ui(
                              size: 12,
                              weight: FontWeight.w600,
                              color: t.danger)),
                    ),
                  ]),
                ),
              ],
              const SizedBox(height: AppSpace.xl),
              Row(children: [
                Expanded(
                  child: AppButton(
                    label: s.cancelAction,
                    variant: BtnVariant.outline,
                    onTap: form.loading ? null : () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: AppSpace.md),
                Expanded(
                  child: AppButton(
                    label: isOnline ? s.orderVoidAction : s.orderQueueVoid,
                    variant: BtnVariant.danger,
                    loading: form.loading,
                    onTap: form.loading ? null : _submit,
                  ),
                ),
              ]),
            ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  REASON TILE (custom radio row)
// ─────────────────────────────────────────────────────────────────────────────

class _ReasonTile extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _ReasonTile(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return AnimatedPressScale(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: AppSpace.sm),
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpace.md, vertical: AppSpace.md),
        decoration: BoxDecoration(
          color: selected ? t.dangerBg : t.surface,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(
              color: selected ? t.danger.withOpacity(0.45) : t.border),
        ),
        child: Row(children: [
          // Radio indicator
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: selected ? t.danger : t.textMuted, width: 2),
            ),
            alignment: Alignment.center,
            child: selected
                ? Container(
                    width: 8,
                    height: 8,
                    decoration:
                        BoxDecoration(color: t.danger, shape: BoxShape.circle),
                  )
                : null,
          ),
          const SizedBox(width: AppSpace.md),
          Expanded(
            child: Text(label,
                style: ui(
                    size: 14,
                    weight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: t.textPrimary)),
          ),
        ]),
      ),
    );
  }
}
