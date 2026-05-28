import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sufrix_pos/core/theme/app_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('AppTheme', () {
    test('light theme is generated correctly', () {
      final theme = AppTheme.light;
      expect(theme, isA<ThemeData>());
      expect(theme.scaffoldBackgroundColor, AppColors.bg);
      expect(theme.colorScheme.primary, AppColors.primary);
      expect(theme.useMaterial3, true);
    }, skip: 'Requires Google Fonts asset');

    test('AppColors provides expected values', () {
      expect(AppColors.primary, const Color(0xFF0A2540));
      expect(AppColors.successTint(0.5).alpha, 128); // 128 / 255 ≈ 0.5
    });

    test('cairo text style helper works', () {
      final style = cairo(fontSize: 16, fontWeight: FontWeight.bold);
      expect(style.fontSize, 16);
      expect(style.fontWeight, FontWeight.bold);
    }, skip: 'Requires Google Fonts asset');

    test('AppRadius has correct values', () {
      expect(AppRadius.sm, 12);
      expect(AppRadius.md, 16);
      expect(AppRadius.circular(10), BorderRadius.circular(10));
    });
  });
}
