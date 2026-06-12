import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/discount.dart';

import '../../helpers/model_fixtures.dart';

void main() {
  group('Discount', () {
    test('fromJson & toJson', () {
      final json = {
        'id': 'd1',
        'org_id': 'org1',
        'name': 'Staff Discount',
        'name_translations': {'en': 'Staff Discount'},
        'dtype': 'percentage',
        'value': 10,
        'is_active': true,
        'created_at': '2026-01-01T00:00:00.000Z',
        'updated_at': '2026-01-01T00:00:00.000Z',
      };

      final d = Discount.fromJson(json);
      expect(d.id, 'd1');
      expect(d.orgId, 'org1');
      expect(d.name, 'Staff Discount');
      expect(d.dtype, 'percentage');
      expect(d.value, 10);
      expect(d.isActive, true);

      final out = d.toJson();
      expect(out['id'], 'd1');
      expect(out['org_id'], 'org1');
      expect(out['name'], 'Staff Discount');
      expect(out['dtype'], 'percentage');
      expect(out['value'], 10);
      expect(out['is_active'], true);
    });

    test('label for percentage', () {
      final d = makeDiscount(name: 'Staff', dtype: 'percentage', value: 15);
      expect(d.label, 'Staff (15%)');
    });

    test('label for fixed with whole number', () {
      final d = makeDiscount(name: 'Promo', dtype: 'fixed', value: 500);
      expect(d.label, 'Promo (EGP 5 off)');
    });

    test('label for fixed with decimals', () {
      final d = makeDiscount(name: 'Promo', dtype: 'fixed', value: 550);
      expect(d.label, 'Promo (EGP 5.50 off)');
    });
  });
}
