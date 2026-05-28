import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sufrix_pos/core/models/user.dart';
import 'package:sufrix_pos/core/providers/auth_notifier.dart';
import 'package:sufrix_pos/core/providers/shift_notifier.dart';
import 'package:sufrix_pos/core/providers/order_history_notifier.dart';
import 'package:sufrix_pos/core/services/offline_queue.dart';
import 'package:sufrix_pos/core/services/connectivity_service.dart';
import 'package:sufrix_pos/features/home/home_screen.dart';

class FakeAuthNotifier extends AuthNotifier {
  @override
  AuthState build() => const AuthState(user: User(id: '1', orgId: 'org1', branchId: 'b1', name: 'John Doe', role: 'admin', isActive: true));
}

class FakeShiftNotifier extends ShiftNotifier {
  @override
  ShiftState build() => const ShiftState();
  
  @override
  Future<void> load(String branchId) async {}
  
  @override
  Future<void> loadSystemCash() async {}
}

class FakeOrderHistoryNotifier extends OrderHistoryNotifier {
  @override
  OrderHistoryState build() => const OrderHistoryState();
  
  @override
  Future<void> loadForShift(String shiftId, {bool force = false}) async {}
}

class FakeOfflineQueueNotifier extends OfflineQueueNotifier {
  @override
  OfflineQueueState build() => const OfflineQueueState();
}

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Widget buildSubject() {
    return ProviderScope(
      overrides: [
        authProvider.overrideWith(() => FakeAuthNotifier()),
        shiftProvider.overrideWith(() => FakeShiftNotifier()),
        orderHistoryProvider.overrideWith(() => FakeOrderHistoryNotifier()),
        offlineQueueProvider.overrideWith(() => FakeOfflineQueueNotifier()),
        isOnlineProvider.overrideWithValue(true),
      ],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }

  testWidgets('renders home screen for active user without open shift', (tester) async {
    await tester.pumpWidget(buildSubject());

    // We need to wait for the post-frame load method to run
    await tester.pumpAndSettle();

    expect(find.textContaining(', John'), findsWidgets);
    expect(find.text('ADMIN'), findsWidgets);
    expect(find.text('No Open Shift'), findsWidgets);
  });
}
