import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sufrix_pos/core/models/order.dart';
import 'package:sufrix_pos/core/models/shift.dart';
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

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Widget buildSubject({
    required ShiftState shiftState,
    required OrderHistoryState historyState,
    MockOrderRepository? orderRepo,
  }) {
    return ProviderScope(
      overrides: [
        shiftProvider.overrideWith(() => FakeShiftNotifier(shiftState)),
        orderHistoryProvider.overrideWith(() => FakeOrderHistoryNotifier(historyState)),
        if (orderRepo != null) orderRepositoryProvider.overrideWithValue(orderRepo),
      ],
      child: const MaterialApp(
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
    );

    await tester.pumpWidget(buildSubject(
      shiftState: ShiftState(shift: shift),
      historyState: const OrderHistoryState(orders: []),
    ));

    expect(find.text('No orders yet for this shift'), findsOneWidget);
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
    );

    final orders = <Order>[
      Order(
        id: '1',
        branchId: 'b1',
        shiftId: 'shift1',
        tellerId: 't1',
        tellerName: 'Teller',
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
