import 'dart:io';

class TimeUtils {
  static Duration _offset = Duration.zero;

  /// Call this with the Date header parsed from a successful backend response.
  static void updateOffset(DateTime serverUtcTime) {
    // We calculate offset using UTC comparison to avoid local timezone issues
    final deviceUtcTime = DateTime.now().toUtc();
    _offset = serverUtcTime.difference(deviceUtcTime);
  }

  /// Extracts and parses the HTTP Date header to update our offset.
  static void updateFromHeaders(Map<String, List<String>> headers) {
    try {
      final dateHeader = headers['date']?.first ?? headers['Date']?.first;
      if (dateHeader != null) {
        final serverTime = HttpDate.parse(dateHeader);
        updateOffset(serverTime);
      }
    } catch (e) {
      // Ignore parse errors, offset remains unchanged
    }
  }

  /// Use this INSTEAD of DateTime.now() to generate accurate timestamps
  /// perfectly synced with the backend.
  static DateTime now() {
    return DateTime.now().add(_offset);
  }
}
