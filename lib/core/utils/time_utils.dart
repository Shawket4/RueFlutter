import 'dart:io';

import '../db/kv_store.dart';

/// Server-anchored clock.
///
/// The device wall clock can be wrong (mis-set date/time/zone). To stamp
/// trustworthy instants we keep an [_offset] = (server time − device time),
/// learned from the HTTP `Date` header on every backend response. `now()` then
/// returns the corrected instant. The offset is PERSISTED so it survives an
/// offline restart (a clock that's wrong by a constant amount stays corrected).
///
/// Offline work that's stamped with a stale offset is re-based to the fresh
/// offset when it syncs (the outbox does this) — sync requires connectivity, so
/// the offset is always trustworthy at send time.
class TimeUtils {
  static Duration _offset = Duration.zero;
  static KvStore? _kv;
  static const _kOffsetKey = 'clock.offset_ms';

  /// Load the persisted offset. Call once at startup after [KvStore.init].
  static void init(KvStore kv) {
    _kv = kv;
    final ms = int.tryParse(kv.getString(_kOffsetKey) ?? '');
    if (ms != null) _offset = Duration(milliseconds: ms);
  }

  /// Recompute the offset from an authoritative server instant and persist it.
  /// Uses UTC on both sides so the device's timezone setting can't skew it.
  static void updateOffset(DateTime serverUtcTime) {
    final deviceUtcTime = DateTime.now().toUtc();
    _offset = serverUtcTime.difference(deviceUtcTime);
    _kv?.setString(_kOffsetKey, _offset.inMilliseconds.toString()).ignore();
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

  /// Current server-vs-device offset (server − device).
  static Duration get offset => _offset;

  /// Current offset in milliseconds (for re-basing queued timestamps at sync).
  static int get offsetMs => _offset.inMilliseconds;

  /// Magnitude of the device's clock error vs the server, as last measured.
  static Duration get skew => _offset.abs();
}
