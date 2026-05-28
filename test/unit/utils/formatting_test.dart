import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:sufrix_pos/core/utils/formatting.dart';

void main() {
  group('Formatting Utils', () {
    test('egp formats currency correctly', () {
      expect(egp(100), 'EGP 1');
      expect(egp(150), 'EGP 1.50');
      expect(egp(0), 'EGP 0');
      expect(egp(-50), 'EGP -0.50');
    });

    test('egpD formats currency correctly', () {
      expect(egpD(100.0), 'EGP 1');
      expect(egpD(150.0), 'EGP 1.50');
    });

    test('normaliseName formats names correctly', () {
      expect(normaliseName('JOHN DOE'), 'John Doe');
      expect(normaliseName('jane doe'), 'Jane Doe');
      expect(normaliseName(' jANE dOE '), ' Jane Doe ');
    });

    test('comboLabel returns correct label', () {
      expect(comboLabel(), 'Combo');
      expect(comboLabel(useArabic: true), 'كومبو');
    });

    test('bundleItemCountLabel returns correct string', () {
      expect(bundleItemCountLabel(3), '3 items');
      expect(bundleItemCountLabel(3, useArabic: true), '3 أصناف');
    });

    test('bundleOutOfStockHint returns correct string', () {
      expect(bundleOutOfStockHint('Burger'), 'Burger is out of stock');
      expect(bundleOutOfStockHint('Burger', useArabic: true), 'Burger غير متوفر');
    });

    test('bundleSaveLabel returns correct string', () {
      expect(bundleSaveLabel(500), 'Save EGP 5');
      expect(bundleSaveLabel(500, useArabic: true), 'وفر EGP 5');
    });
  });
}
