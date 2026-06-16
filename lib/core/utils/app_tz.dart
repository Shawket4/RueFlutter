import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'app_log.dart';

/// Branch-timezone clock for the POS.
///
/// Instants are stored/transmitted in UTC (see [TimeUtils] + the API layer).
/// For DISPLAY and on-device business-day logic we must render those instants
/// in the **branch's configured timezone**, never the device's local zone — a
/// till whose OS timezone is wrong must still print/compute the correct local
/// time and business date.
///
/// The backend folds the org default into each branch's effective `timezone`
/// (branch → org → Africa/Cairo), so [setBranchTimezone] is fed straight from
/// `authProvider.branch?.timezone`.
class AppTz {
  AppTz._();

  static const String _fallback = 'Africa/Cairo';
  static bool _ready = false;
  static tz.Location? _loc;

  /// Load the IANA database. Call once at startup, before [runApp].
  static void init() {
    if (_ready) return;
    tzdata.initializeTimeZones();
    _ready = true;
    _loc = tz.getLocation(_fallback);
  }

  /// Point the clock at the active branch's timezone. Safe to call repeatedly
  /// (idempotent) and with a null/unknown value (keeps the current zone).
  static void setBranchTimezone(String? iana) {
    if (!_ready) return;
    final name = (iana == null || iana.isEmpty) ? _fallback : iana;
    if (_loc?.name == name) return;
    try {
      _loc = tz.getLocation(name);
    } catch (_) {
      AppLog.warn('app_tz', 'unknown timezone "$name" — keeping ${_loc?.name ?? _fallback}');
      _loc ??= tz.getLocation(_fallback);
    }
  }

  /// The active branch timezone location (falls back to Africa/Cairo).
  static tz.Location get location => _loc ??= _ready ? tz.getLocation(_fallback) : tz.UTC;

  /// Express an instant in the branch timezone for display / wall-clock reads.
  /// The returned [DateTime]'s `.year/.month/.day/.hour/.minute` are the
  /// branch-local values, so `DateFormat(...).format(local(dt))` renders in the
  /// branch zone regardless of the device timezone.
  static DateTime local(DateTime dt) {
    if (!_ready) return dt.toLocal();
    return tz.TZDateTime.from(dt, location);
  }
}
