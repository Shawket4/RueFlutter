import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/client.dart';
import '../api/delivery_api.dart';
import '../models/delivery_settings.dart';

class DeliverySettingsState {
  final DeliverySettings? settings;
  final bool isLoading;
  final String? error;

  const DeliverySettingsState({
    this.settings,
    this.isLoading = false,
    this.error,
  });

  DeliverySettingsState copyWith({
    DeliverySettings? settings,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) =>
      DeliverySettingsState(
        settings: settings ?? this.settings,
        isLoading: isLoading ?? this.isLoading,
        error: clearError ? null : (error ?? this.error),
      );
}

/// Holds the branch's delivery settings for the POS, primarily so the teller
/// can read + flip the per-channel accepting override (auto/open/closed) via
/// `POST /delivery/accepting`. Loaded when the delivery screen opens; updated
/// in place from the authoritative response on every override change.
class DeliverySettingsNotifier extends Notifier<DeliverySettingsState> {
  @override
  DeliverySettingsState build() => const DeliverySettingsState();

  Future<void> load(String branchId) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final s = await ref.read(deliveryApiProvider).getSettings(branchId);
      state = state.copyWith(settings: s, isLoading: false);
    } catch (e) {
      // Non-fatal for the queue, but surface the SPECIFIC reason (e.g. the
      // server's "Permission denied: …" or "signed in to a different branch")
      // so a permission/branch problem isn't an invisible missing toggle.
      state = state.copyWith(isLoading: false, error: friendlyError(e));
    }
  }

  /// Flip a channel's accepting override and adopt the authoritative result.
  /// Rethrows so the caller can surface a message — notably the 409 the backend
  /// returns when trying to open a channel the dashboard has disabled.
  Future<void> setMode(String branchId, String channel, String mode) async {
    final updated = await ref
        .read(deliveryApiProvider)
        .setAccepting(branchId, channel: channel, mode: mode);
    state = state.copyWith(settings: updated);
  }
}

final deliverySettingsProvider =
    NotifierProvider<DeliverySettingsNotifier, DeliverySettingsState>(
        DeliverySettingsNotifier.new);
