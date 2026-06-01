import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/payment_method_api.dart';
import '../models/payment_method.dart';
import '../storage/storage_service.dart';

class PaymentMethodState {
  final List<PaymentMethod> items;
  final bool isLoading;
  final String? loadedOrgId;

  const PaymentMethodState({
    this.items = const [],
    this.isLoading = false,
    this.loadedOrgId,
  });

  PaymentMethodState copyWith({
    List<PaymentMethod>? items,
    bool? isLoading,
    String? loadedOrgId,
  }) =>
      PaymentMethodState(
        items: items ?? this.items,
        isLoading: isLoading ?? this.isLoading,
        loadedOrgId: loadedOrgId ?? this.loadedOrgId,
      );
}

class PaymentMethodNotifier extends Notifier<PaymentMethodState> {
  @override
  PaymentMethodState build() => const PaymentMethodState();

  Future<void> load(String orgId, {bool force = false}) async {
    if (!force && state.loadedOrgId == orgId && state.items.isNotEmpty) return;

    final storage = ref.read(storageServiceProvider);

    // Initial silent load from cache so it's instantly available offline
    if (state.items.isEmpty) {
      final cachedRaw = storage.loadPaymentMethods(orgId);
      if (cachedRaw.isNotEmpty) {
        state = state.copyWith(
          items: cachedRaw.map(PaymentMethod.fromJson).toList(),
          loadedOrgId: orgId,
        );
      }
    }

    state = state.copyWith(isLoading: true);
    
    try {
      final api = ref.read(paymentMethodApiProvider);
      final list = await api.list(orgId);
      
      // Update cache
      await storage.savePaymentMethods(
          orgId, list.map((e) => e.toJson()).toList());

      state = state.copyWith(
        isLoading: false,
        items: list,
        loadedOrgId: orgId,
      );
    } catch (_) {
      // Fallback gracefully without throwing, keep existing items
      state = state.copyWith(isLoading: false);
    }
  }
}

final paymentMethodProvider =
    NotifierProvider<PaymentMethodNotifier, PaymentMethodState>(PaymentMethodNotifier.new);
