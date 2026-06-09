import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  COLORS
// ─────────────────────────────────────────────────────────────────────────────

class AppColors {
  static const primary = Color(0xFF0A2540); // Sufrix Navy
  static const secondary = Color(0xFFC25B3F); // Terracotta
  static const success = Color(0xFF16A34A);
  static const danger = Color(0xFFDC2626);
  static const warning = Color(0xFFD97706);

  static const bg = Color(0xFFF4F6F8);
  static const warmCream = Color(0xFFFAF7F2);
  static const surface = Colors.white;
  static const border = Color(0xFFE5E7EB);
  static const borderLight = Color(0xFFF3F4F6);

  static const textPrimary = Color(0xFF0A2540);
  static const textSecondary = Color(0xFF6B7280);
  static const textMuted = Color(0xFF9CA3AF);

  static const onCreamMuted = Color(0x990A2540);
  static const onCreamSubtle = Color(0x800A2540);

  // Interactive overlays — used by custom tap widgets instead of Material ripple.
  static final hoverOverlay = primary.withOpacity(0.04);
  static final pressOverlay = primary.withOpacity(0.08);

  static Color primaryTint(double opacity) => primary.withOpacity(opacity);
  static Color successTint(double opacity) => success.withOpacity(opacity);
  static Color dangerTint(double opacity) => danger.withOpacity(opacity);
  static Color warningTint(double opacity) => warning.withOpacity(opacity);
}

// ─────────────────────────────────────────────────────────────────────────────
//  TYPOGRAPHY
// ─────────────────────────────────────────────────────────────────────────────

TextStyle cairo({
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.w800,
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

// ─────────────────────────────────────────────────────────────────────────────
//  SHADOWS
// ─────────────────────────────────────────────────────────────────────────────

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

  /// Subtle inset-style shadow for bottom bars / toolbars.
  static List<BoxShadow> get toolbar => [
        BoxShadow(
          color: const Color(0xFF111827).withOpacity(0.06),
          blurRadius: 12,
          offset: const Offset(0, -2),
        ),
      ];
}

// ─────────────────────────────────────────────────────────────────────────────
//  RADIUS
// ─────────────────────────────────────────────────────────────────────────────

class AppRadius {
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
  static const double pill = 999;

  static BorderRadius circular(double r) => BorderRadius.circular(r);
  static BorderRadius get cardRadius => BorderRadius.circular(md);
  static BorderRadius get sheetRadius =>
      const BorderRadius.vertical(top: Radius.circular(xl));
}

// ─────────────────────────────────────────────────────────────────────────────
//  ANIMATED PRESS SCALE  — replaces Material ripple with a tactile scale anim.
// ─────────────────────────────────────────────────────────────────────────────

class AnimatedPressScale extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double scaleDown;

  const AnimatedPressScale({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.scaleDown = 0.97,
  });

  @override
  State<AnimatedPressScale> createState() => _AnimatedPressScaleState();
}

class _AnimatedPressScaleState extends State<AnimatedPressScale>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 120),
    );
    _scale = Tween(begin: 1.0, end: widget.scaleDown).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onDown(TapDownDetails _) => _ctrl.forward();
  void _onUp(TapUpDetails _) => _ctrl.reverse();
  void _onCancel() => _ctrl.reverse();

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        onTapDown: _onDown,
        onTapUp: _onUp,
        onTapCancel: _onCancel,
        behavior: HitTestBehavior.opaque,
        child: ScaleTransition(scale: _scale, child: widget.child),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
//  THEME
// ─────────────────────────────────────────────────────────────────────────────

class AppTheme {
  static ThemeData get light {
    final base = TextTheme(
      displayLarge: cairo(fontSize: 57, fontWeight: FontWeight.w800),
      displayMedium: cairo(fontSize: 45, fontWeight: FontWeight.w800),
      displaySmall: cairo(fontSize: 36, fontWeight: FontWeight.w800),
      headlineLarge: cairo(fontSize: 32, fontWeight: FontWeight.w800),
      headlineMedium: cairo(fontSize: 28, fontWeight: FontWeight.w800),
      headlineSmall: cairo(fontSize: 24, fontWeight: FontWeight.w800),
      titleLarge: cairo(fontSize: 22, fontWeight: FontWeight.w800),
      titleMedium:
          cairo(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 0.15),
      titleSmall:
          cairo(fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 0.1),
      bodyLarge:
          cairo(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 0.5),
      bodyMedium:
          cairo(fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 0.25),
      bodySmall:
          cairo(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.4),
      labelLarge:
          cairo(fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 0.1),
      labelMedium:
          cairo(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.5),
      labelSmall:
          cairo(fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.5),
    );

    return ThemeData(
      useMaterial3: true,

      // Kill all Material ripple/splash effects globally.
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,

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
        titleTextStyle: cairo(
          fontSize: 17,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 20),
      ),

      // Buttons: zero elevation, zero splash, clean shapes.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.sm)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: cairo(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textSecondary,
          side: const BorderSide(color: AppColors.border),
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.sm)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: cairo(fontSize: 15, fontWeight: FontWeight.w800),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
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
        hintStyle: cairo(color: AppColors.textMuted, fontSize: 15),
        labelStyle: cairo(color: AppColors.textSecondary),
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
        titleTextStyle: cairo(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary),
        contentTextStyle:
            cairo(fontSize: 14, color: AppColors.textSecondary, height: 1.5),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1F2937),
        contentTextStyle: cairo(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w800),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
      ),
    );
  }
}
