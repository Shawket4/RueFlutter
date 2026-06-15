import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/api/shift_api.dart';
import 'package:sufrix_pos/core/l10n/app_localizations.dart';
import 'package:sufrix_pos/core/models/order.dart';
import 'package:sufrix_pos/core/models/shift.dart';
import 'package:sufrix_pos/core/providers/auth_notifier.dart';
import 'package:sufrix_pos/core/providers/order_history_notifier.dart';
import 'package:sufrix_pos/core/providers/shift_notifier.dart';
import 'package:sufrix_pos/core/repositories/order_repository.dart';
import 'package:sufrix_pos/features/order/order_history_screen.dart';
import 'package:mocktail/mocktail.dart';

class FakeShiftNotifier extends ShiftNotifier {
  final ShiftState _state;
  FakeShiftNotifier(this._state);

  @override
  ShiftState build() => _state;
}

class FakeAuthNotifier extends AuthNotifier {
  @override
  AuthState build() => const AuthState(isLoading: false);

  @override
  Future<void> init() async {}
}

class FakeOrderHistoryNotifier extends OrderHistoryNotifier {
  final OrderHistoryState _state;
  FakeOrderHistoryNotifier(this._state);
  
  @override
  OrderHistoryState build() => _state;
  
  @override
  Future<void> loadForShift(String shiftId, {bool force = false}) async {}
  
  @override
  Future<void> refresh(String shiftId) async {}
}

class MockOrderRepository extends Mock implements OrderRepository {}
class MockShiftApi extends Mock implements ShiftApi {}

void main() {
  Widget buildSubject({
    required ShiftState shiftState,
    required OrderHistoryState historyState,
    MockOrderRepository? orderRepo,
  }) {
    final mockShiftApi = MockShiftApi();
    when(() => mockShiftApi.getReport(any())).thenThrow(Exception('offline'));

    return ProviderScope(
      overrides: [
        authProvider.overrideWith(() => FakeAuthNotifier()),
        shiftProvider.overrideWith(() => FakeShiftNotifier(shiftState)),
        orderHistoryProvider.overrideWith(() => FakeOrderHistoryNotifier(historyState)),
        shiftApiProvider.overrideWithValue(mockShiftApi),
        if (orderRepo != null) orderRepositoryProvider.overrideWithValue(orderRepo),
      ],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: OrderHistoryScreen(),
      ),
    );
  }

  testWidgets('shows no open shift message if no shift', (tester) async {
    await tester.pumpWidget(buildSubject(
      shiftState: const ShiftState(),
      historyState: const OrderHistoryState(),
    ));

    expect(find.text('No open shift'), findsOneWidget);
  });

  testWidgets('shows loading indicator', (tester) async {
    final shift = Shift(
      id: 'shift1',
      branchId: 'b1',
      tellerId: 't1',
      tellerName: 'Teller',
      openedAt: DateTime.now(),
      status: 'open',
      openingCash: 100,
      openingCashWasEdited: false,
    );

    await tester.pumpWidget(buildSubject(
      shiftState: ShiftState(shift: shift),
      historyState: const OrderHistoryState(isLoading: true),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows empty state', (tester) async {
    final shift = Shift(
      id: 'shift1',
      branchId: 'b1',
      tellerId: 't1',
      tellerName: 'Teller',
      openedAt: DateTime.now(),
      status: 'open',
      openingCash: 100,
      openingCashWasEdited: false,
    );

    await tester.pumpWidget(buildSubject(
      shiftState: ShiftState(shift: shift),
      historyState: const OrderHistoryState(orders: []),
    ));

    expect(find.text('No orders yet'), findsOneWidget);
  });

  testWidgets('renders orders list', (tester) async {
    final shift = Shift(
      id: 'shift1',
      branchId: 'b1',
      tellerId: 't1',
      tellerName: 'Teller',
      openedAt: DateTime.now(),
      status: 'open',
      openingCash: 100,
      openingCashWasEdited: false,
    );

    final orders = <Order>[
      Order(
        id: '1',
        branchId: 'b1',
        shiftId: 'shift1',
        tellerId: 't1',
        tellerName: 'Teller',
        orderType: 'dine_in',
        deliveryFee: 0,
        orderNumber: 1001,
        paymentMethod: 'cash',
        status: 'completed',
        createdAt: DateTime.now(),
        subtotal: 100,
        discountValue: 0,
        discountAmount: 0,
        taxAmount: 14,
        totalAmount: 114,
        items: [],
      ),
    ];

    await tester.pumpWidget(buildSubject(
      shiftState: ShiftState(shift: shift),
      historyState: OrderHistoryState(orders: orders),
    ));

    expect(find.text('#1001'), findsOneWidget);
    expect(find.text('EGP 1.14'), findsWidgets);
  });
}
