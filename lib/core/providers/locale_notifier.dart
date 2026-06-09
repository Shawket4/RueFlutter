import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storage/storage_service.dart';

const _kLocaleKey = 'app_locale';

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    final stored = ref.read(storageServiceProvider).raw.getString(_kLocaleKey);
    if (stored != null && stored.isNotEmpty) {
      return Locale(stored);
    }
    // Default: use platform locale, fall back to English.
    final platform = PlatformDispatcher.instance.locale;
    return ['ar', 'en'].contains(platform.languageCode)
        ? Locale(platform.languageCode)
        : const Locale('en');
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    await ref.read(storageServiceProvider).raw.setString(
        _kLocaleKey, locale.languageCode);
  }
}

final localeProvider =
    NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);
