import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xFF0A2540); // Sufrix Navy
  static const secondary = Color(0xFFC25B3F); // Terracotta
  static const success = Color(0xFF16A34A); // Success Green
  static const danger = Color(0xFFDC2626); // Destructive Red
  static const warning = Color(0xFFD97706); // Warning Amber

  static const bg = Color(0xFFF4F6F8); // Slate White Background
  static const surface = Colors.white;
  static const border = Color(0xFFE5E7EB); // Light gray border
  static const borderLight = Color(0xFFF3F4F6); // Extra light gray border

  static const textPrimary = Color(0xFF0A2540); // Sufrix Navy for primary text
  static const textSecondary = Color(0xFF6B7280); // Muted Slate Gray for secondary text
  static const textMuted = Color(0xFF9CA3AF);

  static Color primaryTint(double opacity) => primary.withOpacity(opacity);
  static Color successTint(double opacity) => success.withOpacity(opacity);
  static Color dangerTint(double opacity) => danger.withOpacity(opacity);
  static Color warningTint(double opacity) => warning.withOpacity(opacity);
}

TextStyle cairo({
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.w400,
  Color color = AppColors.textPrimary,
  double? height,
  double letterSpacing = 0,
  TextDecoration? decoration,
  FontStyle? fontStyle,
}) =>
    GoogleFonts.cairo(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontStyle: fontStyle,
    );

class AppShadows {
  static List<BoxShadow> get card => [
        BoxShadow(
          color: const Color(0xFF111827).withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        BoxShadow(
          color: const Color(0xFF111827).withOpacity(0.03),
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get md => [
        BoxShadow(
          color: const Color(0xFF111827).withOpacity(0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: const Color(0xFF111827).withOpacity(0.04),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ];

  static List<BoxShadow> primaryGlow() => [
        BoxShadow(
          color: AppColors.primary.withOpacity(0.22),
          blurRadius: 20,
          offset: const Offset(0, 6),
        ),
      ];
}

class AppRadius {
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;

  static BorderRadius circular(double r) => BorderRadius.circular(r);
  static BorderRadius get cardRadius => BorderRadius.circular(md);
  static BorderRadius get sheetRadius =>
      const BorderRadius.vertical(top: Radius.circular(xl));
}

class AppTheme {
  static ThemeData get light {
    final base = GoogleFonts.cairoTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        surface: AppColors.surface,
      ),
      scaffoldBackgroundColor: AppColors.bg,
      textTheme: base,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.cairo(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 20),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.sm)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle:
              GoogleFonts.cairo(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textSecondary,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.sm)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle:
              GoogleFonts.cairo(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        hintStyle: GoogleFonts.cairo(color: AppColors.textMuted, fontSize: 15),
        labelStyle: GoogleFonts.cairo(color: AppColors.textSecondary),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg)),
        titleTextStyle: GoogleFonts.cairo(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary),
        contentTextStyle: GoogleFonts.cairo(
            fontSize: 14, color: AppColors.textSecondary, height: 1.5),
      ),
      
      // Modern Toast SnackBar styling
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1F2937), // Elegant dark gray
        contentTextStyle: GoogleFonts.cairo(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
      ),
    );
  }
}
