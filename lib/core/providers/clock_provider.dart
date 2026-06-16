import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/time_utils.dart';

/// Warn when the device clock is off from the server by more than this. Below it,
/// sub-minute drift is normal and not worth nagging about.
const kClockSkewWarnThreshold = Duration(minutes: 5);

/// The device's clock error vs the server (last measured), sampled so the UI can
/// surface a warning. [TimeUtils] updates the underlying offset on every backend
/// response; this just polls it for reactive display.
final clockSkewProvider = StreamProvider<Duration>((ref) async* {
  yield TimeUtils.skew;
  yield* Stream<Duration>.periodic(
    const Duration(seconds: 30),
    (_) => TimeUtils.skew,
  );
});
