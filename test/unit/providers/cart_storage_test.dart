import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/shift.dart';
import 'package:sufrix_pos/core/providers/cart_storage.dart';

void main() {
  group('cartStorageScope', () {
    test('returns null if shift is null', () {
      expect(cartStorageScope(null), isNull);
    });

    test('returns scoped string', () {
      final shift = Shift(
        id: 's1',
        branchId: 'b1',
        tellerId: 't1',
        tellerName: 'John',
        status: 'open',
        openingCash: 100,
        openedAt: DateTime.now(),
      );

      expect(cartStorageScope(shift), 'b1_s1');
    });
  });
}
