import 'package:flutter/services.dart';

/// One tactile vocabulary for the whole app. Prefer these over calling
/// [HapticFeedback] directly so every surface speaks the same language and the
/// intensity for a given intent lives in exactly one place.
///
/// Most surfaces get feedback automatically: taps on [AnimatedPressScale]
/// (cards, tiles, chips, list rows) fire [selection], [AppButton] fires [tap]
/// (or [impact] for danger), and [AppToggle] fires [selection]. Call these
/// directly only for bespoke `GestureDetector`s or for the semantic moments
/// ([success], [warning]) that a generic tap can't infer.
abstract final class Haptics {
  /// Lightest tick — tapping a surface that selects or navigates: cards,
  /// tiles, chips, tabs, toggles, list rows. The default for tap surfaces.
  static void selection() => HapticFeedback.selectionClick();

  /// Soft tap — committing a small action through a button.
  static void tap() => HapticFeedback.lightImpact();

  /// Firmer — consequential confirmations: place/hold order, destructive
  /// trigger, a long-press, the primary FAB.
  static void impact() => HapticFeedback.mediumImpact();

  /// Terminal positive outcome: order placed, shift closed, item synced.
  static void success() => HapticFeedback.mediumImpact();

  /// Blocked or invalid action: validation failure, offline guard, error.
  static void warning() => HapticFeedback.heavyImpact();
}
