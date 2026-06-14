import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/api/client.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/providers/draft_carts_notifier.dart';
import '../../../core/repositories/order_repository.dart';
import '../../../core/utils/time_utils.dart';
import '../../../core/models/cart.dart';
import '../../../core/models/discount.dart';
import '../../../core/models/order.dart';
import '../../../core/models/pending_action.dart';
import '../../../core/models/shift.dart';
import '../../../core/providers/auth_notifier.dart';
import '../../../core/providers/cart_notifier.dart';
import '../../../core/providers/discount_notifier.dart';
import '../../../core/providers/order_history_notifier.dart';
import '../../../core/providers/shift_notifier.dart';
import '../../../core/services/connectivity_service.dart';
import '../../../core/services/offline_queue.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatting.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/offline_banner.dart';
import '../../../shared/widgets/responsive_sheet.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/status_chip.dart';
import '../../../shared/widgets/surface_card.dart';
import '../helpers/payment_helpers.dart';
import '../../../core/providers/payment_method_notifier.dart';
import '../widgets/receipt_sheet.dart';
import '../widgets/receipt_preview_sheet.dart';

import 'sections/discount_section.dart';
import 'sections/tip_section.dart';
import 'sections/cash_tendered_section.dart';
import 'sections/split_payment_section.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  SHEET-LOCAL UI STATE
//  Lives in an autoDispose provider so it resets every time the sheet closes —
//  same lifecycle the State fields had, without setState.
// ─────────────────────────────────────────────────────────────────────────────

@immutable
class _CheckoutUiState {
  final bool loading;
  final String? error;
  final Discount? selectedDiscount;
  final bool showTendered;
  final String tipPaymentMethod;
  final bool isSplit;
  final Set<String> activeSplitMethods;

  const _CheckoutUiState({
    this.loading = false,
    this.error,
    this.selectedDiscount,
    this.showTendered = false,
    this.tipPaymentMethod = '',
    this.isSplit = false,
    this.activeSplitMethods = const {},
  });

  _CheckoutUiState copyWith({
    bool? loading,
    String? error,
    bool clearError = false,
    Discount? selectedDiscount,
    bool clearDiscount = false,
    bool? showTendered,
    String? tipPaymentMethod,
    bool? isSplit,
    Set<String>? activeSplitMethods,
  }) =>
      _CheckoutUiState(
        loading: loading ?? this.loading,
        error: clearError ? null : (error ?? this.error),
        selectedDiscount:
            clearDiscount ? null : (selectedDiscount ?? this.selectedDiscount),
        showTendered: showTendered ?? this.showTendered,
        tipPaymentMethod: tipPaymentMethod ?? this.tipPaymentMethod,
        isSplit: isSplit ?? this.isSplit,
        activeSplitMethods: activeSplitMethods ?? this.activeSplitMethods,
      );
}

class _CheckoutUiNotifier extends AutoDisposeNotifier<_CheckoutUiState> {
  @override
  _CheckoutUiState build() {
    // Same seed as the old initState: cash payment shows the tendered field,
    // and the tip defaults to the order's payment method.
    final cart = ref.read(cartProvider);
    final methods = ref.read(paymentMethodProvider).items;
    return _CheckoutUiState(
      showTendered: isCashMethod(methods, cart.payment),
      tipPaymentMethod: cart.payment,
    );
  }

  void setError(String? message) => state = message == null
      ? state.copyWith(clearError: true)
      : state.copyWith(error: message);

  void startPlacing() =>
      state = state.copyWith(loading: true, clearError: true);

  /// Releases the Place Order button (`_place`'s `finally`).
  void setLoading(bool value) => state = state.copyWith(loading: value);

  void selectDiscount(Discount? discount) => state = discount == null
      ? state.copyWith(clearDiscount: true)
      : state.copyWith(selectedDiscount: discount);

  void setTipMethod(String method) =>
      state = state.copyWith(tipPaymentMethod: method);

  void paymentSelected(String method) {
    final methods = ref.read(paymentMethodProvider).items;
    state = state.copyWith(showTendered: isCashMethod(methods, method));
  }

  void toggleSplitMethod(String method) {
    final next = Set<String>.of(state.activeSplitMethods);
    if (!next.remove(method)) next.add(method);
    state = state.copyWith(activeSplitMethods: next);
  }

  void toggleSplitMode() {
    if (state.isSplit) {
      final methods = ref.read(paymentMethodProvider).items;
      final pay = ref.read(cartProvider).payment;
      state = state.copyWith(
        isSplit: false,
        activeSplitMethods: const {},
        showTendered: isCashMethod(methods, pay),
      );
    } else {
      state = state.copyWith(isSplit: true, showTendered: false);
    }
  }
}

final _checkoutUiProvider =
    NotifierProvider.autoDispose<_CheckoutUiNotifier, _CheckoutUiState>(
        _CheckoutUiNotifier.new);

class CheckoutSheet extends ConsumerStatefulWidget {
  const CheckoutSheet({super.key});

  static Future<void> show(BuildContext ctx) => ResponsiveSheet.show(
      context: ctx,
      builder: (_) => const CheckoutSheet());

  @override
  ConsumerState<CheckoutSheet> createState() => _CheckoutSheetState();
}

class _CheckoutSheetState extends ConsumerState<CheckoutSheet> {
  final _customerCtrl = TextEditingController();
  final _tenderedCtrl = TextEditingController();
  final _tipCtrl = TextEditingController();
  final Map<String, TextEditingController> _splitCtrs = {};

  _CheckoutUiNotifier get _ui => ref.read(_checkoutUiProvider.notifier);

  @override
  void initState() {
    super.initState();
    final cart = ref.read(cartProvider);
    if (cart.customerName != null && cart.customerName!.isNotEmpty) {
      _customerCtrl.text = cart.customerName!;
    }
    if (cart.amountTendered != null && cart.amountTendered! > 0) {
      _tenderedCtrl.text = (cart.amountTendered! / 100).toStringAsFixed(2);
    }
    if (cart.tipAmount != null && cart.tipAmount! > 0) {
      _tipCtrl.text = (cart.tipAmount! / 100).toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _customerCtrl.dispose();
    _tenderedCtrl.dispose();
    _tipCtrl.dispose();
    for (final c in _splitCtrs.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _toggleSplitMethod(String method) {
    // Controllers stay owned by the State; only the active set is provider
    // state.
    if (ref.read(_checkoutUiProvider).activeSplitMethods.contains(method)) {
      _splitCtrs[method]?.clear();
    } else {
      _splitCtrs.putIfAbsent(method, () => TextEditingController());
    }
    _ui.toggleSplitMethod(method);
  }

  void _toggleSplitMode() {
    // Leaving split mode wipes the per-method amounts, like before.
    if (ref.read(_checkoutUiProvider).isSplit) {
      for (final c in _splitCtrs.values) {
        c.clear();
      }
    }
    _ui.toggleSplitMode();
  }

  List<PaymentSplit> _buildSplits(Set<String> activeSplitMethods) {
    final splits = <PaymentSplit>[];
    for (final method in activeSplitMethods) {
      final raw = double.tryParse(_splitCtrs[method]?.text ?? '');
      if (raw != null && raw > 0) {
        splits.add(PaymentSplit(method: method, amount: (raw * 100).round()));
      }
    }
    return splits;
  }

  int? get _parsedTip {
    final v = double.tryParse(_tipCtrl.text);
    if (v == null || v <= 0) return null;
    return (v * 100).round();
  }

  bool get _tipIsCash {
    final methods = ref.read(paymentMethodProvider).items;
    return isCashMethod(
        methods, ref.read(_checkoutUiProvider).tipPaymentMethod);
  }

  void _retryPaymentMethods() {
    final orgId = ref.read(authProvider).user?.orgId;
    if (orgId == null) return;
    unawaited(
        ref.read(paymentMethodProvider.notifier).load(orgId, force: true));
  }

  void _syncCheckoutToCart({
    required String? customer,
    required String paymentMethod,
    required int? tendered,
    required int? tip,
    required List<PaymentSplit>? splits,
    required DiscountType? discountType,
    required int? discountValue,
    required String? discountId,
  }) {
    ref.read(cartProvider.notifier).applyCheckoutFields(
          customerName: customer,
          amountTendered: tendered,
          tipAmount: tip,
          paymentSplits: splits,
          payment: paymentMethod,
          discountType: discountType,
          discountValue: discountValue,
          discountId: discountId,
        );
  }

  Future<void> _dismissCheckoutAndMaybeCartSheet(BuildContext context) async {
    final navigator = Navigator.of(context);
    final isMobile = MediaQuery.of(context).size.shortestSide < 600;
    navigator.pop();
    final promoted =
        await ref.read(draftCartsProvider.notifier).promoteOldestDraftWithItems();
    if (!promoted && isMobile && navigator.mounted && navigator.canPop()) {
      navigator.pop();
    }
  }

  void _previewReceipt() {
    final s = l10n(context);
    final ui = ref.read(_checkoutUiProvider);
    final cart = ref.read(cartProvider);
    final shift = ref.read(shiftProvider).shift;
    final customer =
        _customerCtrl.text.trim().isEmpty ? null : _customerCtrl.text.trim();

    if (cart.isEmpty) {
      _ui.setError(s.orderCartEmpty);
      return;
    }
    if (shift == null) {
      _ui.setError(s.shiftNoOpenShift);
      return;
    }
    if (!ui.isSplit && cart.payment.isEmpty) {
      _ui.setError(s.checkoutSelectMethod);
      return;
    }

    final int? tip = _parsedTip;
    final String? tipMethod = tip != null ? ui.tipPaymentMethod : null;

    final int? tendered = ui.showTendered && !ui.isSplit
        ? (double.tryParse(_tenderedCtrl.text) != null
            ? (double.parse(_tenderedCtrl.text) * 100).round()
            : null)
        : null;

    List<PaymentSplit>? splits;
    if (ui.isSplit) {
      splits = _buildSplits(ui.activeSplitMethods);
    }

    final discountType =
        ui.selectedDiscount?.dtype ?? cart.discountType?.apiValue;
    final discountValue = ui.selectedDiscount?.value ?? cart.discountValue;
    final discountId = ui.selectedDiscount?.id;
    final paymentMethod = ui.isSplit
        ? (splits != null && splits.isNotEmpty ? (splits.length == 1 ? splits.first.method : 'mixed') : 'mixed')
        : cart.payment;

    final draftOrder = Order(
      id: '',
      branchId: shift.branchId,
      shiftId: shift.id,
      tellerId: ref.read(authProvider).user?.id ?? '',
      tellerName: ref.read(authProvider).user?.name ?? '',
      orderNumber: 0,
      status: 'draft',
      paymentMethod: paymentMethod,
      subtotal: cart.subtotal,
      discountType: discountType,
      discountValue: discountValue ?? 0,
      discountAmount: cart.discountAmount,
      taxAmount: cart.taxAmount,
      totalAmount: cart.total,
      customerName: customer,
      notes: cart.notes,
      amountTendered: tendered,
      tipAmount: tip,
      tipPaymentMethod: tipMethod,
      discountId: discountId,
      createdAt: TimeUtils.now(),
      items: cart.items.map((ci) => _orderItemFromCartItem(ci, id: '')).toList(),
    );

    ReceiptPreviewSheet.show(context, draftOrder,
        title: l10n(context).orderDraftReceiptPreview);
  }

  Future<void> _place() async {
    final ui = ref.read(_checkoutUiProvider);
    final cart = ref.read(cartProvider);
    final shift = ref.read(shiftProvider).shift;
    final queue = ref.read(offlineQueueProvider.notifier);
    final isOnline = ref.read(isOnlineProvider);
    final methods = ref.read(paymentMethodProvider).items;
    final customer =
        _customerCtrl.text.trim().isEmpty ? null : _customerCtrl.text.trim();

    if (ui.loading) return;
    if (cart.isEmpty) {
      _ui.setError('Cart is empty');
      return;
    }
    if (shift == null) {
      _ui.setError('No open shift');
      return;
    }
    if (!ui.isSplit && cart.payment.isEmpty) {
      _ui.setError('Select a payment method');
      return;
    }

    final int? tip = _parsedTip;
    final String? tipMethod = tip != null ? ui.tipPaymentMethod : null;

    final int? tendered = ui.showTendered && !ui.isSplit
        ? (double.tryParse(_tenderedCtrl.text) != null
            ? (double.parse(_tenderedCtrl.text) * 100).round()
            : null)
        : null;

    if (ui.showTendered && !ui.isSplit) {
      if (tendered == null || tendered == 0) {
        _ui.setError('Enter the cash amount tendered');
        return;
      }
      if (tendered < cart.total) {
        _ui.setError(
            'Tendered ${egp(tendered)} is less than total ${egp(cart.total)}');
        return;
      }
      if (tip != null && _tipIsCash) {
        final change = tendered - cart.total;
        if (tip > change) {
          _ui.setError(
              'Cash tip ${egp(tip)} exceeds change ${egp(change)}');
          return;
        }
      }
    }

    List<PaymentSplit>? splits;
    if (ui.isSplit) {
      if (ui.activeSplitMethods.isEmpty) {
        _ui.setError('Select at least one payment method');
        return;
      }
      splits = _buildSplits(ui.activeSplitMethods);
      if (splits.isEmpty) {
        _ui.setError('Enter amounts for selected payment methods');
        return;
      }
      final splitTotal = splits.fold(0, (s, p) => s + p.amount);
      final expectedSplitTotal = cart.total - (_tipIsCash ? (tip ?? 0) : 0);
      if (splitTotal != expectedSplitTotal) {
        _ui.setError(
            'Split total ${egp(splitTotal)} must equal ${egp(expectedSplitTotal)}');
        return;
      }
    }

    _ui.startPlacing();

    final selectedDiscount = ui.selectedDiscount;
    final DiscountType? discountTypeEnum = selectedDiscount != null
        ? DiscountType.values.firstWhere(
            (e) => e.name == selectedDiscount.dtype,
            orElse: () => DiscountType.percentage,
          )
        : cart.discountType;
    final discountValue = selectedDiscount?.value ?? cart.discountValue;
    final discountId = selectedDiscount?.id ?? cart.discountId;
    final discountTypeApi =
        selectedDiscount?.dtype ?? cart.discountType?.apiValue;
    final paymentMethod = ui.isSplit
        ? (splits!.length == 1 ? splits.first.method : 'mixed')
        : cart.payment;

    _syncCheckoutToCart(
      customer: customer,
      paymentMethod: paymentMethod,
      tendered: tendered,
      tip: tip,
      splits: splits,
      discountType: discountTypeEnum,
      discountValue: discountValue,
      discountId: discountId,
    );

    final syncedCart = ref.read(cartProvider);
    final idempotencyKey = ref.read(cartProvider.notifier).idempotencyKey();

    // Cash physically taken for this order — drawer accounting.
    int cashAdded = 0;
    if (splits != null && splits.isNotEmpty) {
      cashAdded = splits
          .where((s) => isCashMethod(methods, s.method))
          .fold(0, (sum, s) => sum + s.amount);
    } else if (isCashMethod(methods, paymentMethod)) {
      cashAdded = syncedCart.total;
    }
    if (tip != null && isCashMethod(methods, tipMethod ?? '')) {
      cashAdded += tip;
    }

    // An offline session has no valid token — queue instead of burning 401s.
    final offlineMode = !isOnline || ref.read(authProvider).isOfflineSession;

    // Queue the order and finish optimistically. Also the fallback when the
    // online attempt dies on a network error mid-flight: the queued retry
    // reuses the same code path and the server's idempotency key handling
    // prevents a double charge.
    Future<void> placeQueued() async {
      final localId = const Uuid().v4();
      await queue.enqueueOrder(PendingOrder(
        localId: localId,
        branchId: shift.branchId,
        shiftId: shift.id,
        paymentMethod: paymentMethod,
        customerName: customer,
        notes: syncedCart.notes,
        discountType: discountTypeApi,
        discountValue: discountValue,
        discountId: discountId,
        amountTendered: tendered,
        tipAmount: tip,
        tipPaymentMethod: tipMethod,
        paymentSplits: splits,
        items: syncedCart.items,
        orderedAt: TimeUtils.now(),
        createdAt: TimeUtils.now(),
        cashAmount: cashAdded,
      ));
      final optimistic = _buildOptimisticOrder(
        localId: localId,
        shift: shift,
        paymentMethod: paymentMethod,
        customer: customer,
        cart: syncedCart,
        discountTypeApi: discountTypeApi,
        discountValue: discountValue,
        discountId: discountId,
        tendered: tendered,
        tip: tip,
        tipMethod: tipMethod,
      );
      await _finalizeOrder(
        order: optimistic,
        total: syncedCart.total,
        tendered: tendered,
        cashAdded: cashAdded,
      );
    }

    try {
      if (offlineMode) {
        await placeQueued();
        return;
      }

      try {
        final order = await ref.read(orderRepositoryProvider).create(
              branchId: shift.branchId,
              shiftId: shift.id,
              cart: syncedCart,
              idempotencyKey: idempotencyKey,
              customerName: customer,
              discountType: discountTypeApi,
              discountValue: discountValue,
              discountId: discountId,
              amountTendered: tendered,
              tipAmount: tip,
              tipPaymentMethod: tipMethod,
              paymentSplits: splits,
            );
        await _finalizeOrder(
          order: order,
          total: syncedCart.total,
          tendered: tendered,
          cashAdded: cashAdded,
        );
      } catch (e) {
        if (isNetworkError(e)) {
          await placeQueued();
        } else {
          // Log the raw error so it's visible in the Flutter console.
          debugPrint('[CheckoutSheet._place] order creation failed: $e');
          if (e is DioException) {
            debugPrint('[CheckoutSheet._place] status: ${e.response?.statusCode}');
            debugPrint('[CheckoutSheet._place] body: ${e.response?.data}');
          }
          if (mounted) _ui.setError(friendlyError(e));
        }
      }
    } finally {
      // Always release the button — an exception anywhere above used to
      // freeze the sheet with a spinner forever.
      if (mounted) _ui.setLoading(false);
    }
  }

  /// The local stand-in shown (and printed) while the real order is queued.
  Order _buildOptimisticOrder({
    required String localId,
    required Shift shift,
    required String paymentMethod,
    required String? customer,
    required CartState cart,
    required String? discountTypeApi,
    required int? discountValue,
    required String? discountId,
    required int? tendered,
    required int? tip,
    required String? tipMethod,
  }) =>
      Order(
        id: localId,
        branchId: shift.branchId,
        shiftId: shift.id,
        tellerId: ref.read(authProvider).user!.id,
        tellerName: ref.read(authProvider).user!.name,
        orderNumber: -1,
        status: 'pending_sync',
        paymentMethod: paymentMethod,
        subtotal: cart.subtotal,
        discountType: discountTypeApi,
        discountValue: discountValue ?? 0,
        discountAmount: cart.discountAmount,
        taxAmount: cart.taxAmount,
        totalAmount: cart.total,
        customerName: customer,
        notes: cart.notes,
        amountTendered: tendered,
        tipAmount: tip,
        tipPaymentMethod: tipMethod,
        discountId: discountId,
        createdAt: TimeUtils.now(),
        items: cart.items
            .map((ci) => _orderItemFromCartItem(ci, id: const Uuid().v4()))
            .toList(),
      );

  /// Builds the wire-shaped optimistic [OrderItem] for a cart line. Fields
  /// the server normally computes (ids, name translations, costing) are
  /// stubbed — these items only back local receipts and the history list
  /// until the queued order syncs.
  OrderItem _orderItemFromCartItem(CartItem ci, {required String id}) =>
      OrderItem(
        id: id,
        orderId: '',
        itemName: ci.itemName,
        nameTranslations: const <String, dynamic>{},
        sizeLabel: ci.sizeLabel,
        bundleId: ci.bundleId,
        bundleComponents: ci.bundleComponents
                ?.map(_bundleComponentFromSnapshot)
                .toList() ??
            const [],
        costMissing: false,
        deductionsSnapshot: const [],
        unitPrice: ci.unitPrice,
        quantity: ci.quantity,
        lineTotal: ci.lineTotal,
        addons: ci.addons.map((a) => OrderItemAddon(
          id: id.isEmpty ? '' : const Uuid().v4(),
          orderItemId: '',
          addonItemId: a.addonItemId,
          addonName: a.name,
          nameTranslations: const <String, dynamic>{},
          unitPrice: a.priceModifier,
          quantity: a.quantity,
          lineTotal: a.priceModifier * a.quantity,
        )).toList(),
        optionals: ci.optionals.map((o) => OrderItemOptional(
          id: id.isEmpty ? '' : const Uuid().v4(),
          orderItemId: '',
          optionalFieldId: o.optionalFieldId,
          fieldName: o.name,
          nameTranslations: const <String, dynamic>{},
          price: o.price,
        )).toList(),
      );

  OrderBundleComponentFull _bundleComponentFromSnapshot(
          BundleComponentSnapshot c) =>
      OrderBundleComponentFull(
        itemId: c.itemId,
        itemName: c.itemName,
        nameTranslations: const <String, dynamic>{},
        quantity: c.quantity,
        sizeLabel: c.sizeLabel,
        addons: c.addons.map((a) => OrderBundleComponentAddon(
          id: '',
          orderLineId: '',
          componentItemId: c.itemId,
          addonItemId: a.addonItemId,
          addonName: a.name,
          nameTranslations: const <String, dynamic>{},
          unitPrice: a.priceModifier,
          quantity: a.quantity,
          lineTotal: a.priceModifier * a.quantity,
        )).toList(),
        optionals: c.optionals.map((o) => OrderBundleComponentOptional(
          id: '',
          orderLineId: '',
          componentItemId: c.itemId,
          optionalFieldId: o.optionalFieldId,
          fieldName: o.name,
          nameTranslations: const <String, dynamic>{},
          price: o.price,
        )).toList(),
      );

  /// Shared tail of every successful placement: durably cache the order
  /// BEFORE the receipt appears, clear the cart, bump drawer cash, show
  /// the receipt.
  Future<void> _finalizeOrder({
    required Order order,
    required int total,
    required int? tendered,
    required int cashAdded,
  }) async {
    await ref.read(orderHistoryProvider.notifier).addOrder(order);
    ref.read(cartProvider.notifier).clear();

    if (cashAdded > 0) {
      ref.read(shiftProvider.notifier).addLocalCash(cashAdded);
      unawaited(ref.read(shiftProvider.notifier).loadSystemCash());
    }

    if (mounted) {
      // The checkout sheet pops inside the dismiss helper, so this State's
      // own context dies with the route's exit animation. Show the receipt
      // from the root navigator's context, which survives the pop.
      final navContext = Navigator.of(context, rootNavigator: true).context;
      await _dismissCheckoutAndMaybeCartSheet(context);
      if (!navContext.mounted) return;
      ReceiptSheet.show(navContext,
          order: order,
          total: total,
          changeGiven:
              tendered != null ? (tendered - total).clamp(0, 999999) : null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);
    // `checkout`, not `ui`: the latter would shadow the ui() text style.
    final checkout = ref.watch(_checkoutUiProvider);
    // Narrow watches: only the cart fields the sheet chrome needs, so cart
    // mutations elsewhere (e.g. drafts) don't rebuild the whole sheet.
    final cartTotal = ref.watch(cartProvider.select((c) => c.total));
    final cartPayment = ref.watch(cartProvider.select((c) => c.payment));
    final (discountsLoading, discounts) =
        ref.watch(discountProvider.select((d) => (d.isLoading, d.items)));
    final (methods, pmLoading, pmError) = ref.watch(
        paymentMethodProvider.select((p) => (p.items, p.isLoading, p.error)));
    final visibleMethods =
        methods.where((m) => m.wireFormat != 'mixed').toList();
    final tipIsCash = isCashMethod(methods, checkout.tipPaymentMethod);
    final mq = MediaQuery.of(context);
    final maxH =
        mq.size.height - mq.padding.top - mq.viewInsets.bottom - AppSpace.lg;

    return Padding(
      // Keeps the sticky footer above the keyboard.
      padding: EdgeInsets.only(bottom: mq.viewInsets.bottom),
      child: Container(
        constraints: BoxConstraints(maxHeight: maxH),
        decoration: BoxDecoration(
            color: t.surfaceRaised, borderRadius: AppRadius.sheetRadius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Sticky header: title + live total ────────────────────────
            Padding(
              padding: const EdgeInsets.only(top: AppSpace.md, bottom: 4),
              child: Center(
                  child: Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                          color: t.border,
                          borderRadius: BorderRadius.circular(2)))),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpace.xl, AppSpace.sm, AppSpace.xl, AppSpace.md),
              child: Row(children: [
                Expanded(
                  child: Text(s.orderCheckout,
                      style: ui(
                          size: 19,
                          weight: FontWeight.w800,
                          color: t.textPrimary)),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, anim) => FadeTransition(
                      opacity: anim,
                      child: ScaleTransition(scale: anim, child: child)),
                  child: Text(egp(cartTotal),
                      key: ValueKey(cartTotal),
                      style: money(
                          size: 20, weight: FontWeight.w800, color: t.accent)),
                ),
              ]),
            ),
            Container(height: 1, color: t.border),

            // ── Scrollable body ───────────────────────────────────────────
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpace.xl, AppSpace.lg, AppSpace.xl, AppSpace.sm),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OfflineBanner(
                        margin: EdgeInsets.only(bottom: AppSpace.lg)),

                    const _SummaryCard(),

                    // Discount lives above the fold, right under the totals
                    // it changes.
                    if (!discountsLoading && discounts.isNotEmpty) ...[
                      SectionHeader(title: s.checkoutDiscountOptional),
                      DiscountSection(
                        discounts: discounts,
                        selected: checkout.selectedDiscount,
                        onSelect: (d) {
                          _ui.selectDiscount(d);
                          if (d == null) {
                            ref
                                .read(cartProvider.notifier)
                                .setDiscount(null, null);
                          } else {
                            ref.read(cartProvider.notifier).setDiscount(
                                DiscountType.values.byName(d.dtype), d.value);
                          }
                        },
                      ),
                    ],

                    SectionHeader(title: s.checkoutCustomerOptional),
                    TextField(
                      controller: _customerCtrl,
                      textCapitalization: TextCapitalization.words,
                      style: ui(size: 15, color: t.textPrimary),
                      decoration: InputDecoration(
                        hintText: s.checkoutNameHint,
                        prefixIcon: Icon(Icons.person_outline_rounded,
                            size: 18, color: t.textMuted),
                      ),
                    ),

                    SectionHeader(
                      title: s.checkoutPaymentHeader,
                      trailing: StatusChip(
                        label: s.checkoutSplitPayment,
                        tone: checkout.isSplit
                            ? ChipTone.accent
                            : ChipTone.neutral,
                        icon: Icons.call_split_rounded,
                        onTap: _toggleSplitMode,
                      ),
                    ),

                    if (visibleMethods.isEmpty)
                      _PaymentMethodsUnavailable(
                        error: pmError,
                        loading: pmLoading,
                        onRetry: _retryPaymentMethods,
                      )
                    else if (checkout.isSplit)
                      SplitPaymentSection(
                        activeMethods: checkout.activeSplitMethods,
                        splitCtrs: _splitCtrs,
                        cartTotal: cartTotal,
                        onToggleMethod: _toggleSplitMethod,
                        tipCtrl: _tipCtrl,
                        tipIsCash: tipIsCash,
                        methods: methods,
                      )
                    else ...[
                      _SinglePaymentGrid(
                        selected: cartPayment,
                        onSelect: (v) {
                          ref.read(cartProvider.notifier).setPayment(v);
                          _ui.paymentSelected(v);
                        },
                        methods: visibleMethods,
                      ),
                      if (checkout.showTendered) ...[
                        const SizedBox(height: AppSpace.lg),
                        CashTenderedSection(
                          tenderedCtrl: _tenderedCtrl,
                          cartTotal: cartTotal,
                          tipCtrl: _tipCtrl,
                          tipIsCash: tipIsCash,
                        ),
                      ],
                    ],

                    const SizedBox(height: AppSpace.lg),
                    TipSection(
                      tipCtrl: _tipCtrl,
                      tipPaymentMethod: checkout.tipPaymentMethod,
                      onMethodChanged: (m) => _ui.setTipMethod(m),
                      methods: methods,
                    ),

                    AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      child: checkout.error != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: AppSpace.lg),
                              child: Container(
                                padding:
                                    const EdgeInsetsDirectional.symmetric(
                                        horizontal: 14, vertical: 11),
                                decoration: BoxDecoration(
                                    color: t.dangerBg,
                                    borderRadius:
                                        BorderRadius.circular(AppRadius.xs)),
                                child: Row(children: [
                                  Icon(Icons.error_outline_rounded,
                                      size: 14, color: t.danger),
                                  const SizedBox(width: AppSpace.sm),
                                  Expanded(
                                      child: Text(checkout.error!,
                                          style: ui(
                                              size: 13, color: t.danger))),
                                ]),
                              ))
                          : const SizedBox.shrink(),
                    ),

                    const SizedBox(height: AppSpace.lg),
                  ],
                ),
              ),
            ),

            // ── Sticky footer: Place Order + Preview ──────────────────────
            Container(
              padding: EdgeInsetsDirectional.fromSTEB(AppSpace.xl,
                  AppSpace.md, AppSpace.xl, mq.padding.bottom + AppSpace.lg),
              decoration: BoxDecoration(
                  color: t.surfaceRaised,
                  border: Border(top: BorderSide(color: t.border))),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: s.orderPlaceOrder,
                      loading: checkout.loading,
                      width: double.infinity,
                      height: 52,
                      icon: Icons.check_rounded,
                      onTap: _place,
                    ),
                  ),
                  const SizedBox(width: AppSpace.md),
                  AppButton(
                    label: s.checkoutPreview,
                    variant: BtnVariant.outline,
                    height: 52,
                    icon: Icons.receipt_long_rounded,
                    onTap: _previewReceipt,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends ConsumerWidget {
  const _SummaryCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final s = l10n(context);
    // Watches only the totals it renders.
    final subtotal = ref.watch(cartProvider.select((c) => c.subtotal));
    final discountAmount =
        ref.watch(cartProvider.select((c) => c.discountAmount));
    final taxAmount = ref.watch(cartProvider.select((c) => c.taxAmount));
    final total = ref.watch(cartProvider.select((c) => c.total));
    return SurfaceCard(
      padding: const EdgeInsets.all(AppSpace.lg),
      child: Column(children: [
        _SummaryRow(label: s.orderSubtotal, value: egp(subtotal)),
        if (discountAmount > 0)
          _SummaryRow(
              label: s.orderDiscount,
              value: '− ${egp(discountAmount)}',
              valueColor: t.success),
        if (taxAmount > 0)
          _SummaryRow(label: s.orderTax, value: egp(taxAmount)),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: AppSpace.sm),
          child: Divider(),
        ),
        _SummaryRow(
            label: s.orderTotal, value: egp(total), emphasized: true),
      ]),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool emphasized;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.emphasized = false,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpace.xs),
      child: Row(children: [
        Expanded(
          child: Text(label,
              style: ui(
                  size: emphasized ? 14 : 13,
                  weight: emphasized ? FontWeight.w700 : FontWeight.w500,
                  color: emphasized ? t.textPrimary : t.textSecondary)),
        ),
        Text(value,
            style: money(
                size: emphasized ? 17 : 13,
                weight: emphasized ? FontWeight.w800 : FontWeight.w600,
                color: valueColor ?? t.textPrimary)),
      ]),
    );
  }
}

/// Shown in place of the method grid when there is nothing to render —
/// explains the why (provider error, still loading, or genuinely none).
class _PaymentMethodsUnavailable extends StatelessWidget {
  final String? error;
  final bool loading;
  final VoidCallback onRetry;

  const _PaymentMethodsUnavailable({
    required this.error,
    required this.loading,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final s = l10n(context);

    if (error == null && loading) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpace.md),
        child: Row(children: [
          const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2)),
          const SizedBox(width: AppSpace.md),
          Text(s.checkoutLoadingMethods,
              style: ui(size: 13, color: t.textSecondary)),
        ]),
      );
    }

    if (error == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpace.lg),
        decoration: BoxDecoration(
          color: t.surfaceAlt,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: t.border),
        ),
        child: Text(s.checkoutNoMethodsConfigured,
            style: ui(size: 13, color: t.textSecondary, height: 1.5)),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpace.lg),
      decoration: BoxDecoration(
        color: t.dangerBg,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: t.danger.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.error_outline_rounded, size: 16, color: t.danger),
            const SizedBox(width: AppSpace.sm),
            Expanded(
              child: Text(s.checkoutMethodsLoadFailed,
                  style: ui(
                      size: 14, weight: FontWeight.w700, color: t.danger)),
            ),
          ]),
          const SizedBox(height: AppSpace.sm),
          Text(error!, style: ui(size: 12, color: t.danger, height: 1.4)),
          const SizedBox(height: AppSpace.xs),
          Text(s.checkoutMethodsNeeded,
              style: ui(size: 12, color: t.textSecondary, height: 1.4)),
          const SizedBox(height: AppSpace.md),
          StatusChip(
            label: s.retryAction,
            tone: ChipTone.danger,
            icon: Icons.refresh_rounded,
            onTap: onRetry,
          ),
        ],
      ),
    );
  }
}

class _SinglePaymentGrid extends StatelessWidget {
  final String selected;
  final void Function(String) onSelect;
  final List<PaymentMethod> methods;

  const _SinglePaymentGrid(
      {required this.selected,
      required this.onSelect,
      required this.methods});

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return LayoutBuilder(builder: (ctx, constraints) {
      final btnW = (constraints.maxWidth - AppSpace.sm) / 2;
      return Wrap(
        spacing: AppSpace.sm,
        runSpacing: AppSpace.sm,
        children: methods.map((m) {
          final sel = selected == m.wireFormat;
          return AnimatedPressScale(
            onTap: () => onSelect(m.wireFormat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: btnW,
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 12, vertical: 11),
              decoration: BoxDecoration(
                  // Selected tiles wear the method's own brand color (data
                  // from the dashboard), with white content in both themes.
                  color: sel ? m.uiColor : t.surfaceAlt,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(
                      color: sel ? m.uiColor : t.border,
                      width: sel ? 1.5 : 1)),
              child: Row(children: [
                Icon(m.uiIcon, size: 20, color: sel ? Colors.white : m.uiColor),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(
                        m.label(
                            Localizations.localeOf(context).languageCode),
                        style: ui(
                            size: 13,
                            weight: FontWeight.w600,
                            color: sel ? Colors.white : t.textPrimary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis)),
                if (sel) ...[
                  const SizedBox(width: AppSpace.xs),
                  const Icon(Icons.check_circle_rounded,
                      size: 15, color: Colors.white)
                ],
              ]),
            ),
          );
        }).toList(),
      );
    });
  }
}
