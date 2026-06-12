import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storage/storage_service.dart';

const _kThemeModeKey = 'theme_mode';

/// Persisted theme mode (system / light / dark), toggled from Settings.
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final stored =
        ref.read(storageServiceProvider).raw.getString(_kThemeModeKey);
    return ThemeMode.values
            .where((m) => m.name == stored)
            .firstOrNull ??
        ThemeMode.system;
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;
    await ref
        .read(storageServiceProvider)
        .raw
        .setString(_kThemeModeKey, mode.name);
  }
}

final themeModeProvider =
    NotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);
