import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';

/// One audible vocabulary for the app, mirroring [Haptics]. Sounds are an
/// attention signal layered on top of haptics + the OS notification — a teller
/// who isn't looking at the screen still hears a new delivery order arrive.
///
/// Every call is best-effort and swallows errors: a missing asset or a busy /
/// unavailable audio device must NEVER break order intake.
abstract final class Sounds {
  static final AudioPlayer _player = AudioPlayer();

  /// Short ascending chime played when a brand-new delivery order arrives.
  static Future<void> newOrder() async {
    try {
      await _player.stop();
      await _player.setAsset('assets/sounds/new_order.wav');
      await _player.play();
    } catch (e) {
      if (kDebugMode) debugPrint('Sounds.newOrder failed: $e');
    }
  }
}
