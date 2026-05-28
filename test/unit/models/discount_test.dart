import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/discount.dart';

void main() {
  group('Discount', () {
    test('fromJson & toJson', () {
      final json = {
        'id': 'd1',
        'org_id': 'org1',
        'name': 'Staff Discount',
        'dtype': 'percentage',
        'value': 10,
        'is_active': true,
      };

      final d = Discount.fromJson(json);
      expect(d.id, 'd1');
      expect(d.orgId, 'org1');
      expect(d.name, 'Staff Discount');
      expect(d.dtype, 'percentage');
      expect(d.value, 10);
      expect(d.isActive, true);

      expect(d.toJson(), json);
    });

    test('label for percentage', () {
      const d = Discount(
        id: '1', orgId: '1', name: 'Staff', dtype: 'percentage', value: 15, isActive: true,
      );
      expect(d.label, 'Staff (15%)');
    });

    test('label for fixed with whole number', () {
      const d = Discount(
        id: '1', orgId: '1', name: 'Promo', dtype: 'fixed', value: 500, isActive: true, // 5 EGP
      );
      expect(d.label, 'Promo (EGP 5 off)');
    });

    test('label for fixed with decimals', () {
      const d = Discount(
        id: '1', orgId: '1', name: 'Promo', dtype: 'fixed', value: 550, isActive: true, // 5.50 EGP
      );
      expect(d.label, 'Promo (EGP 5.50 off)');
    });
  });
}
