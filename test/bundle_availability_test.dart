import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/models/bundle.dart';

import 'helpers/model_fixtures.dart';

/// Converts legacy minutes-since-midnight into the wire "HH:MM" format.
String? _hhmm(int? minutes) => minutes == null
    ? null
    : '${(minutes ~/ 60).toString().padLeft(2, '0')}:'
        '${(minutes % 60).toString().padLeft(2, '0')}';

Bundle _bundle({
  BundleStatus status = BundleStatus.active,
  List<String> branches = const [],
  DateTime? fromDate,
  DateTime? untilDate,
  int? fromMin,
  int? untilMin,
  List<BundleComponent> components = const [],
}) =>
    makeBundle(
      id: 'b1',
      orgId: 'o1',
      name: 'Breakfast Combo',
      price: 4500,
      status: status,
      displayOrder: 1,
      branchIds: branches,
      availableFromDate: fromDate,
      availableUntilDate: untilDate,
      availableFromTime: _hhmm(fromMin),
      availableUntilTime: _hhmm(untilMin),
      components: components,
    );

void main() {
  group('isBundleAvailableNow', () {
    test('active bundle with no restrictions is available', () {
      final b = _bundle();
      expect(
        isBundleAvailableNow(b, 'branch-1', DateTime(2026, 5, 20, 12)),
        isTrue,
      );
    });

    test('archived bundle is not available', () {
      final b = _bundle(status: BundleStatus.archived);
      expect(
        isBundleAvailableNow(b, 'branch-1', DateTime(2026, 5, 20, 12)),
        isFalse,
      );
    });

    test('branch restriction excludes other branches', () {
      final b = _bundle(branches: ['branch-a']);
      expect(
        isBundleAvailableNow(b, 'branch-b', DateTime(2026, 5, 20, 12)),
        isFalse,
      );
      expect(
        isBundleAvailableNow(b, 'branch-a', DateTime(2026, 5, 20, 12)),
        isTrue,
      );
    });

    test('date window is enforced', () {
      final b = _bundle(
        fromDate: DateTime(2026, 5, 21),
        untilDate: DateTime(2026, 5, 25),
      );
      expect(
        isBundleAvailableNow(b, 'branch-1', DateTime(2026, 5, 20, 12)),
        isFalse,
      );
      expect(
        isBundleAvailableNow(b, 'branch-1', DateTime(2026, 5, 22, 12)),
        isTrue,
      );
    });

    test('time window is enforced', () {
      final b = _bundle(fromMin: 9 * 60, untilMin: 17 * 60);
      expect(
        isBundleAvailableNow(b, 'branch-1', DateTime(2026, 5, 20, 8, 30)),
        isFalse,
      );
      expect(
        isBundleAvailableNow(b, 'branch-1', DateTime(2026, 5, 20, 10)),
        isTrue,
      );
    });
  });

}
