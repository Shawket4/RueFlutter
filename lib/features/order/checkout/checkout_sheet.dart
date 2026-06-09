import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/api/client.dart';
import '../../../core/providers/draft_carts_notifier.dart';
import '../../../core/repositories/order_repository.dart';
import '../../../core/utils/time_utils.dart';
import '../../../core/models/cart.dart';
import '../../../core/models/discount.dart';
import '../../../core/models/order.dart';
import '../../../core/models/pending_action.dart';
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
import '../../../shared/widgets/label_value.dart';
import '../../../shared/widgets/responsive_sheet.dart';
import '../../../shared/widgets/sync_status_banner.dart';
import '../helpers/payment_helpers.dart';
import '../../../core/providers/payment_method_notifier.dart';
import '../widgets/receipt_sheet.dart';
import '../widgets/receipt_preview_sheet.dart';
import '../widgets/shared_widgets.dart';

import 'sections/discount_section.dart';
import 'sections/tip_section.dart';
import 'sections/cash_tendered_section.dart';
import 'sections/split_payment_section.dart';

class CheckoutSheet extends ConsumerStatefulWidget {
  const CheckoutSheet({super.key});

  // Task 3.2: Use ResponsiveSheet
  static Future<void> show(BuildContext ctx) => ResponsiveSheet.show(
      context: ctx,
      builder: (_) => const CheckoutSheet());

  @override
  ConsumerState<CheckoutSheet> createState() => _CheckoutSheetState();
}

class _CheckoutSheetState extends ConsumerState<CheckoutSheet> {
  bool _loading = false;
  String? _error;
  final _customerCtrl = TextEditingController();

  Discount? _selectedDiscount;

  final _tenderedCtrl = TextEditingController();
  bool _showTendered = false;

  final _tipCtrl = TextEditingController();
  String _tipPaymentMethod = 'cash';

  bool _isSplit = false;
  final Map<String, TextEditingController> _splitCtrs = {};
  final Set<String> _activeSplitMethods = {};

  @override
  void initState() {
    super.initState();
    final cart = ref.read(cartProvider);
    _showTendered = cart.payment == 'cash' || cart.payment == 'talabat_cash';
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
    setState(() {
      if (_activeSplitMethods.contains(method)) {
        _activeSplitMethods.remove(method);
        _splitCtrs[method]?.clear();
      } else {
        _activeSplitMethods.add(method);
        _splitCtrs.putIfAbsent(method, () => TextEditingController());
      }
    });
  }

  List<PaymentSplit> _buildSplits() {
    final splits = <PaymentSplit>[];
    for (final method in _activeSplitMethods) {
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
    return isCashMethod(methods, _tipPaymentMethod);
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
    final cart = ref.read(cartProvider);
    final shift = ref.read(shiftProvider).shift;
    final customer =
        _customerCtrl.text.trim().isEmpty ? null : _customerCtrl.text.trim();

    if (cart.isEmpty) {
      setState(() => _error = 'Cart is empty');
      return;
    }
    if (shift == null) {
      setState(() => _error = 'No open shift');
      return;
    }
    if (!_isSplit && cart.payment.isEmpty) {
      setState(() => _error = 'Select a payment method');
      return;
    }

    final int? tip = _parsedTip;
    final String? tipMethod = tip != null ? _tipPaymentMethod : null;

    final int? tendered = _showTendered && !_isSplit
        ? (double.tryParse(_tenderedCtrl.text) != null
            ? (double.parse(_tenderedCtrl.text) * 100).round()
            : null)
        : null;

    List<PaymentSplit>? splits;
    if (_isSplit) {
      splits = _buildSplits();
    }

    final discountType =
        _selectedDiscount?.dtype ?? cart.discountType?.apiValue;
    final discountValue = _selectedDiscount?.value ?? cart.discountValue;
    final discountId = _selectedDiscount?.id;
    final paymentMethod = _isSplit
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
      taxAmount: 0,
      totalAmount: cart.total,
      customerName: customer,
      notes: cart.notes,
      amountTendered: tendered,
      tipAmount: tip,
      tipPaymentMethod: tipMethod,
      discountId: discountId,
      createdAt: TimeUtils.now(),
      items: cart.items.map((ci) => OrderItem(
        id: '',
        itemName: ci.itemName,
        sizeLabel: ci.sizeLabel,
        bundleId: ci.bundleId,
        bundleComponents: ci.bundleComponents ?? const [],
        unitPrice: ci.unitPrice,
        quantity: ci.quantity,
        lineTotal: ci.lineTotal,
        addons: ci.addons.map((a) => OrderItemAddon(
          id: '',
          orderItemId: '',
          addonItemId: a.addonItemId,
          addonName: a.name,
          unitPrice: a.priceModifier,
          quantity: a.quantity,
          lineTotal: a.priceModifier * a.quantity,
        )).toList(),
        optionals: ci.optionals.map((o) => OrderItemOptional(
          id: '',
          orderItemId: '',
          optionalFieldId: o.optionalFieldId,
          fieldName: o.name,
          price: o.price,
        )).toList(),
      )).toList(),
    );

    ReceiptPreviewSheet.show(context, draftOrder, title: 'Draft Receipt Preview');
  }

  Future<void> _place() async {
    final cart = ref.read(cartProvider);
    final shift = ref.read(shiftProvider).shift;
    final queue = ref.read(offlineQueueProvider.notifier);
    final isOnline = ref.read(isOnlineProvider);
    final customer =
        _customerCtrl.text.trim().isEmpty ? null : _customerCtrl.text.trim();

    if (_loading) return;
    if (cart.isEmpty) {
      setState(() => _error = 'Cart is empty');
      return;
    }
    if (shift == null) {
      setState(() => _error = 'No open shift');
      return;
    }
    if (!_isSplit && cart.payment.isEmpty) {
      setState(() => _error = 'Select a payment method');
      return;
    }

    final int? tip = _parsedTip;
    final String? tipMethod = tip != null ? _tipPaymentMethod : null;

    final int? tendered = _showTendered && !_isSplit
        ? (double.tryParse(_tenderedCtrl.text) != null
            ? (double.parse(_tenderedCtrl.text) * 100).round()
            : null)
        : null;

    if (_showTendered && !_isSplit) {
      if (tendered == null || tendered == 0) {
        setState(() => _error = 'Enter the cash amount tendered');
        return;
      }
      if (tendered < cart.total) {
        setState(() => _error =
            'Tendered ${egp(tendered)} is less than total ${egp(cart.total)}');
        return;
      }
      if (tip != null && _tipIsCash) {
        final change = tendered - cart.total;
        if (tip > change) {
          setState(() =>
              _error = 'Cash tip ${egp(tip)} exceeds change ${egp(change)}');
          return;
        }
      }
    }

    List<PaymentSplit>? splits;
    if (_isSplit) {
      if (_activeSplitMethods.isEmpty) {
        setState(() => _error = 'Select at least one payment method');
        return;
      }
      splits = _buildSplits();
      if (splits.isEmpty) {
        setState(() => _error = 'Enter amounts for selected payment methods');
        return;
      }
      final splitTotal = splits.fold(0, (s, p) => s + p.amount);
      final expectedSplitTotal = cart.total - (_tipIsCash ? (tip ?? 0) : 0);
      if (splitTotal != expectedSplitTotal) {
        setState(() => _error =
            'Split total ${egp(splitTotal)} must equal ${egp(expectedSplitTotal)}');
        return;
      }
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    final DiscountType? discountTypeEnum = _selectedDiscount != null
        ? DiscountType.values.firstWhere(
            (e) => e.name == _selectedDiscount!.dtype,
            orElse: () => DiscountType.percentage,
          )
        : cart.discountType;
    final discountValue = _selectedDiscount?.value ?? cart.discountValue;
    final discountId = _selectedDiscount?.id ?? cart.discountId;
    final discountTypeApi =
        _selectedDiscount?.dtype ?? cart.discountType?.apiValue;
    final paymentMethod = _isSplit
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

    if (!isOnline) {
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
      ));

      // Task 1.5: Optimistic offline order
      final optimistic = Order(
        id: localId,
        branchId: shift.branchId,
        shiftId: shift.id,
        tellerId: ref.read(authProvider).user!.id,
        tellerName: ref.read(authProvider).user!.name,
        orderNumber: -1,
        status: 'pending_sync',
        paymentMethod: paymentMethod,
        subtotal: syncedCart.subtotal,
        discountType: discountTypeApi,
        discountValue: discountValue ?? 0,
        discountAmount: syncedCart.discountAmount,
        taxAmount: 0,
        totalAmount: syncedCart.total,
        customerName: customer,
        notes: syncedCart.notes,
        amountTendered: tendered,
        tipAmount: tip,
        tipPaymentMethod: tipMethod,
        discountId: discountId,
        createdAt: TimeUtils.now(),
        items: syncedCart.items.map((ci) => OrderItem(
          id: const Uuid().v4(),
          itemName: ci.itemName,
          sizeLabel: ci.sizeLabel,
          bundleId: ci.bundleId,
          bundleComponents: ci.bundleComponents ?? const [],
          unitPrice: ci.unitPrice,
          quantity: ci.quantity,
          lineTotal: ci.lineTotal,
          addons: ci.addons.map((a) => OrderItemAddon(
            id: const Uuid().v4(),
            orderItemId: '',
            addonItemId: a.addonItemId,
            addonName: a.name,
            unitPrice: a.priceModifier,
            quantity: a.quantity,
            lineTotal: a.priceModifier * a.quantity,
          )).toList(),
          optionals: ci.optionals.map((o) => OrderItemOptional(
            id: const Uuid().v4(),
            orderItemId: '',
            optionalFieldId: o.optionalFieldId,
            fieldName: o.name,
            price: o.price,
          )).toList(),
        )).toList(),
      );
      ref.read(orderHistoryProvider.notifier).addOrder(optimistic);

      final total = syncedCart.total;
      ref.read(cartProvider.notifier).clear();

      int cashAdded = 0;
      if (splits != null && splits.isNotEmpty) {
        cashAdded = splits
            .where((s) => s.method == 'cash' || s.method == 'talabat_cash')
            .fold(0, (sum, s) => sum + s.amount);
      } else if (paymentMethod == 'cash' || paymentMethod == 'talabat_cash') {
        cashAdded = total;
      }
      if (cashAdded > 0) {
        ref.read(shiftProvider.notifier).addLocalCash(cashAdded);
        ref.read(shiftProvider.notifier).loadSystemCash();
      }

      if (mounted) {
        await _dismissCheckoutAndMaybeCartSheet(context);
        ReceiptSheet.show(context,
            order: optimistic,
            total: total,
            changeGiven:
                tendered != null ? (tendered - total).clamp(0, 999999) : null);
      }
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
      ref.read(orderHistoryProvider.notifier).addOrder(order);
      final total = syncedCart.total;
      ref.read(cartProvider.notifier).clear();

      int cashAdded = 0;
      if (splits != null && splits.isNotEmpty) {
        cashAdded = splits
            .where((s) => s.method == 'cash' || s.method == 'talabat_cash')
            .fold(0, (sum, s) => sum + s.amount);
      } else if (paymentMethod == 'cash' || paymentMethod == 'talabat_cash') {
        cashAdded = total;
      }
      if (cashAdded > 0) {
        ref.read(shiftProvider.notifier).addLocalCash(cashAdded);
        ref.read(shiftProvider.notifier).loadSystemCash();
      }
      if (mounted) {
        await _dismissCheckoutAndMaybeCartSheet(context);
        ReceiptSheet.show(context,
            order: order,
            total: total,
            changeGiven:
                tendered != null ? (tendered - total).clamp(0, 999999) : null);
      }
    } catch (e) {
      if (isNetworkError(e)) {
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
          createdAt: TimeUtils.now(),
          orderedAt: TimeUtils.now(),
        ));

        // Task 1.5: Optimistic offline order
        final optimistic = Order(
          id: localId,
          branchId: shift.branchId,
          shiftId: shift.id,
          tellerId: ref.read(authProvider).user!.id,
          tellerName: ref.read(authProvider).user!.name,
          orderNumber: -1,
          status: 'pending_sync',
          paymentMethod: paymentMethod,
          subtotal: syncedCart.subtotal,
          discountType: discountTypeApi,
          discountValue: discountValue ?? 0,
          discountAmount: syncedCart.discountAmount,
          taxAmount: 0,
          totalAmount: syncedCart.total,
          customerName: customer,
          notes: syncedCart.notes,
          amountTendered: tendered,
          tipAmount: tip,
          tipPaymentMethod: tipMethod,
          discountId: discountId,
          createdAt: TimeUtils.now(),
          items: syncedCart.items.map((ci) => OrderItem(
            id: const Uuid().v4(),
            itemName: ci.itemName,
            sizeLabel: ci.sizeLabel,
            bundleId: ci.bundleId,
            bundleComponents: ci.bundleComponents ?? const [],
            unitPrice: ci.unitPrice,
            quantity: ci.quantity,
            lineTotal: ci.lineTotal,
            addons: ci.addons.map((a) => OrderItemAddon(
              id: const Uuid().v4(),
              orderItemId: '',
              addonItemId: a.addonItemId,
              addonName: a.name,
              unitPrice: a.priceModifier,
              quantity: a.quantity,
              lineTotal: a.priceModifier * a.quantity,
            )).toList(),
            optionals: ci.optionals.map((o) => OrderItemOptional(
              id: const Uuid().v4(),
              orderItemId: '',
              optionalFieldId: o.optionalFieldId,
              fieldName: o.name,
              price: o.price,
            )).toList(),
          )).toList(),
        );
        ref.read(orderHistoryProvider.notifier).addOrder(optimistic);

        final total = syncedCart.total;
        ref.read(cartProvider.notifier).clear();

        int cashAdded = 0;
        if (splits != null && splits.isNotEmpty) {
          cashAdded = splits
              .where((s) => s.method == 'cash' || s.method == 'talabat_cash')
              .fold(0, (sum, s) => sum + s.amount);
        } else if (paymentMethod == 'cash' || paymentMethod == 'talabat_cash') {
          cashAdded = total;
        }
        if (cashAdded > 0) {
          ref.read(shiftProvider.notifier).addLocalCash(cashAdded);
          ref.read(shiftProvider.notifier).loadSystemCash();
        }
        if (mounted) {
          await _dismissCheckoutAndMaybeCartSheet(context);
          ReceiptSheet.show(context,
            order: optimistic,
            total: total,
            changeGiven:
                tendered != null ? (tendered - total).clamp(0, 999999) : null);
        }
      } else {
        // Log the raw error so it's visible in the Flutter console.
        debugPrint('[CheckoutSheet._place] order creation failed: $e');
        if (e is DioException) {
          debugPrint('[CheckoutSheet._place] status: ${e.response?.statusCode}');
          debugPrint('[CheckoutSheet._place] body: ${e.response?.data}');
        }
        if (mounted) {
          setState(() {
            _error = friendlyError(e);
            _loading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final discountState = ref.watch(discountProvider);
    final isOnline = ref.watch(isOnlineProvider);
    final methods = ref.watch(paymentMethodProvider).items;
    final mq = MediaQuery.of(context);
    final maxH = mq.size.height - mq.padding.top - 16;

    return Container(
      constraints: BoxConstraints(maxHeight: maxH),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: AppRadius.sheetRadius),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 4),
            child: Center(
                child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(2)))),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
            child: Row(children: [
              Text('Checkout',
                  style: cairo(fontSize: 20, fontWeight: FontWeight.w800)),
              const Spacer(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, anim) => SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(0.2, 0), end: Offset.zero)
                        .animate(anim),
                    child: FadeTransition(opacity: anim, child: child)),
                child: Container(
                  key: ValueKey(cart.total),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(egp(cart.total),
                      style: cairo(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary)),
                ),
              ),
            ]),
          ),
          Container(height: 1, color: AppColors.border),

          Flexible(
            child: SingleChildScrollView(
              padding:
                  EdgeInsets.fromLTRB(24, 20, 24, mq.viewInsets.bottom + 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Task 2.2: Show offline status
                  if (!isOnline)
                    const SyncStatusBanner(
                      variant: SyncBannerVariant.offline,
                      text: 'Offline — order will sync when reconnected.'
                    ),

                  _SummaryCard(cart: cart),
                  const SizedBox(height: 20),

                  const FieldLabel('CUSTOMER NAME (OPTIONAL)'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _customerCtrl,
                    textCapitalization: TextCapitalization.words,
                    style: cairo(fontSize: 15),
                    decoration: InputDecoration(
                      hintText: 'e.g. Ahmed',
                      hintStyle:
                          cairo(fontSize: 15, color: AppColors.textMuted),
                      prefixIcon: const Icon(Icons.person_outline_rounded,
                          size: 18, color: AppColors.textMuted),
                    ),
                  ),
                  const SizedBox(height: 20),

                  if (!discountState.isLoading && discountState.items.isNotEmpty) ...[
                    const FieldLabel('DISCOUNT (OPTIONAL)'),
                    const SizedBox(height: 8),
                    DiscountSection(
                      discounts: discountState.items,
                      selected: _selectedDiscount,
                      onSelect: (d) {
                        setState(() => _selectedDiscount = d);
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
                    const SizedBox(height: 20),
                  ],

                  Row(children: [
                    const FieldLabel('PAYMENT'),
                    const Spacer(),
                    _SplitToggle(
                      active: _isSplit,
                      onToggle: () => setState(() {
                        _isSplit = !_isSplit;
                        if (!_isSplit) {
                          for (final c in _splitCtrs.values) {
                            c.clear();
                          }
                          _activeSplitMethods.clear();
                          final pay = ref.read(cartProvider).payment;
                          _showTendered =
                              pay == 'cash' || pay == 'talabat_cash';
                        } else {
                          _showTendered = false;
                        }
                      }),
                    ),
                  ]),
                  const SizedBox(height: 10),

                  if (_isSplit)
                    SplitPaymentSection(
                      activeMethods: _activeSplitMethods,
                      splitCtrs: _splitCtrs,
                      cartTotal: cart.total,
                      onToggleMethod: _toggleSplitMethod,
                      onAmountChanged: () => setState(() {}),
                      parsedTip: _parsedTip,
                      tipPaymentMethod: _tipPaymentMethod,
                      methods: methods,
                    )
                  else ...[
                    _SinglePaymentGrid(
                      selected: cart.payment,
                      onSelect: (v) {
                        ref.read(cartProvider.notifier).setPayment(v);
                        setState(() =>
                            _showTendered = v == 'cash' || v == 'talabat_cash');
                      },
                      methods: methods,
                    ),

                    if (_showTendered) ...[
                      const SizedBox(height: 20),
                      CashTenderedSection(
                        tenderedCtrl: _tenderedCtrl,
                        cartTotal: cart.total,
                        onChanged: () => setState(() {}),
                        cashTip: _tipIsCash ? _parsedTip : null,
                      ),
                    ],
                  ],

                  const SizedBox(height: 20),
                  TipSection(
                    tipCtrl: _tipCtrl,
                    tipPaymentMethod: _tipPaymentMethod,
                    parsedTip: _parsedTip,
                    onMethodChanged: (m) =>
                        setState(() => _tipPaymentMethod = m),
                    onAmountChanged: () => setState(() {}),
                    methods: methods,
                  ),

                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: _error != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 11),
                              decoration: BoxDecoration(
                                  color: AppColors.danger.withOpacity(0.07),
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.xs)),
                              child: Row(children: [
                                const Icon(Icons.error_outline_rounded,
                                    size: 14, color: AppColors.danger),
                                const SizedBox(width: 8),
                                Expanded(
                                    child: Text(_error!,
                                        style: cairo(
                                            fontSize: 13,
                                            color: AppColors.danger))),
                              ]),
                            ))
                        : const SizedBox.shrink(),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.fromLTRB(24, 12, 24, mq.padding.bottom + 16),
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.border))),
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Place Order',
                    loading: _loading,
                    width: double.infinity,
                    height: 52,
                    icon: Icons.check_rounded,
                    onTap: _place,
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 52,
                  child: OutlinedButton(
                    onPressed: _previewReceipt,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.receipt_long_rounded, color: AppColors.primary, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Preview',
                          style: cairo(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final CartState cart;
  const _SummaryCard({required this.cart});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: AppColors.bg,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: AppColors.border)),
        child: Column(children: [
          LabelValue('Subtotal', egp(cart.subtotal)),
          if (cart.discountAmount > 0)
            LabelValue('Discount', '− ${egp(cart.discountAmount)}',
                valueColor: AppColors.success),
          const Divider(height: 16, color: AppColors.border),
          LabelValue('Total', egp(cart.total), bold: true),
        ]),
      );
}

class _SplitToggle extends StatelessWidget {
  final bool active;
  final VoidCallback onToggle;
  const _SplitToggle({required this.active, required this.onToggle});
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onToggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: active ? AppColors.primary.withOpacity(0.1) : AppColors.bg,
            borderRadius: BorderRadius.circular(AppRadius.xs),
            border: Border.all(
                color: active ? AppColors.primary : AppColors.border),
          ),
          child: Text('Split',
              style: cairo(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color:
                      active ? AppColors.primary : AppColors.textSecondary)),
        ),
      );
}

class _SinglePaymentGrid extends StatelessWidget {
  final String selected;
  final void Function(String) onSelect;
  final List<PaymentMethod> methods;
  const _SinglePaymentGrid({required this.selected, required this.onSelect, required this.methods});

  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (ctx, constraints) {
        final btnW = (constraints.maxWidth - 8) / 2;
        // Task 4.1: Use new enum logic
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: methods.where((m) => m.wireFormat != 'mixed').map((m) {
            final sel = selected == m.wireFormat;
            return GestureDetector(
              onTap: () => onSelect(m.wireFormat),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: btnW,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                decoration: BoxDecoration(
                    color: sel ? m.color : AppColors.bg,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(
                        color: sel ? m.color : AppColors.border,
                        width: sel ? 1.5 : 1)),
                child: Row(children: [
                  Icon(m.icon, size: 20, color: sel ? Colors.white : m.color),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Text(m.label('en'),
                          style: cairo(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color:
                                  sel ? Colors.white : AppColors.textPrimary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis)),
                  if (sel) ...[
                    const SizedBox(width: 4),
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
