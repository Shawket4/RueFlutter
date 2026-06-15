import 'package:flutter/material.dart';
import '../utils/haptics.dart';

// ═════════════════════════════════════════════════════════════════════════════
//  SUFRIX DESIGN SYSTEM
//
//  Brand anchors (unchanged): Sufrix Navy #0A2540 · Terracotta #C25B3F.
//  New identity: terracotta is THE action color, navy owns chrome and text,
//  green/red are reserved for money-in / money-out. Light and dark themes
//  share the same semantic tokens via [AppTokens] — screens read
//  `context.tokens` and never hardcode hex values.
//
//  Typography: bundled Cairo (no runtime font fetch — first launch offline
//  renders Arabic correctly). Hierarchy by weight: w400/500 body, w600
//  titles, w700–800 reserved for amounts and screen headers.
// ═════════════════════════════════════════════════════════════════════════════

// ─────────────────────────────────────────────────────────────────────────────
//  BRAND CONSTANTS
// ─────────────────────────────────────────────────────────────────────────────

class AppBrand {
  static const navy = Color(0xFF0A2540);
  static const terracotta = Color(0xFFC25B3F);
  static const terracottaBright = Color(0xFFE07856); // dark-theme accent
  static const cream = Color(0xFFFAF7F2);
}

// ─────────────────────────────────────────────────────────────────────────────
//  SEMANTIC TOKENS (ThemeExtension — light & dark variants)
// ─────────────────────────────────────────────────────────────────────────────

class AppTokens extends ThemeExtension<AppTokens> {
  // Surfaces
  final Color bg;
  final Color surface;
  final Color surfaceAlt; // subtle alternate (warm in light, raised in dark)
  final Color surfaceRaised; // sheets, dialogs, popovers
  final Color border;
  final Color borderLight;

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color textOnAccent;

  // Brand / action
  final Color accent; // terracotta — primary actions
  final Color accentBg; // tinted background behind accent content
  final Color navy; // chrome, headers, selected states
  final Color navyBg;

  // Status
  final Color success;
  final Color successBg;
  final Color danger;
  final Color dangerBg;
  final Color warning;
  final Color warningBg;

  // Effects
  final Color shadow;
  final Color hoverOverlay;
  final Color pressOverlay;

  const AppTokens({
    required this.bg,
    required this.surface,
    required this.surfaceAlt,
    required this.surfaceRaised,
    required this.border,
    required this.borderLight,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.textOnAccent,
    required this.accent,
    required this.accentBg,
    required this.navy,
    required this.navyBg,
    required this.success,
    required this.successBg,
    required this.danger,
    required this.dangerBg,
    required this.warning,
    required this.warningBg,
    required this.shadow,
    required this.hoverOverlay,
    required this.pressOverlay,
  });

  bool get isDark => bg.computeLuminance() < 0.2;

  /// Light = the ORIGINAL Sufrix palette (user preference): navy is the
  /// action color, original grays/tints. The new visual identity lives in
  /// the dark theme.
  static const light = AppTokens(
    bg: Color(0xFFF4F6F8),
    surface: Colors.white,
    surfaceAlt: Color(0xFFFAF7F2),
    surfaceRaised: Colors.white,
    border: Color(0xFFE5E7EB),
    borderLight: Color(0xFFF3F4F6),
    textPrimary: Color(0xFF0A2540),
    textSecondary: Color(0xFF6B7280),
    textMuted: Color(0xFF9CA3AF),
    textOnAccent: Colors.white,
    accent: AppBrand.navy,
    accentBg: Color(0xFFE9EEF4),
    navy: AppBrand.navy,
    navyBg: Color(0xFFE9EEF4),
    success: Color(0xFF16A34A),
    successBg: Color(0xFFE7F6EC),
    danger: Color(0xFFDC2626),
    dangerBg: Color(0xFFFBEAEA),
    warning: Color(0xFFD97706),
    warningBg: Color(0xFFFBF1E0),
    shadow: Color(0x0D111827),
    hoverOverlay: Color(0x0A0A2540),
    pressOverlay: Color(0x140A2540),
  );

  static const dark = AppTokens(
    bg: Color(0xFF0A111B),
    surface: Color(0xFF111B28),
    surfaceAlt: Color(0xFF152133),
    surfaceRaised: Color(0xFF182436),
    border: Color(0xFF243349),
    borderLight: Color(0xFF1B2940),
    textPrimary: Color(0xFFEAF0F7),
    textSecondary: Color(0xFFA3B3C7),
    textMuted: Color(0xFF65788F),
    textOnAccent: Colors.white,
    accent: AppBrand.terracottaBright,
    accentBg: Color(0xFF33231F),
    navy: Color(0xFF8FB4DD), // lightened navy for dark chrome accents
    navyBg: Color(0xFF1A2A3F),
    success: Color(0xFF3BCE7E),
    successBg: Color(0xFF13291D),
    danger: Color(0xFFF4655A),
    dangerBg: Color(0xFF33191B),
    warning: Color(0xFFF0A23F),
    warningBg: Color(0xFF332512),
    shadow: Color(0x66000000),
    hoverOverlay: Color(0x0DFFFFFF),
    pressOverlay: Color(0x1AFFFFFF),
  );

  @override
  AppTokens copyWith() => this;

  @override
  AppTokens lerp(ThemeExtension<AppTokens>? other, double t) {
    if (other is! AppTokens) return this;
    Color c(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppTokens(
      bg: c(bg, other.bg),
      surface: c(surface, other.surface),
      surfaceAlt: c(surfaceAlt, other.surfaceAlt),
      surfaceRaised: c(surfaceRaised, other.surfaceRaised),
      border: c(border, other.border),
      borderLight: c(borderLight, other.borderLight),
      textPrimary: c(textPrimary, other.textPrimary),
      textSecondary: c(textSecondary, other.textSecondary),
      textMuted: c(textMuted, other.textMuted),
      textOnAccent: c(textOnAccent, other.textOnAccent),
      accent: c(accent, other.accent),
      accentBg: c(accentBg, other.accentBg),
      navy: c(navy, other.navy),
      navyBg: c(navyBg, other.navyBg),
      success: c(success, other.success),
      successBg: c(successBg, other.successBg),
      danger: c(danger, other.danger),
      dangerBg: c(dangerBg, other.dangerBg),
      warning: c(warning, other.warning),
      warningBg: c(warningBg, other.warningBg),
      shadow: c(shadow, other.shadow),
      hoverOverlay: c(hoverOverlay, other.hoverOverlay),
      pressOverlay: c(pressOverlay, other.pressOverlay),
    );
  }
}

extension AppTokensX on BuildContext {
  AppTokens get tokens =>
      Theme.of(this).extension<AppTokens>() ?? AppTokens.light;
}

// ─────────────────────────────────────────────────────────────────────────────
//  LEGACY COLORS — kept so not-yet-migrated screens keep compiling.
//  New code must use `context.tokens` instead.
// ─────────────────────────────────────────────────────────────────────────────

class AppColors {
  static const primary = AppBrand.navy;
  static const secondary = AppBrand.terracotta;
  static const success = Color(0xFF16A34A);
  static const danger = Color(0xFFDC2626);
  static const warning = Color(0xFFD97706);

  static const bg = Color(0xFFF4F6F8);
  static const warmCream = AppBrand.cream;
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
//  TYPOGRAPHY — bundled Cairo (assets/fonts), no network fetch.
// ─────────────────────────────────────────────────────────────────────────────

const kFontFamily = 'Cairo';

/// Money figures must align in columns.
const kTabularFigures = [FontFeature.tabularFigures()];

/// Legacy helper — defaults preserved (w800) for not-yet-migrated screens.
/// New code should use Theme.of(context).textTheme or [money]/[ui] helpers.
TextStyle cairo({
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.w800,
  Color color = AppColors.textPrimary,
  double? height,
  double letterSpacing = 0,
  TextDecoration? decoration,
  FontStyle? fontStyle,
}) =>
    TextStyle(
      fontFamily: kFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
      fontStyle: fontStyle,
    );

/// General-purpose UI text (color defaults to the ambient DefaultTextStyle).
TextStyle ui({
  double size = 14,
  FontWeight weight = FontWeight.w500,
  Color? color,
  double? height,
  double letterSpacing = 0,
}) =>
    TextStyle(
      fontFamily: kFontFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );

/// Monetary amounts: bold + tabular figures so totals line up.
TextStyle money({
  double size = 16,
  FontWeight weight = FontWeight.w700,
  Color? color,
  double? height,
}) =>
    TextStyle(
      fontFamily: kFontFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      fontFeatures: kTabularFigures,
    );

// ─────────────────────────────────────────────────────────────────────────────
//  SHADOWS
// ─────────────────────────────────────────────────────────────────────────────

class AppShadows {
  static List<BoxShadow> of(AppTokens t) => [
        BoxShadow(color: t.shadow, blurRadius: 8, offset: const Offset(0, 2)),
      ];

  static List<BoxShadow> raised(AppTokens t) => [
        BoxShadow(color: t.shadow, blurRadius: 18, offset: const Offset(0, 6)),
      ];

  // ── Legacy static variants (light-theme values) ──────────────────────────
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
//  RADIUS & SPACING
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

/// 4-pt spacing scale. Use these instead of magic numbers.
class AppSpace {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

// ─────────────────────────────────────────────────────────────────────────────
//  ANIMATED PRESS SCALE  — replaces Material ripple with a tactile scale anim.
// ─────────────────────────────────────────────────────────────────────────────

class AnimatedPressScale extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double scaleDown;

  /// Fires [Haptics.selection] on tap (and [Haptics.impact] on long-press) so
  /// every press surface buzzes consistently. Set false for the rare surface
  /// that shouldn't (e.g. a tap that only expands/collapses inert content).
  final bool haptic;

  const AnimatedPressScale({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.scaleDown = 0.97,
    this.haptic = true,
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
        onTap: widget.onTap == null
            ? null
            : () {
                if (widget.haptic) Haptics.selection();
                widget.onTap!();
              },
        onLongPress: widget.onLongPress == null
            ? null
            : () {
                if (widget.haptic) Haptics.impact();
                widget.onLongPress!();
              },
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
  static ThemeData get light => _build(AppTokens.light, Brightness.light);
  static ThemeData get dark => _build(AppTokens.dark, Brightness.dark);

  static TextTheme _textTheme(AppTokens t) {
    TextStyle s(double size, FontWeight w,
            {Color? color, double ls = 0, double? height}) =>
        TextStyle(
          fontFamily: kFontFamily,
          fontSize: size,
          fontWeight: w,
          color: color ?? t.textPrimary,
          letterSpacing: ls,
          height: height,
        );

    return TextTheme(
      displayLarge: s(46, FontWeight.w800),
      displayMedium: s(36, FontWeight.w800),
      displaySmall: s(30, FontWeight.w700),
      headlineLarge: s(26, FontWeight.w700),
      headlineMedium: s(22, FontWeight.w700),
      headlineSmall: s(19, FontWeight.w700),
      titleLarge: s(17, FontWeight.w700),
      titleMedium: s(15, FontWeight.w600),
      titleSmall: s(13, FontWeight.w600),
      bodyLarge: s(16, FontWeight.w500, height: 1.45),
      bodyMedium: s(14, FontWeight.w500, height: 1.45),
      bodySmall: s(12, FontWeight.w500, color: t.textSecondary, height: 1.4),
      labelLarge: s(14, FontWeight.w600, ls: 0.1),
      labelMedium: s(12, FontWeight.w600, ls: 0.2, color: t.textSecondary),
      labelSmall: s(11, FontWeight.w600, ls: 0.4, color: t.textMuted),
    );
  }

  static ThemeData _build(AppTokens t, Brightness brightness) {
    final textTheme = _textTheme(t);
    final isDark = brightness == Brightness.dark;

    final scheme = ColorScheme(
      brightness: brightness,
      primary: t.accent,
      onPrimary: t.textOnAccent,
      secondary: t.navy,
      onSecondary: isDark ? const Color(0xFF0A1118) : Colors.white,
      error: t.danger,
      onError: Colors.white,
      surface: t.surface,
      onSurface: t.textPrimary,
      surfaceContainerHighest: t.surfaceAlt,
      outline: t.border,
      outlineVariant: t.borderLight,
      shadow: t.shadow,
    );

    InputBorder inputBorder(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: color, width: width),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      extensions: [t],

      // Kill all Material ripple/splash effects globally.
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,

      colorScheme: scheme,
      scaffoldBackgroundColor: t.bg,
      canvasColor: t.surface,
      cardColor: t.surface,
      dividerColor: t.border,
      shadowColor: t.shadow,
      textTheme: textTheme,
      iconTheme: IconThemeData(color: t.textSecondary, size: 20),

      appBarTheme: AppBarTheme(
        backgroundColor: t.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge,
        iconTheme: IconThemeData(color: t.textPrimary, size: 20),
      ),

      // Buttons: terracotta actions, zero elevation, zero splash.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: t.accent,
          foregroundColor: t.textOnAccent,
          disabledBackgroundColor: t.border,
          disabledForegroundColor: t.textMuted,
          elevation: 0,
          shadowColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.sm)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: ui(size: 15, weight: FontWeight.w700),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: t.accent,
          foregroundColor: t.textOnAccent,
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.sm)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: ui(size: 15, weight: FontWeight.w700),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: t.textPrimary,
          side: BorderSide(color: t.border),
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.sm)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: ui(size: 15, weight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: t.accent,
          splashFactory: NoSplash.splashFactory,
          textStyle: ui(size: 14, weight: FontWeight.w600),
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
        fillColor: t.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: inputBorder(t.border),
        enabledBorder: inputBorder(t.border),
        focusedBorder: inputBorder(t.accent, 2),
        errorBorder: inputBorder(t.danger),
        focusedErrorBorder: inputBorder(t.danger, 2),
        hintStyle: ui(size: 15, color: t.textMuted),
        labelStyle: ui(size: 14, color: t.textSecondary),
      ),

      dividerTheme: DividerThemeData(
        color: t.border,
        thickness: 1,
        space: 1,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: t.surfaceRaised,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg)),
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle:
            ui(size: 14, color: t.textSecondary, height: 1.5),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: t.surfaceRaised,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: t.surfaceRaised,
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? t.surfaceRaised : const Color(0xFF1F2937),
        contentTextStyle:
            ui(size: 14, color: Colors.white, weight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
      ),

      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: t.surface,
        indicatorColor: t.accentBg,
        selectedIconTheme: IconThemeData(color: t.accent, size: 22),
        unselectedIconTheme: IconThemeData(color: t.textMuted, size: 22),
        selectedLabelTextStyle:
            ui(size: 11, weight: FontWeight.w700, color: t.accent),
        unselectedLabelTextStyle:
            ui(size: 11, weight: FontWeight.w600, color: t.textMuted),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: t.surface,
        indicatorColor: t.accentBg,
        surfaceTintColor: Colors.transparent,
        iconTheme: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? IconThemeData(color: t.accent, size: 22)
                : IconThemeData(color: t.textMuted, size: 22)),
        labelTextStyle: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? ui(size: 11, weight: FontWeight.w700, color: t.accent)
                : ui(size: 11, weight: FontWeight.w600, color: t.textMuted)),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? Colors.white : t.textMuted),
        trackColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? t.accent : t.borderLight),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: t.surfaceAlt,
        selectedColor: t.accentBg,
        labelStyle: ui(size: 13, weight: FontWeight.w600),
        side: BorderSide(color: t.border),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.pill)),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(color: t.accent),
    );
  }
}
