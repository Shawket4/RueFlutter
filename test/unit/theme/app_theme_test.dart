import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/theme/app_theme.dart';

void main() {
  group('AppTheme', () {
    test('light theme is generated correctly', () {
      final theme = AppTheme.light;
      expect(theme, isA<ThemeData>());
      expect(theme.brightness, Brightness.light);
      expect(theme.scaffoldBackgroundColor, AppTokens.light.bg);
      expect(theme.colorScheme.primary, AppTokens.light.accent);
      expect(theme.useMaterial3, true);
      expect(theme.extension<AppTokens>(), AppTokens.light);
    });

    test('dark theme is generated correctly', () {
      final theme = AppTheme.dark;
      expect(theme, isA<ThemeData>());
      expect(theme.brightness, Brightness.dark);
      expect(theme.scaffoldBackgroundColor, AppTokens.dark.bg);
      expect(theme.colorScheme.primary, AppTokens.dark.accent);
      expect(theme.extension<AppTokens>(), AppTokens.dark);
    });

    test('themes use the bundled Cairo font family', () {
      expect(AppTheme.light.textTheme.bodyMedium?.fontFamily, kFontFamily);
      expect(AppTheme.dark.textTheme.titleLarge?.fontFamily, kFontFamily);
      expect(kFontFamily, 'Cairo');
    });

    test('AppTokens light/dark expose correct brightness flag', () {
      expect(AppTokens.light.isDark, false);
      expect(AppTokens.dark.isDark, true);
    });

    test('AppColors provides expected values', () {
      expect(AppColors.primary, const Color(0xFF0A2540));
      expect(AppColors.secondary, AppBrand.terracotta);
      expect(AppColors.successTint(0.5).alpha, 128); // 128 / 255 ≈ 0.5
    });

    test('cairo text style helper works', () {
      final style = cairo(fontSize: 16, fontWeight: FontWeight.bold);
      expect(style.fontSize, 16);
      expect(style.fontWeight, FontWeight.bold);
      expect(style.fontFamily, kFontFamily);
    });

    test('AppRadius has correct values', () {
      expect(AppRadius.sm, 12);
      expect(AppRadius.md, 16);
      expect(AppRadius.circular(10), BorderRadius.circular(10));
    });
  });
}
