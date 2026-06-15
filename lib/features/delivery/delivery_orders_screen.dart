import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/models/branch.dart';
import '../../core/models/delivery_order.dart';
import '../../core/models/payment_method.dart';
import '../../core/providers/auth_notifier.dart';
import '../../core/providers/delivery_orders_notifier.dart';
import '../../core/providers/delivery_settings_notifier.dart';
import '../../core/providers/payment_method_notifier.dart';
import '../../core/providers/shift_notifier.dart';
import '../../core/repositories/delivery_order_repository.dart';
import '../../core/services/printer_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatting.dart';
import '../../shared/widgets/app_top_bar.dart';
import '../../shared/widgets/empty_state.dart';
import '../../core/services/notification_service.dart';
import '../../shared/widgets/new_order_banner.dart';
import '../../shared/widgets/offline_banner.dart';
import '../../shared/widgets/refresh_button.dart';
import '../../shared/widgets/status_chip.dart';
import '../../shared/widgets/surface_card.dart';
import '../../shared/widgets/sync_status_chip.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  STATUS FILTER — a chip row mirroring order_history_screen's _SyncFilter.
// ─────────────────────────────────────────────────────────────────────────────

enum _Filter { active, received, preparing, ready, outForDelivery, done }

extension on _Filter {
  String get label => switch (this) {
        _Filter.active => 'Active',
        _Filter.received => 'New',
        _Filter.preparing => 'Preparing',
        _Filter.ready => 'Ready',
        _Filter.outForDelivery => 'On the way',
        _Filter.done => 'Completed',
      };

  IconData get icon => switch (this) {
        _Filter.active => Icons.local_shipping_rounded,
        _Filter.received => Icons.fiber_new_rounded,
        _Filter.preparing => Icons.soup_kitchen_rounded,
        _Filter.ready => Icons.shopping_bag_rounded,
        _Filter.outForDelivery => Icons.delivery_dining_rounded,
        _Filter.done => Icons.check_circle_outline_rounded,
      };

  ChipTone get activeTone => switch (this) {
        _Filter.active => ChipTone.accent,
        _Filter.received => ChipTone.warning,
        _Filter.preparing => ChipTone.info,
        _Filter.ready => ChipTone.success,
        _Filter.outForDelivery => ChipTone.accent,
        _Filter.done => ChipTone.neutral,
      };

  bool matches(DeliveryOrder o) => switch (this) {
        _Filter.active => o.status.isActive,
        _Filter.received => o.status == DeliveryStatus.received,
        _Filter.preparing => o.status == DeliveryStatus.confirmed ||
            o.status == DeliveryStatus.preparing,
        _Filter.ready => o.status == DeliveryStatus.ready,
        _Filter.outForDelivery => o.status == DeliveryStatus.outForDelivery,
        _Filter.done => o.status.isTerminal,
      };
}

({String label, ChipTone tone, IconData icon}) _statusChip(DeliveryStatus s) =>
    switch (s) {
      DeliveryStatus.received =>
        (label: 'New', tone: ChipTone.warning, icon: Icons.fiber_new_rounded),
      DeliveryStatus.confirmed =>
        (label: 'Confirmed', tone: ChipTone.info, icon: Icons.check_rounded),
      DeliveryStatus.preparing => (
          label: 'Preparing',
          tone: ChipTone.info,
          icon: Icons.soup_kitchen_rounded
        ),
      DeliveryStatus.ready => (
          label: 'Ready',
          tone: ChipTone.success,
          icon: Icons.shopping_bag_rounded
        ),
      DeliveryStatus.outForDelivery => (
          label: 'On the way',
          tone: ChipTone.accent,
          icon: Icons.delivery_dining_rounded
        ),
      DeliveryStatus.delivered => (
          label: 'Delivered',
          tone: ChipTone.success,
          icon: Icons.check_circle_rounded
        ),
      DeliveryStatus.cancelled => (
          label: 'Cancelled',
          tone: ChipTone.danger,
          icon: Icons.cancel_outlined
        ),
      DeliveryStatus.rejected =>
        (label: 'Rejected', tone: ChipTone.danger, icon: Icons.block_rounded),
      DeliveryStatus.unknown =>
        (label: 'Unknown', tone: ChipTone.neutral, icon: Icons.help_outline),
    };

// Ephemeral filter view-state, pinned by the screen.
class _ViewNotifier extends AutoDisposeNotifier<_Filter> {
  @override
  _Filter build() => _Filter.active;
  void setFilter(_Filter f) => state = f;
}

final _filterProvider =
    NotifierProvider.autoDispose<_ViewNotifier, _Filter>(_ViewNotifier.new);

// ─────────────────────────────────────────────────────────────────────────────
//  SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class DeliveryOrdersScreen extends ConsumerStatefulWidget {
  const DeliveryOrdersScreen({super.key});
  @override
  ConsumerState<DeliveryOrdersScreen> createState() =>
      _DeliveryOrdersScreenState();
}

class _DeliveryOrdersScreenState extends ConsumerState<DeliveryOrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // NB: opening the queue must NOT clear the new-order alert — the teller
      // has to ACCEPT the order for that (handled in _confirm/_run). Merely
      // viewing leaves the banner + OS notification in place.
      _load();
    });
  }

  String? get _branchId =>
      ref.read(authProvider).user?.branchId ?? ref.read(authProvider).branch?.id;

  Future<void> _load() async {
    final branchId = _branchId;
    if (branchId == null) return;
    // Pull the channel accepting state alongside the queue (fire-and-forget;
    // a settings failure must not block the orders list).
    ref.read(deliverySettingsProvider.notifier).load(branchId);
    await ref
        .read(deliveryOrdersProvider.notifier)
        .loadForBranch(branchId, force: true);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    ref.listen(_filterProvider, (_, __) {}); // pin to the screen lifetime
    final st = ref.watch(deliveryOrdersProvider);
    final shift = ref.watch(shiftProvider.select((s) => s.shift));

    final Widget body;
    if (shift == null) {
      body = const EmptyState(
        icon: Icons.lock_outline_rounded,
        title: 'No open shift',
        body: 'Open a shift to take delivery orders.',
      );
    } else if (st.isLoading && st.orders.isEmpty) {
      body = const Center(child: CircularProgressIndicator());
    } else if (st.error != null && st.orders.isEmpty) {
      body = ErrorState(message: st.error!, onRetry: _load);
    } else if (st.orders.isEmpty) {
      body = const EmptyState(
        icon: Icons.delivery_dining_rounded,
        title: 'No delivery orders yet',
        body: 'New orders will appear here as they come in.',
      );
    } else {
      body = _Content(orders: st.orders);
    }

    return Scaffold(
      backgroundColor: t.bg,
      body: Column(children: [
        AppTopBar(
          title: 'Delivery Orders',
          subtitle: shift == null ? null : '${st.activeCount} active',
          actions: [
            const SyncStatusChip(),
            const SizedBox(width: AppSpace.sm),
            RefreshButton(
              enabled: shift != null,
              loading: st.isLoading,
              onTap: shift == null
                  ? () {}
                  : () => ref.read(deliveryOrdersProvider.notifier).refresh(),
            ),
          ],
        ),
        Expanded(child: body),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  CONTENT — filter row + card list.
// ─────────────────────────────────────────────────────────────────────────────

class _Content extends ConsumerWidget {
  final List<DeliveryOrder> orders;
  const _Content({required this.orders});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(_filterProvider);
    final visible = orders.where(filter.matches).toList();

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpace.lg, AppSpace.md, AppSpace.lg, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const OfflineBanner(),
          const _ChannelAcceptingBar(),
          _FilterRow(orders: orders),
        ]),
      ),
      const SizedBox(height: AppSpace.md),
      Expanded(
        child: visible.isEmpty
            ? EmptyState(
                icon: Icons.filter_alt_off_rounded,
                title: 'Nothing here',
                body: 'No orders match "${filter.label}".',
              )
            : ListView.builder(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpace.lg, 0, AppSpace.lg, AppSpace.lg),
                itemCount: visible.length,
                itemBuilder: (context, i) => _DeliveryCard(order: visible[i]),
              ),
      ),
    ]);
  }
}

class _FilterRow extends ConsumerWidget {
  final List<DeliveryOrder> orders;
  const _FilterRow({required this.orders});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(_filterProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        for (final f in _Filter.values) ...[
          StatusChip(
            label: '${f.label} · ${orders.where(f.matches).length}',
            icon: f.icon,
            tone: filter == f ? f.activeTone : ChipTone.neutral,
            onTap: () => ref.read(_filterProvider.notifier).setFilter(f),
          ),
          const SizedBox(width: AppSpace.sm),
        ],
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  CHANNEL ACCEPTING — teller toggle for in-mall / outside (auto/open/closed).
//  Mirrors backend POST /delivery/accepting. Only channels the dashboard has
//  enabled are shown (the POS can't open a disabled channel). Hidden entirely
//  until settings load and while no channel is enabled.
// ─────────────────────────────────────────────────────────────────────────────

class _ChannelAcceptingBar extends ConsumerWidget {
  const _ChannelAcceptingBar();

  String? _branchId(WidgetRef ref) =>
      ref.read(authProvider).user?.branchId ?? ref.read(authProvider).branch?.id;

  Future<void> _set(
      BuildContext context, WidgetRef ref, String channel, String mode) async {
    final branchId = _branchId(ref);
    if (branchId == null) return;
    try {
      await ref
          .read(deliverySettingsProvider.notifier)
          .setMode(branchId, channel, mode);
    } catch (e) {
      if (!context.mounted) return;
      final msg = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg.startsWith('Exception: ') ? msg.substring(11) : msg),
        backgroundColor: context.tokens.danger,
      ));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final v = ref.watch(deliverySettingsProvider);
    final s = v.settings;
    final t = context.tokens;
    if (s == null) {
      // Settings failed to load (e.g. a 403). Don't vanish silently — surface
      // the reason so a permission/branch problem is visible, not a missing bar.
      if (v.error != null) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(top: AppSpace.sm),
          child: SurfaceCard(
            padding: const EdgeInsets.all(AppSpace.md),
            child: Row(children: [
              Icon(Icons.error_outline_rounded, size: 16, color: t.danger),
              const SizedBox(width: AppSpace.sm),
              Expanded(
                child: Text(
                  'Accepting controls unavailable: ${v.error}',
                  style: ui(size: 12, weight: FontWeight.w600, color: t.danger),
                ),
              ),
            ]),
          ),
        );
      }
      return const SizedBox.shrink();
    }
    if (!s.anyEnabled) return const SizedBox.shrink();

    Widget channelRow(String channel, String label, IconData icon) {
      if (!s.enabledFor(channel)) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsetsDirectional.only(top: AppSpace.sm),
        child: Row(children: [
          Icon(icon, size: 16, color: t.textSecondary),
          const SizedBox(width: AppSpace.sm),
          Expanded(
              child: Text(label,
                  style: ui(size: 13, weight: FontWeight.w600))),
          _ModeSegments(
            mode: s.overrideFor(channel),
            onPick: (m) => _set(context, ref, channel, m),
          ),
        ]),
      );
    }

    return Padding(
      padding: const EdgeInsetsDirectional.only(top: AppSpace.sm),
      child: SurfaceCard(
        padding: const EdgeInsets.all(AppSpace.md),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            Icon(Icons.tune_rounded, size: 14, color: t.textMuted),
            const SizedBox(width: AppSpace.xs),
            Text('ACCEPTING ORDERS',
                style: ui(
                    size: 10,
                    weight: FontWeight.w800,
                    color: t.textMuted,
                    letterSpacing: 0.6)),
          ]),
          channelRow('in_mall', 'In-mall', Icons.storefront_rounded),
          channelRow('outside', 'Outside', Icons.pedal_bike_rounded),
        ]),
      ),
    );
  }
}

/// Three-state segmented control: Auto · Open · Closed. The active segment is
/// tinted by meaning (open=success, closed=danger, auto=accent).
class _ModeSegments extends StatelessWidget {
  final String mode; // auto | open | closed
  final ValueChanged<String> onPick;
  const _ModeSegments({required this.mode, required this.onPick});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;

    Widget seg(String value, String label) {
      final active = mode == value;
      final activeBg = switch (value) {
        'open' => t.success,
        'closed' => t.danger,
        _ => t.accent,
      };
      return AnimatedPressScale(
        onTap: active ? null : () => onPick(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding:
              const EdgeInsetsDirectional.symmetric(horizontal: 11, vertical: 6),
          decoration: BoxDecoration(
            color: active ? activeBg : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.xs),
          ),
          child: Text(label,
              style: ui(
                  size: 11,
                  weight: FontWeight.w700,
                  color: active ? Colors.white : t.textSecondary)),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: t.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: t.borderLight),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        seg('auto', 'Auto'),
        seg('open', 'Open'),
        seg('closed', 'Closed'),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  CARD — one delivery order with its per-status actions.
// ─────────────────────────────────────────────────────────────────────────────

class _DeliveryCard extends ConsumerStatefulWidget {
  final DeliveryOrder order;
  const _DeliveryCard({required this.order});

  @override
  ConsumerState<_DeliveryCard> createState() => _DeliveryCardState();
}

class _DeliveryCardState extends ConsumerState<_DeliveryCard> {
  bool _busy = false;

  DeliveryOrder get order => widget.order;

  Future<void> _run(Future<DeliveryOrder> Function() action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final updated = await action();
      await ref.read(deliveryOrdersProvider.notifier).upsertOrder(updated);
      _clearNewOrderAlert(updated);
    } catch (e) {
      _snack(_friendly(e), context.tokens.danger);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Once an order has been acted on (accepted, rejected, or otherwise advanced
  /// past `received`), stop alerting for it: drop the orders-screen banner and
  /// clear the OS notification. The banner also hides reactively, but this
  /// keeps the provider state and the notification center tidy. No-op while the
  /// order is still awaiting acceptance, so merely viewing never clears it.
  void _clearNewOrderAlert(DeliveryOrder o) {
    if (o.status == DeliveryStatus.received) return;
    NotificationService.instance.cancel(o.id);
    ref.read(newOrderBannerProvider.notifier).dismissFor(o.id);
  }

  /// Confirm == the accept step. Print the customer receipt once (if a printer
  /// is configured and it hasn't been printed yet), then advance to confirmed.
  Future<void> _confirm() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await _maybePrintReceipt(); // print-once from the snapshot, BEFORE advancing
      final updated = await ref
          .read(deliveryOrderRepositoryProvider)
          .setStatus(order.id, DeliveryStatus.confirmed);
      await ref.read(deliveryOrdersProvider.notifier).upsertOrder(updated);
      _clearNewOrderAlert(updated);
    } catch (e) {
      _snack(_friendly(e), context.tokens.danger);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _maybePrintReceipt() async {
    if (order.receiptPrinted) return; // already printed once
    final branch = ref.read(authProvider).branch;
    if (branch == null || !branch.hasPrinter) return;
    final err = await PrinterService.printDeliveryReceipt(
      ip: branch.printerIp!,
      port: branch.printerPort ?? 9100,
      brand: branch.printerBrand!,
      order: order,
      branchName: branch.name,
      logoUrl: branch.orgLogoUrl,
    );
    if (err != null && mounted) {
      _snack('Receipt print failed: $err', context.tokens.warning);
    }
  }

  Future<void> _advance(DeliveryStatus to) => _run(
      () => ref.read(deliveryOrderRepositoryProvider).setStatus(order.id, to));

  /// Step the per-order extra prep time by ±5 minutes, floored at 0, and push
  /// the new absolute value (always a multiple of 5) to the server.
  Future<void> _stepPrepTime(int deltaMinutes) async {
    final next = order.extraPrepMinutes + deltaMinutes;
    final clamped = next < 0 ? 0 : next;
    if (clamped == order.extraPrepMinutes || _busy) return;
    setState(() => _busy = true);
    try {
      await ref
          .read(deliveryOrdersProvider.notifier)
          .setPrepTime(order.id, clamped);
    } catch (e) {
      _snack(_friendly(e), context.tokens.danger);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _finalize() async {
    final shift = ref.read(shiftProvider).shift;
    if (shift == null) {
      _snack('No open shift to finalize against.', context.tokens.danger);
      return;
    }
    final methods = ref.read(paymentMethodProvider).items;
    final picked = await _FinalizeSheet.show(context, order, methods);
    if (picked == null || _busy) return;

    setState(() => _busy = true);
    try {
      final res = await ref.read(deliveryOrderRepositoryProvider).finalize(
            order.id,
            shiftId: shift.id,
            paymentMethod: picked,
          );
      await ref
          .read(deliveryOrdersProvider.notifier)
          .upsertOrder(res.deliveryOrder);
      if (!mounted) return;
      if (res.warnings.isNotEmpty) {
        _snack(res.warnings.join('\n'), context.tokens.warning);
      } else {
        _snack(
            res.orderRef != null
                ? 'Finalized as ${res.orderRef}'
                : 'Order finalized',
            context.tokens.success);
      }
    } catch (e) {
      _snack(_friendly(e), context.tokens.danger);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _cancel({required bool isReject}) async {
    final result = await _CancelSheet.show(context, isReject: isReject);
    if (result == null) return;
    await _run(() => ref.read(deliveryOrderRepositoryProvider).cancel(
          order.id,
          reason: result.reason,
          restoreInventory: result.restoreInventory,
        ));
  }

  void _snack(String msg, Color color) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }

  // friendlyError lives in api/client.dart; the screen avoids importing the Dio
  // layer directly, so a thin local wrapper keeps messages consistent.
  String _friendly(Object e) {
    final s = e.toString();
    return s.startsWith('Exception: ') ? s.substring(11) : s;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = _statusChip(order.status);

    return SurfaceCard(
      margin: const EdgeInsets.only(bottom: AppSpace.md),
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        // Header: ref + time + channel + status.
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpace.lg, AppSpace.md, AppSpace.lg, AppSpace.sm),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.deliveryRef ?? 'Delivery',
                      style: ui(
                          size: 15,
                          weight: FontWeight.w800,
                          color: t.textPrimary)),
                  const SizedBox(height: 2),
                  Text(timeShort(order.createdAt),
                      style: ui(size: 11, color: t.textMuted)),
                ],
              ),
            ),
            StatusChip(
                label: order.isInMall ? 'In-mall' : 'Outside',
                icon: order.isInMall
                    ? Icons.storefront_rounded
                    : Icons.map_rounded,
                tone: ChipTone.neutral),
            const SizedBox(width: AppSpace.sm),
            StatusChip(label: s.label, icon: s.icon, tone: s.tone),
          ]),
        ),
        const Divider(height: 1),

        _CustomerBlock(order: order),
        const Divider(height: 1),

        ...order.cart.lines.map((l) => _LineRow(line: l)),

        _TotalsBlock(order: order),

        if (order.paymentMethodHint != null || order.cancelReason != null)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpace.lg, 0, AppSpace.lg, AppSpace.sm),
            child: Wrap(spacing: AppSpace.sm, runSpacing: AppSpace.xs, children: [
              if (order.paymentMethodHint != null)
                StatusChip(
                    label: _hintLabel(order.paymentMethodHint!),
                    icon: Icons.payments_outlined,
                    tone: ChipTone.info),
              if (order.cancelReason != null)
                StatusChip(
                    label: order.cancelReason!,
                    icon: Icons.info_outline_rounded,
                    tone: ChipTone.danger),
            ]),
          ),

        if (order.status.isActive) ...[
          const Divider(height: 1),
          _PrepTimeControl(
            extraPrepMinutes: order.extraPrepMinutes,
            busy: _busy,
            onDecrement:
                order.extraPrepMinutes <= 0 ? null : () => _stepPrepTime(-5),
            onIncrement: () => _stepPrepTime(5),
          ),
          const Divider(height: 1),
          _Actions(
            order: order,
            busy: _busy,
            onConfirm: _confirm,
            onReject: () => _cancel(isReject: true),
            onAdvance: _advance,
            onFinalize: _finalize,
            onCancel: () => _cancel(isReject: false),
          ),
        ],
      ]),
    );
  }

  String _hintLabel(String raw) {
    final methods = ref.read(paymentMethodProvider).items;
    final locale = Localizations.localeOf(context).languageCode;
    final m = methods.where((p) => p.wireFormat == raw).firstOrNull;
    if (m != null) return m.label(locale);
    return raw.isEmpty
        ? raw
        : raw[0].toUpperCase() + raw.substring(1).replaceAll('_', ' ');
  }
}

// ── Customer block ───────────────────────────────────────────────────────────

class _CustomerBlock extends StatelessWidget {
  final DeliveryOrder order;
  const _CustomerBlock({required this.order});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final addr = <String>[
      if (order.placeName?.isNotEmpty ?? false) order.placeName!,
      if (order.floor?.isNotEmpty ?? false) 'Floor ${order.floor}',
      if (order.unitNumber?.isNotEmpty ?? false) 'Unit ${order.unitNumber}',
      if (order.addressLine?.isNotEmpty ?? false) order.addressLine!,
      if (order.landmark?.isNotEmpty ?? false) order.landmark!,
    ];
    final distanceKm = order.roadDistanceMeters != null
        ? (order.roadDistanceMeters! / 1000).toStringAsFixed(1)
        : null;

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpace.lg, vertical: AppSpace.sm),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(Icons.person_outline_rounded, size: 14, color: t.textMuted),
          const SizedBox(width: AppSpace.xs),
          Expanded(
            child: Text(order.customerName,
                style: ui(size: 13, weight: FontWeight.w700)),
          ),
          if (order.otpVerified) ...[
            Icon(Icons.verified_rounded, size: 13, color: t.success),
            const SizedBox(width: AppSpace.xs),
          ],
          Icon(Icons.phone_outlined, size: 13, color: t.textMuted),
          const SizedBox(width: AppSpace.xs),
          Text(order.customerPhone, style: ui(size: 12, color: t.textSecondary)),
        ]),
        if (addr.isNotEmpty) ...[
          const SizedBox(height: AppSpace.xs),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(Icons.location_on_outlined, size: 14, color: t.textMuted),
            const SizedBox(width: AppSpace.xs),
            Expanded(
              child: Text(addr.join(' · '),
                  style: ui(size: 12, color: t.textSecondary)),
            ),
            if (distanceKm != null)
              Text('$distanceKm km',
                  style: ui(size: 11, weight: FontWeight.w600, color: t.textMuted)),
          ]),
        ],
        if (order.deliveryNotes?.isNotEmpty ?? false) ...[
          const SizedBox(height: AppSpace.xs),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(Icons.sticky_note_2_outlined, size: 14, color: t.warning),
            const SizedBox(width: AppSpace.xs),
            Expanded(
              child: Text(order.deliveryNotes!,
                  style: ui(size: 12, color: t.textSecondary)),
            ),
          ]),
        ],
      ]),
    );
  }
}

// ── Cart line row ────────────────────────────────────────────────────────────

class _LineRow extends StatelessWidget {
  final DeliveryCartLine line;
  const _LineRow({required this.line});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpace.lg, vertical: AppSpace.sm),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: t.navyBg,
            borderRadius: BorderRadius.circular(AppRadius.xs),
          ),
          alignment: Alignment.center,
          child: Text('${line.quantity}',
              style: ui(size: 12, weight: FontWeight.w700, color: t.navy)),
        ),
        const SizedBox(width: AppSpace.sm),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              line.itemName +
                  (line.sizeLabel != null
                      ? ' · ${normaliseName(line.sizeLabel!)}'
                      : ''),
              style: ui(size: 13, weight: FontWeight.w600),
            ),
            if (line.addons.isNotEmpty || line.optionals.isNotEmpty) ...[
              const SizedBox(height: 4),
              Wrap(spacing: 4, runSpacing: 3, children: [
                ...line.addons.map((a) => _Chip(
                      label: a.unitPrice > 0
                          ? '${normaliseName(a.addonName)} +${egp(a.unitPrice)}'
                          : normaliseName(a.addonName),
                      fg: t.accent,
                      bg: t.accentBg,
                    )),
                ...line.optionals.map((o) => _Chip(
                      label: o.price > 0
                          ? '${normaliseName(o.fieldName)} +${egp(o.price)}'
                          : normaliseName(o.fieldName),
                      fg: t.warning,
                      bg: t.warningBg,
                    )),
              ]),
            ],
            if (line.notes?.isNotEmpty ?? false) ...[
              const SizedBox(height: 3),
              Text('“${line.notes!}”',
                  style: ui(size: 11, color: t.textMuted)
                      .copyWith(fontStyle: FontStyle.italic)),
            ],
          ]),
        ),
        const SizedBox(width: AppSpace.sm),
        Text(egp(line.lineTotal),
            style: money(size: 13, weight: FontWeight.w600)),
      ]),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color fg;
  final Color bg;
  const _Chip({required this.label, required this.fg, required this.bg});

  @override
  Widget build(BuildContext context) => Container(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 7, vertical: 2),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
        child: Text(label,
            style: ui(size: 11, weight: FontWeight.w600, color: fg)),
      );
}

// ── Totals block ─────────────────────────────────────────────────────────────

class _TotalsBlock extends StatelessWidget {
  final DeliveryOrder order;
  const _TotalsBlock({required this.order});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    Widget row(String l, String v, {bool strong = false}) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(l,
                style: strong
                    ? ui(size: 14, weight: FontWeight.w700)
                    : ui(size: 13, color: t.textSecondary)),
            Text(v,
                style: money(
                    size: strong ? 16 : 13,
                    weight: strong ? FontWeight.w800 : FontWeight.w600,
                    color: t.textPrimary)),
          ]),
        );

    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpace.lg, AppSpace.sm, AppSpace.lg, AppSpace.md),
      decoration:
          BoxDecoration(border: Border(top: BorderSide(color: t.borderLight))),
      child: Column(children: [
        row('Subtotal', egp(order.subtotal)),
        if (order.discountAmount > 0) row('Discount', '- ${egp(order.discountAmount)}'),
        if (order.deliveryFee > 0) row('Delivery fee', egp(order.deliveryFee)),
        const SizedBox(height: 4),
        row('Total', egp(order.total), strong: true),
      ]),
    );
  }
}

// ── Prep-time stepper (per-order extra minutes, multiples of 5) ───────────────

class _PrepTimeControl extends StatelessWidget {
  final int extraPrepMinutes;
  final bool busy;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;

  const _PrepTimeControl({
    required this.extraPrepMinutes,
    required this.busy,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpace.lg, vertical: AppSpace.sm),
      child: Row(children: [
        Icon(Icons.timer_outlined, size: 15, color: t.textMuted),
        const SizedBox(width: AppSpace.xs),
        Expanded(
          child: Text(
            extraPrepMinutes > 0 ? '+$extraPrepMinutes min prep' : 'No extra prep',
            style: ui(
                size: 13,
                weight: FontWeight.w700,
                color: extraPrepMinutes > 0 ? t.textPrimary : t.textSecondary),
          ),
        ),
        _StepBtn(icon: Icons.remove_rounded, onTap: busy ? null : onDecrement),
        const SizedBox(width: AppSpace.sm),
        _StepBtn(icon: Icons.add_rounded, onTap: busy ? null : onIncrement),
      ]),
    );
  }
}

class _StepBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _StepBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final body = Container(
      width: 34,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: t.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.xs),
        border: Border.all(color: t.border),
      ),
      child: Icon(icon,
          size: 18, color: onTap == null ? t.textMuted : t.textPrimary),
    );
    return onTap == null
        ? Opacity(opacity: 0.5, child: body)
        : AnimatedPressScale(onTap: onTap, child: body);
  }
}

// ── Action bar (per-status) ──────────────────────────────────────────────────

class _Actions extends StatelessWidget {
  final DeliveryOrder order;
  final bool busy;
  final VoidCallback onConfirm;
  final VoidCallback onReject;
  final void Function(DeliveryStatus to) onAdvance;
  final VoidCallback onFinalize;
  final VoidCallback onCancel;

  const _Actions({
    required this.order,
    required this.busy,
    required this.onConfirm,
    required this.onReject,
    required this.onAdvance,
    required this.onFinalize,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;

    final List<Widget> actions = switch (order.status) {
      DeliveryStatus.received => [
          _Btn(
              label: 'Reject',
              icon: Icons.block_rounded,
              bg: t.dangerBg,
              fg: t.danger,
              onTap: busy ? null : onReject),
          _Btn(
              label: 'Confirm',
              icon: Icons.check_rounded,
              bg: t.navy,
              fg: Colors.white,
              primary: true,
              onTap: busy ? null : onConfirm),
        ],
      DeliveryStatus.confirmed => [
          _Btn(
              label: 'Cancel',
              icon: Icons.cancel_outlined,
              bg: t.dangerBg,
              fg: t.danger,
              onTap: busy ? null : onCancel),
          _Btn(
              label: 'Start preparing',
              icon: Icons.soup_kitchen_rounded,
              bg: t.navy,
              fg: Colors.white,
              primary: true,
              onTap: busy ? null : () => onAdvance(DeliveryStatus.preparing)),
        ],
      DeliveryStatus.preparing => [
          _Btn(
              label: 'Cancel',
              icon: Icons.cancel_outlined,
              bg: t.dangerBg,
              fg: t.danger,
              onTap: busy ? null : onCancel),
          _Btn(
              label: 'Mark ready',
              icon: Icons.shopping_bag_rounded,
              bg: t.navy,
              fg: Colors.white,
              primary: true,
              onTap: busy ? null : () => onAdvance(DeliveryStatus.ready)),
        ],
      DeliveryStatus.ready => [
          _Btn(
              label: 'Cancel',
              icon: Icons.cancel_outlined,
              bg: t.dangerBg,
              fg: t.danger,
              onTap: busy ? null : onCancel),
          _Btn(
              label: 'Out for delivery',
              icon: Icons.delivery_dining_rounded,
              bg: t.navy,
              fg: Colors.white,
              primary: true,
              onTap:
                  busy ? null : () => onAdvance(DeliveryStatus.outForDelivery)),
        ],
      DeliveryStatus.outForDelivery => [
          _Btn(
              label: 'Cancel',
              icon: Icons.cancel_outlined,
              bg: t.dangerBg,
              fg: t.danger,
              onTap: busy ? null : onCancel),
          _Btn(
              label: 'Finalize',
              icon: Icons.point_of_sale_rounded,
              bg: t.success,
              fg: Colors.white,
              primary: true,
              onTap: busy ? null : onFinalize),
        ],
      _ => const [],
    };

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpace.lg, vertical: AppSpace.md),
      child: Row(children: [
        if (busy) ...[
          const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2)),
          const SizedBox(width: AppSpace.md),
        ],
        const Spacer(),
        for (var i = 0; i < actions.length; i++) ...[
          if (i > 0) const SizedBox(width: AppSpace.sm),
          actions[i],
        ],
      ]),
    );
  }
}

class _Btn extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color bg;
  final Color fg;
  final bool primary;
  final VoidCallback? onTap;

  const _Btn({
    required this.label,
    required this.icon,
    required this.bg,
    required this.fg,
    this.primary = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final body = Container(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: onTap == null ? bg.withOpacity(0.5) : bg,
        borderRadius: BorderRadius.circular(AppRadius.xs),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 15, color: fg),
        const SizedBox(width: 6),
        Text(label, style: ui(size: 13, weight: FontWeight.w700, color: fg)),
      ]),
    );
    return onTap == null
        ? Opacity(opacity: 0.6, child: body)
        : AnimatedPressScale(onTap: onTap, child: body);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  FINALIZE SHEET — pick the payment method (default = hint).
// ─────────────────────────────────────────────────────────────────────────────

class _FinalizeSheet extends ConsumerStatefulWidget {
  final DeliveryOrder order;
  final List<PaymentMethod> methods;
  const _FinalizeSheet({required this.order, required this.methods});

  static Future<String?> show(
    BuildContext context,
    DeliveryOrder order,
    List<PaymentMethod> methods,
  ) =>
      showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => _FinalizeSheet(order: order, methods: methods),
      );

  @override
  ConsumerState<_FinalizeSheet> createState() => _FinalizeSheetState();
}

class _FinalizeSheetState extends ConsumerState<_FinalizeSheet> {
  late String? _selected;

  /// Delivery is paid on delivery in cash or by card only — restrict the org's
  /// methods to those two (cash = any `is_cash` method; card = the card method).
  static bool _isCard(PaymentMethod m) =>
      m.wireFormat == 'card' || m.wireFormat == 'credit_card';
  List<PaymentMethod> get _methods =>
      widget.methods.where((m) => m.isCash || _isCard(m)).toList();

  @override
  void initState() {
    super.initState();
    final hint = widget.order.paymentMethodHint;
    final methods = _methods;
    // Default to the hinted method if it survives the cash/card filter, else first.
    if (hint != null && methods.any((m) => m.wireFormat == hint)) {
      _selected = hint;
    } else {
      _selected = methods.isNotEmpty ? methods.first.wireFormat : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final locale = Localizations.localeOf(context).languageCode;
    final mq = MediaQuery.of(context);

    return Container(
      decoration:
          BoxDecoration(color: t.bg, borderRadius: AppRadius.sheetRadius),
      padding: EdgeInsetsDirectional.fromSTEB(AppSpace.lg, AppSpace.md,
          AppSpace.lg, mq.padding.bottom + AppSpace.lg),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 36,
          height: 4,
          decoration: BoxDecoration(
              color: t.border, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(height: AppSpace.lg),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text('Finalize delivery',
              style: ui(size: 17, weight: FontWeight.w800)),
        ),
        const SizedBox(height: AppSpace.xs),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text('How did the customer pay?',
              style: ui(size: 13, color: t.textSecondary)),
        ),
        const SizedBox(height: AppSpace.md),

        // Totals breakdown so the teller confirms exactly what's charged.
        Container(
          padding: const EdgeInsets.all(AppSpace.md),
          decoration: BoxDecoration(
            color: t.surfaceAlt,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Column(children: [
            _finalizeRow(t, 'Subtotal', egp(widget.order.subtotal)),
            if (widget.order.discountAmount > 0)
              _finalizeRow(t, 'Discount', '- ${egp(widget.order.discountAmount)}'),
            if (widget.order.deliveryFee > 0)
              _finalizeRow(t, 'Delivery fee', egp(widget.order.deliveryFee)),
            Padding(
              padding: const EdgeInsets.only(top: AppSpace.xs),
              child: _finalizeRow(t, 'Total', egp(widget.order.total), strong: true),
            ),
          ]),
        ),
        const SizedBox(height: AppSpace.lg),

        if (_methods.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpace.md),
            child: Text('No cash or card payment method is configured.',
                style: ui(size: 13, color: t.textMuted)),
          )
        else
          LayoutBuilder(builder: (ctx, c) {
            final w = (c.maxWidth - AppSpace.sm) / 2;
            return Wrap(
              spacing: AppSpace.sm,
              runSpacing: AppSpace.sm,
              children: _methods.map((m) {
                final sel = _selected == m.wireFormat;
                return AnimatedPressScale(
                  onTap: () => setState(() => _selected = m.wireFormat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: w,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 16),
                    decoration: BoxDecoration(
                      // Selected wears the method's own brand colour (dashboard
                      // data), white content — mirrors the consumer checkout.
                      color: sel ? m.uiColor : t.surfaceAlt,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      border: Border.all(
                          color: sel ? m.uiColor : t.border,
                          width: sel ? 1.5 : 1),
                    ),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Icon(m.uiIcon,
                          size: 24, color: sel ? Colors.white : m.uiColor),
                      const SizedBox(height: AppSpace.sm),
                      Text(m.label(locale),
                          style: ui(
                              size: 14,
                              weight: FontWeight.w700,
                              color: sel ? Colors.white : t.textPrimary)),
                    ]),
                  ),
                );
              }).toList(),
            );
          }),
        const SizedBox(height: AppSpace.lg),
        Row(children: [
          Expanded(
            child: AnimatedPressScale(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: t.surfaceAlt,
                    borderRadius: BorderRadius.circular(AppRadius.sm)),
                child: Text('Cancel',
                    style: ui(size: 14, weight: FontWeight.w700)),
              ),
            ),
          ),
          const SizedBox(width: AppSpace.sm),
          Expanded(
            flex: 2,
            child: AnimatedPressScale(
              onTap: _selected == null
                  ? null
                  : () => Navigator.pop(context, _selected),
              child: Opacity(
                opacity: _selected == null ? 0.5 : 1,
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: t.success,
                      borderRadius: BorderRadius.circular(AppRadius.sm)),
                  child: Text('Finalize ${egp(widget.order.total)}',
                      style: ui(
                          size: 14,
                          weight: FontWeight.w800,
                          color: Colors.white)),
                ),
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}

/// One line of the finalize totals breakdown.
Widget _finalizeRow(AppTokens t, String label, String value, {bool strong = false}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label,
            style: strong
                ? ui(size: 14, weight: FontWeight.w800)
                : ui(size: 13, color: t.textSecondary)),
        Text(value,
            style: money(
                size: strong ? 16 : 13,
                weight: strong ? FontWeight.w800 : FontWeight.w600,
                color: t.textPrimary)),
      ]),
    );

// ─────────────────────────────────────────────────────────────────────────────
//  CANCEL SHEET — reason + restore-inventory / mark-as-waste toggle.
// ─────────────────────────────────────────────────────────────────────────────

class _CancelResult {
  final String? reason;
  final bool restoreInventory;
  const _CancelResult({this.reason, required this.restoreInventory});
}

class _CancelSheet extends StatefulWidget {
  final bool isReject;
  const _CancelSheet({required this.isReject});

  static Future<_CancelResult?> show(BuildContext context,
          {required bool isReject}) =>
      showModalBottomSheet<_CancelResult>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => _CancelSheet(isReject: isReject),
      );

  @override
  State<_CancelSheet> createState() => _CancelSheetState();
}

class _CancelSheetState extends State<_CancelSheet> {
  final _controller = TextEditingController();
  // Default: restore (food not made). A reject (pre-confirm) always restores —
  // nothing was prepared — so the toggle is hidden there.
  bool _restore = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final mq = MediaQuery.of(context);
    final title = widget.isReject ? 'Reject order' : 'Cancel order';

    return Container(
      decoration:
          BoxDecoration(color: t.bg, borderRadius: AppRadius.sheetRadius),
      padding: EdgeInsetsDirectional.fromSTEB(AppSpace.lg, AppSpace.md,
          AppSpace.lg, mq.viewInsets.bottom + mq.padding.bottom + AppSpace.lg),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 36,
          height: 4,
          decoration: BoxDecoration(
              color: t.border, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(height: AppSpace.lg),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(title, style: ui(size: 17, weight: FontWeight.w800)),
        ),
        const SizedBox(height: AppSpace.lg),
        TextField(
          controller: _controller,
          minLines: 2,
          maxLines: 4,
          style: ui(size: 14),
          decoration: InputDecoration(
            hintText: 'Reason (optional)',
            hintStyle: ui(size: 14, color: t.textMuted),
            filled: true,
            fillColor: t.surfaceAlt,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.sm),
              borderSide: BorderSide(color: t.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.sm),
              borderSide: BorderSide(color: t.border),
            ),
          ),
        ),
        if (!widget.isReject) ...[
          const SizedBox(height: AppSpace.md),
          Container(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpace.md, vertical: AppSpace.sm),
            decoration: BoxDecoration(
              color: t.surfaceAlt,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Row(children: [
              Icon(_restore ? Icons.inventory_2_outlined : Icons.delete_outline,
                  size: 18, color: _restore ? t.success : t.warning),
              const SizedBox(width: AppSpace.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_restore ? 'Restore inventory' : 'Mark as waste',
                        style: ui(size: 14, weight: FontWeight.w700)),
                    Text(
                      _restore
                          ? 'Food was not made — stock stays available.'
                          : 'Food was made — deduct stock & log as waste.',
                      style: ui(size: 11, color: t.textMuted),
                    ),
                  ],
                ),
              ),
              Switch(
                // Switch ON = restore inventory (the safe default).
                value: _restore,
                onChanged: (v) => setState(() => _restore = v),
              ),
            ]),
          ),
        ],
        const SizedBox(height: AppSpace.lg),
        Row(children: [
          Expanded(
            child: AnimatedPressScale(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: t.surfaceAlt,
                    borderRadius: BorderRadius.circular(AppRadius.sm)),
                child:
                    Text('Back', style: ui(size: 14, weight: FontWeight.w700)),
              ),
            ),
          ),
          const SizedBox(width: AppSpace.sm),
          Expanded(
            flex: 2,
            child: AnimatedPressScale(
              onTap: () => Navigator.pop(
                context,
                _CancelResult(
                  reason: _controller.text.trim().isEmpty
                      ? null
                      : _controller.text.trim(),
                  // A reject always restores (nothing was made).
                  restoreInventory: widget.isReject ? true : _restore,
                ),
              ),
              child: Container(
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: t.danger,
                    borderRadius: BorderRadius.circular(AppRadius.sm)),
                child: Text(widget.isReject ? 'Reject' : 'Cancel order',
                    style: ui(
                        size: 14, weight: FontWeight.w800, color: Colors.white)),
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}
