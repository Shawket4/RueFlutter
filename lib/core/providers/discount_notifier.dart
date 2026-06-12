import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/client.dart';
import '../api/discount_api.dart';
import '../models/discount.dart';
import '../storage/storage_service.dart';

class DiscountState {
  final List<Discount> items;
  final bool isLoading;
  final String? loadedOrgId;

  /// Set only when the API failed AND there is nothing cached to show —
  /// the UI must explain an empty list instead of rendering a silent blank.
  final String? error;

  const DiscountState({
    this.items = const [],
    this.isLoading = false,
    this.loadedOrgId,
    this.error,
  });

  DiscountState copyWith({
    List<Discount>? items,
    bool? isLoading,
    String? loadedOrgId,
    String? error,
    bool clearError = false,
  }) =>
      DiscountState(
        items: items ?? this.items,
        isLoading: isLoading ?? this.isLoading,
        loadedOrgId: loadedOrgId ?? this.loadedOrgId,
        error: clearError ? null : (error ?? this.error),
      );
}

class DiscountNotifier extends Notifier<DiscountState> {
  @override
  DiscountState build() => const DiscountState();

  Future<void> load(String orgId, {bool force = false}) async {
    if (!force && state.loadedOrgId == orgId && state.items.isNotEmpty) return;

    final storage = ref.read(storageServiceProvider);

    // First load OR org changed: drop the previous org's items and serve this
    // org's cache immediately so checkout works offline. (Keying on items
    // alone used to leak the previous branch's discounts on network failure.)
    if (state.loadedOrgId != orgId || state.items.isEmpty) {
      final cachedRaw = storage.loadDiscounts(orgId);
      // Pre-migration caches may miss keys the generated fromJson requires —
      // treat an undecodable cache as empty rather than crashing the load.
      List<Discount> cachedItems;
      try {
        cachedItems = cachedRaw.map(Discount.fromJson).toList();
      } catch (_) {
        cachedItems = const [];
      }
      state = state.copyWith(
        items: cachedItems,
        loadedOrgId: orgId,
        clearError: true,
      );
    }

    state = state.copyWith(isLoading: true);

    try {
      final api = ref.read(discountApiProvider);
      final list = await api.list(orgId);

      // Update cache
      await storage.saveDiscounts(
          orgId, list.map((e) => e.toJson()).toList());

      state = state.copyWith(
        isLoading: false,
        items: list,
        loadedOrgId: orgId,
        clearError: true,
      );
    } catch (e) {
      // Keep whatever this org has cached; only surface an error when the
      // list would otherwise be inexplicably empty.
      state = state.copyWith(
        isLoading: false,
        error: state.items.isEmpty ? friendlyError(e) : null,
      );
    }
  }
}

final discountProvider =
    NotifierProvider<DiscountNotifier, DiscountState>(DiscountNotifier.new);
