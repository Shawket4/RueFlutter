import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart.dart';
import '../storage/storage_service.dart';
import '../utils/time_utils.dart';
import 'cart_notifier.dart';
import 'cart_storage.dart';
import 'shift_notifier.dart';

class CartDraft {
  final String id;
  final String name;
  final CartState cartState;
  final DateTime createdAt;

  const CartDraft({
    required this.id,
    required this.name,
    required this.cartState,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'cart_state': cartState.toStorageJson(),
        'created_at': createdAt.toIso8601String(),
      };

  factory CartDraft.fromJson(Map<String, dynamic> j) => CartDraft(
        id: j['id'] as String,
        name: j['name'] as String,
        cartState:
            CartState.fromStorageJson(j['cart_state'] as Map<String, dynamic>),
        createdAt: DateTime.parse(j['created_at'] as String),
      );
}

List<CartDraft> _draftsSortedByCreatedAt(List<CartDraft> drafts) {
  final sorted = List<CartDraft>.from(drafts);
  sorted.sort((a, b) => a.createdAt.compareTo(b.createdAt));
  return sorted;
}

CartDraft? _oldestDraft(List<CartDraft> drafts) {
  if (drafts.isEmpty) return null;
  return _draftsSortedByCreatedAt(drafts).first;
}

CartDraft? _oldestDraftWithItems(List<CartDraft> drafts) {
  final sorted = _draftsSortedByCreatedAt(drafts)
      .where((d) => !d.cartState.isEmpty);
  return sorted.isEmpty ? null : sorted.first;
}

class DraftCartsNotifier extends Notifier<List<CartDraft>> {
  String? _loadedScope;

  String? _scope() => cartStorageScope(ref.read(shiftProvider).shift);

  @override
  List<CartDraft> build() {
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

  List<CartDraft> _loadForScope(String? scope) {
    if (scope == null) return [];
    final storage = ref.read(storageServiceProvider);
    final raw = storage.loadDraftCartsWithLegacyMigration(scope);
    return raw.map(CartDraft.fromJson).toList();
  }

  Future<void> _saveDrafts() async {
    final scope = _scope();
    if (scope == null || scope != _loadedScope) return;
    await ref.read(storageServiceProvider).saveDraftCarts(
          scope,
          state.map((d) => d.toJson()).toList(),
        );
  }

  String _nextAutoName(CartState activeCart) {
    int maxNum = 0;
    final regex = RegExp(r'^Order\s*(\d+)$');

    for (final d in state) {
      final match = regex.firstMatch(d.name);
      if (match != null) {
        final val = int.tryParse(match.group(1) ?? '');
        if (val != null && val > maxNum) maxNum = val;
      }
    }

    if (activeCart.displayName != null) {
      final match = regex.firstMatch(activeCart.displayName!);
      if (match != null) {
        final val = int.tryParse(match.group(1) ?? '');
        if (val != null && val > maxNum) maxNum = val;
      }
    }

    return 'Order ${maxNum + 1}';
  }

  /// Promotes oldest held draft into active cart when active is empty (app resume).
  Future<bool> promoteOldestDraftIfActiveEmpty() async {
    final cart = ref.read(cartProvider);
    if (!cart.isEmpty) return false;
    final oldest = _oldestDraft(state);
    if (oldest == null) return false;
    state = state.where((d) => d.id != oldest.id).toList();
    await _saveDrafts();
    ref.read(cartProvider.notifier).replaceWith(oldest.cartState);
    return true;
  }

  /// After checkout: activate oldest held order that still has items.
  Future<bool> promoteOldestDraftWithItems() async {
    final oldest = _oldestDraftWithItems(state);
    if (oldest == null) return false;
    state = state.where((d) => d.id != oldest.id).toList();
    await _saveDrafts();
    ref.read(cartProvider.notifier).replaceWith(oldest.cartState);
    return true;
  }

  /// Park the current cart as a draft, then start a new empty cart. Returns false if empty.
  Future<bool> parkCurrentCart(CartState current) async {
    if (current.isEmpty) return false;

    final draft = CartDraft(
      id: current.id ?? 'order_${TimeUtils.now().millisecondsSinceEpoch}',
      name: current.displayName ?? _nextAutoName(current),
      cartState: current,
      createdAt: current.createdAt ?? TimeUtils.now(),
    );

    state = [...state, draft];
    await _saveDrafts();

    final nextName = _nextAutoName(current);
    ref.read(cartProvider.notifier).startNewOrder(
          id: 'order_${TimeUtils.now().millisecondsSinceEpoch}',
          displayName: nextName,
        );
    return true;
  }

  void switchDraft(String draftId, CartState current) {
    final idx = state.indexWhere((d) => d.id == draftId);
    if (idx < 0) return;
    final target = state[idx];

    final List<CartDraft> updated = List.from(state)..removeAt(idx);

    final parked = CartDraft(
      id: current.id ?? 'order_${TimeUtils.now().millisecondsSinceEpoch}',
      name: current.displayName ?? 'Order',
      cartState: current,
      createdAt: current.createdAt ?? TimeUtils.now(),
    );
    updated.add(parked);

    state = updated;
    _saveDrafts();

    ref.read(cartProvider.notifier).replaceWith(target.cartState);
  }

  void renameDraft(String draftId, String newName) {
    final trimmed = newName.trim();
    state = state.map((d) {
      if (d.id == draftId) {
        final label = trimmed.isEmpty ? d.name : trimmed;
        return CartDraft(
          id: d.id,
          name: label,
          cartState: d.cartState.copyWith(displayName: label),
          createdAt: d.createdAt,
        );
      }
      return d;
    }).toList();
    _saveDrafts();
  }

  Future<void> deleteDraft(String draftId) async {
    state = state.where((d) => d.id != draftId).toList();
    await _saveDrafts();
  }

  /// Oldest draft by [createdAt] (matches tab bar ordering).
  CartDraft? oldestHeldDraft() => _oldestDraft(state);

  Future<void> clearAllForCurrentScope() async {
    final scope = _scope();
    state = [];
    if (scope != null) {
      await ref.read(storageServiceProvider).clearCartDataForScope(scope);
    }
  }
}

final draftCartsProvider =
    NotifierProvider<DraftCartsNotifier, List<CartDraft>>(DraftCartsNotifier.new);
