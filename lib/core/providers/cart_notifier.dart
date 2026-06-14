import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bundle.dart';
import '../models/cart.dart';
import '../storage/storage_service.dart';
import '../utils/time_utils.dart';
import 'auth_notifier.dart';
import 'cart_storage.dart';
import 'shift_notifier.dart';

class CartNotifier extends Notifier<CartState> {
  CartItem? _lastRemovedItem;
  int? _lastRemovedIndex;
  String? _loadedScope;

  static CartState _defaultCart() => CartState(
        id: 'order_1',
        displayName: 'Order 1',
        createdAt: TimeUtils.now(),
      );

  String? _scope() => cartStorageScope(ref.read(shiftProvider).shift);

  /// Session tax rate (org config). Never persisted with the cart — re-read
  /// from auth and re-applied on every (re)build/load so the getters compute
  /// a tax-inclusive total. 0.0 ⟹ tax-free total (legacy behaviour).
  ///
  /// Read with `ref.read` (NOT watch/listen): AuthNotifier invalidates the
  /// cart on logout, so a build-time dependency edge cart→auth would be a
  /// circular dependency. Auth instead *pushes* rate changes via
  /// [applyTaxRate].
  double get _taxRate => ref.read(authProvider).taxRate;

  @override
  CartState build() {
    ref.listen(shiftProvider, (prev, next) {
      final oldScope = cartStorageScope(prev?.shift);
      final newScope = cartStorageScope(next.shift);
      if (oldScope != newScope) {
        _loadedScope = newScope;
        state = _loadForScope(newScope);
      }
    });

    _loadedScope = _scope();
    return _loadForScope(_loadedScope);
  }

  /// Pushed by [AuthNotifier] when the session tax rate becomes known/changes
  /// (e.g. the first /auth/me lands after the cart was already built). Pure
  /// config update — does not persist (taxRate is never stored).
  void applyTaxRate(double rate) {
    if (state.taxRate != rate) state = state.copyWith(taxRate: rate);
  }

  CartState _loadForScope(String? scope) {
    final loaded = _buildForScope(scope);
    // Storage never carries taxRate (it's session config) — inject it here so
    // every load path produces a tax-aware cart.
    return loaded.copyWith(taxRate: _taxRate);
  }

  CartState _buildForScope(String? scope) {
    if (scope == null) return _defaultCart();
    final raw = ref.read(storageServiceProvider).loadActiveCart(scope);
    if (raw == null) return _defaultCart();
    try {
      return CartState.fromStorageJson(raw);
    } catch (_) {
      return _defaultCart();
    }
  }

  /// Chains persistence so rapid successive mutations can never write to
  /// storage out of order (last mutation always lands last on disk).
  Future<void> _persistChain = Future.value();

  void _update(CartState next) {
    state = next;
    // catchError keeps the chain alive: one failed write must not poison
    // every subsequent persist for the rest of the session.
    _persistChain =
        _persistChain.then((_) => _persist()).catchError((Object _) {});
  }

  Future<void> _persist() async {
    final scope = _scope();
    if (scope == null || scope != _loadedScope) return;
    await ref
        .read(storageServiceProvider)
        .saveActiveCart(scope, state.toStorageJson());
  }

  void add(CartItem incoming) {
    final idx = incoming.isBundleLine
        ? state.items.indexWhere((i) => i.bundleId == incoming.bundleId)
        : state.items.indexWhere((i) =>
            !i.isBundleLine &&
            i.menuItemId == incoming.menuItemId &&
            i.sizeLabel == incoming.sizeLabel &&
            CartItem.addonsMatch(i.addons, incoming.addons) &&
            CartItem.optionalsMatch(i.optionals, incoming.optionals));

    if (idx >= 0) {
      final updated = List<CartItem>.of(state.items);
      updated[idx] = updated[idx]
          .copyWith(quantity: updated[idx].quantity + incoming.quantity);
      _update(state.copyWith(items: updated));
    } else {
      _update(state.copyWith(items: [...state.items, incoming]));
    }
  }

  /// Adds a bundle line with per-component configuration captured at order time.
  void addBundle(
    Bundle bundle,
    List<BundleComponentSnapshot> components,
  ) {
    add(CartItem(
      bundleId: bundle.id,
      bundleComponents: components,
      itemName: bundle.name,
      unitPrice: bundle.price,
      quantity: 1,
    ));
  }

  void removeAt(int index) {
    if (index < 0 || index >= state.items.length) return;
    _lastRemovedItem = state.items[index];
    _lastRemovedIndex = index;
    final updated = List<CartItem>.of(state.items)..removeAt(index);
    _update(state.copyWith(items: updated));
  }

  void restoreLastRemoved() {
    if (_lastRemovedItem == null || _lastRemovedIndex == null) return;

    final safeIndex = _lastRemovedIndex!.clamp(0, state.items.length);
    final updated = List<CartItem>.of(state.items)
      ..insert(safeIndex, _lastRemovedItem!);
    _update(state.copyWith(items: updated));

    _lastRemovedItem = null;
    _lastRemovedIndex = null;
  }

  void setQty(int index, int qty) {
    if (index < 0 || index >= state.items.length) return;
    if (qty <= 0) {
      removeAt(index);
      return;
    }
    final updated = List<CartItem>.of(state.items);
    updated[index] = updated[index].copyWith(quantity: qty);
    _update(state.copyWith(items: updated));
  }

  void replaceAt(int index, CartItem incoming) {
    if (index < 0 || index >= state.items.length) return;
    final updated = List<CartItem>.of(state.items);
    updated[index] = incoming;
    _update(state.copyWith(items: updated));
  }

  void setPayment(String m) =>
      _update(state.copyWith(payment: m, clearSplits: true));

  void setCustomer(String? n) =>
      _update(state.copyWith(customerName: n, clearCustomer: n == null));

  void setNotes(String? n) => _update(state.copyWith(notes: n));

  void setDiscount(DiscountType? type, int? value) => _update(type == null
      ? state.copyWith(clearDiscount: true, clearDiscountId: true)
      : state.copyWith(
          discountType: type, discountValue: value, clearDiscountId: true));

  void setDiscountById(String id, DiscountType type, int value) => _update(
      state.copyWith(
          discountId: id, discountType: type, discountValue: value));

  void clearDiscount() =>
      _update(state.copyWith(clearDiscount: true, clearDiscountId: true));

  void setAmountTendered(int? amount) => _update(state.copyWith(
      amountTendered: amount, clearTendered: amount == null));

  void setTip(int? tip) => _update(state.copyWith(tipAmount: tip));

  void setPaymentSplits(List<PaymentSplit> splits) {
    final method = splits.length == 1 ? splits.first.method : 'mixed';
    _update(state.copyWith(paymentSplits: splits, payment: method));
  }

  void clearSplits() =>
      _update(state.copyWith(clearSplits: true, payment: 'cash'));

  /// Writes checkout sheet values onto the active cart before place/park.
  void applyCheckoutFields({
    String? customerName,
    int? amountTendered,
    int? tipAmount,
    List<PaymentSplit>? paymentSplits,
    required String payment,
    DiscountType? discountType,
    int? discountValue,
    String? discountId,
  }) {
    _update(state.copyWith(
      customerName: customerName,
      clearCustomer: customerName == null,
      amountTendered: amountTendered,
      clearTendered: amountTendered == null,
      tipAmount: tipAmount,
      paymentSplits: paymentSplits,
      clearSplits: paymentSplits == null,
      payment: payment,
      discountType: discountType,
      discountValue: discountValue,
      discountId: discountId,
      clearDiscount: discountType == null && (discountValue ?? 0) == 0,
      clearDiscountId: discountId == null,
    ));
  }

  void clear() {
    _lastRemovedItem = null;
    _lastRemovedIndex = null;
    _update(CartState(
      id: state.id,
      displayName: state.displayName,
      createdAt: state.createdAt ?? TimeUtils.now(),
      taxRate: _taxRate,
    ));
  }

  void replaceWith(CartState newState) {
    _lastRemovedItem = null;
    _lastRemovedIndex = null;
    // Drafts come from storage without a tax rate — inject the session rate.
    _update(newState.copyWith(taxRate: _taxRate));
  }

  void startNewOrder({String? id, String? displayName}) {
    _lastRemovedItem = null;
    _lastRemovedIndex = null;
    _update(CartState(
      id: id ?? 'order_${TimeUtils.now().millisecondsSinceEpoch}',
      displayName: displayName ?? 'Order 1',
      createdAt: TimeUtils.now(),
      taxRate: _taxRate,
    ));
  }

  void renameDisplayName(String name) {
    _update(state.copyWith(
      displayName: name.trim().isEmpty ? 'Order' : name.trim(),
    ));
  }

  /// Idempotency key for [POST /orders] — stable per tab until a new order starts.
  String idempotencyKey() => state.id ?? 'order_${TimeUtils.now().millisecondsSinceEpoch}';
}

final cartProvider =
    NotifierProvider<CartNotifier, CartState>(CartNotifier.new);
