import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/branch.dart' show PrinterBrand;
import 'package:sufrix_pos/core/models/order.dart';
import 'package:sufrix_pos/core/models/payment_method.dart';
import 'package:sufrix_pos/core/services/printer_service.dart';

import '../../helpers/model_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  setUpAll(() {
    const MethodChannel('net.nfet.printing').setMockMethodCallHandler((call) async {
      return <int>[]; 
    });
    const MethodChannel('com.starxpand_sdk_wrapper').setMockMethodCallHandler((call) async {
      return true;
    });
  });

  group('PrinterService', () {
    test('print returns error when printer is unreachable', () async {
      final order = Order(
        id: 'o1', branchId: 'b1', shiftId: 's1', tellerId: 't1', tellerName: 'Teller', 
        status: 'completed', paymentMethod: 'cash', orderNumber: 1, 
        amountTendered: 10, subtotal: 10, discountValue: 0, discountAmount: 0, 
        taxAmount: 0, totalAmount: 10, items: [], createdAt: DateTime.now(),
      );

      try {
        final result = await PrinterService.print(
          ip: '127.0.0.1',
          port: 9999, // Unlikely to be open
          brand: PrinterBrand.epson,
          order: order,
          paymentMethods: const <PaymentMethod>[],
          branchName: 'Test Branch',
        );

        // It should return an error string like "Epson printer error: Connection refused"
        expect(result, isNotNull);
        expect(result!.contains('error'), true);
      } catch (e) {
        if (e.toString().contains('Unable to load asset') || e.toString().contains('MissingPluginException')) {
          debugPrint('Skipping due to missing asset or plugin in test environment: $e');
        } else {
          rethrow;
        }
      }
    }, skip: 'Hardware/PDF rendering tests require real device or full plugin mock');

    test('printShiftReport returns error when printer is unreachable', () async {
      final report = makeShiftReport(
        shift: makeShift(
          id: 's1', branchId: 'b1', tellerName: 'Teller', status: 'closed',
          openingCash: 100, openedAt: DateTime.now(),
        ),
        totalPayments: 100, voidedAmount: 0, netPayments: 100,
        cashMovementsIn: 0, cashMovementsOut: 0, printedAt: DateTime.now(),
      );

      try {
        final result = await PrinterService.printShiftReport(
          ip: '127.0.0.1',
          port: 9999,
          brand: PrinterBrand.star,
          report: report,
          paymentMethods: const <PaymentMethod>[],
          branchName: 'Test Branch',
        );

        expect(result, isNotNull);
      } catch (e) {
        if (e.toString().contains('Unable to load asset') || e.toString().contains('MissingPluginException')) {
          debugPrint('Skipping due to missing asset or plugin in test environment: $e');
        } else {
          rethrow;
        }
      }
    }, skip: 'Hardware/PDF rendering tests require real device or full plugin mock');
  });
}
