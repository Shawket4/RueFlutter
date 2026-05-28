import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/services/connectivity_service.dart';

void main() {
  group('Connectivity Providers', () {
    test('isOnlineProvider defaults to ConnectivityService.instance.isOnline if no data', () {
      final container = ProviderContainer();
      
      final isOnline = container.read(isOnlineProvider);
      expect(isOnline, true); // It defaults to true inside ConnectivityService
    });

    test('isOnlineProvider yields stream data', () async {
      final container = ProviderContainer(
        overrides: [
          connectivityStreamProvider.overrideWith((ref) => Stream.value(false)),
        ],
      );

      await container.read(connectivityStreamProvider.future);
      
      final isOnline = container.read(isOnlineProvider);
      expect(isOnline, false);
    });
  });
}
