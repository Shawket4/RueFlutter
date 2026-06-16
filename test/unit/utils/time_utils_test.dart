import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/utils/time_utils.dart';

void main() {
  group('TimeUtils', () {
    test('updateOffset makes now() track server time (device clock behind)', () {
      // Server is 2h ahead of this device's wall clock.
      TimeUtils.updateOffset(DateTime.now().toUtc().add(const Duration(hours: 2)));
      expect(TimeUtils.offset.inMinutes, inInclusiveRange(119, 121));
      expect(TimeUtils.skew.inMinutes, inInclusiveRange(119, 121));
      // now() is ~2h ahead of the raw device clock.
      final aheadMin = TimeUtils.now().difference(DateTime.now()).inMinutes;
      expect(aheadMin, inInclusiveRange(119, 121));
    });

    test('a backwards offset (device clock ahead) is captured too', () {
      TimeUtils.updateOffset(DateTime.now().toUtc().subtract(const Duration(minutes: 30)));
      expect(TimeUtils.offset.inMinutes, inInclusiveRange(-31, -29));
      expect(TimeUtils.skew.inMinutes, inInclusiveRange(29, 31));
    });

    test('offsetMs mirrors the offset for re-basing queued timestamps', () {
      TimeUtils.updateOffset(DateTime.now().toUtc().add(const Duration(minutes: 5)));
      expect(TimeUtils.offsetMs, inInclusiveRange(4 * 60000, 6 * 60000));
    });
  });
}
