import 'package:flutter/foundation.dart';

/// One diagnostic event. Kept deliberately tiny — this is a POS terminal,
/// not a telemetry pipeline.
class AppLogEntry {
  final DateTime at;
  final String tag;
  final String message;
  const AppLogEntry(this.at, this.tag, this.message);

  @override
  String toString() =>
      '${at.toIso8601String().substring(0, 19)} [$tag] $message';
}

/// In-memory ring buffer of warnings that would otherwise be swallowed
/// (cache corruption, sync anomalies). Surfaced in Settings → Diagnostics so
/// field issues can actually be diagnosed.
class AppLog {
  AppLog._();

  static const _capacity = 200;
  static final List<AppLogEntry> _buffer = [];

  static List<AppLogEntry> get entries => List.unmodifiable(_buffer);

  static void warn(String tag, String message) {
    debugPrint('[$tag] $message');
    _buffer.add(AppLogEntry(DateTime.now(), tag, message));
    if (_buffer.length > _capacity) _buffer.removeAt(0);
  }

  static void clear() => _buffer.clear();
}
