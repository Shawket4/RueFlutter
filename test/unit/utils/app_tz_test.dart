import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/utils/app_tz.dart';

void main() {
  group('AppTz', () {
    setUp(AppTz.init);

    test('renders a UTC instant in the configured branch timezone', () {
      // 2026-06-15 22:30 UTC.
      final utc = DateTime.utc(2026, 6, 15, 22, 30);

      AppTz.setBranchTimezone('Africa/Cairo'); // UTC+3 (DST) → 01:30 next day
      final cairo = AppTz.local(utc);
      expect(cairo.hour, 1);
      expect(cairo.minute, 30);
      expect(cairo.day, 16, reason: 'Cairo wall clock has rolled to the next day');

      AppTz.setBranchTimezone('America/New_York'); // UTC-4 (DST) → 18:30 same day
      final ny = AppTz.local(utc);
      expect(ny.hour, 18);
      expect(ny.minute, 30);
      expect(ny.day, 15);
    });

    test('business date can differ from the device near midnight', () {
      // The same instant is a different calendar day in two zones.
      final utc = DateTime.utc(2026, 1, 1, 0, 30); // 00:30 UTC Jan 1

      AppTz.setBranchTimezone('Africa/Cairo'); // +2 → 02:30 Jan 1
      expect(AppTz.local(utc).day, 1);

      AppTz.setBranchTimezone('America/New_York'); // -5 → 19:30 Dec 31
      final ny = AppTz.local(utc);
      expect(ny.day, 31);
      expect(ny.month, 12);
      expect(ny.year, 2025);
    });

    test('unknown timezone falls back to the current zone', () {
      AppTz.setBranchTimezone('Africa/Cairo');
      AppTz.setBranchTimezone('Not/AZone');
      expect(AppTz.location.name, 'Africa/Cairo');
    });
  });
}
