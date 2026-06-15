import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Animated icons drawn and driven entirely in code (CustomPainter +
/// AnimationController) — no Lottie/Rive assets. They take their colour from
/// the caller so they stay theme-aware in both light and dark mode.

/// A success affirmation that LOOPS: a solid filled disc springs in, the white
/// check strokes through (the clean draw-in the outline had, now filled), the
/// badge breathes gently through a hold, then scales away — and repeats.
class SuccessCheckIcon extends StatefulWidget {
  final double size;
  final Color color;

  const SuccessCheckIcon({
    super.key,
    required this.color,
    this.size = 88,
  });

  @override
  State<SuccessCheckIcon> createState() => _SuccessCheckIconState();
}

class _SuccessCheckIconState extends State<SuccessCheckIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 3800),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, __) => CustomPaint(
          painter: _SuccessCheckPainter(t: _c.value, color: widget.color),
        ),
      ),
    );
  }
}

class _SuccessCheckPainter extends CustomPainter {
  final double t; // 0→1, repeating
  final Color color;
  _SuccessCheckPainter({required this.t, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final r = size.width * 0.40;

    // Whole-badge scale across the loop: spring in → breathe through the hold
    // → scale away. The check scales with it, so the badge enters and leaves
    // as one piece, then the cycle repeats.
    final double scale;
    if (t < 0.16) {
      scale = Curves.easeOutBack.transform(t / 0.16);
    } else if (t < 0.86) {
      scale = 1 + 0.03 * math.sin((t - 0.16) / 0.70 * 2 * math.pi);
    } else {
      scale = Curves.easeIn.transform(1 - (t - 0.86) / 0.14);
    }
    if (scale <= 0) return;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(scale);
    canvas.translate(-center.dx, -center.dy);

    // Filled disc.
    canvas.drawCircle(center, r, Paint()..color = color);

    // Check strokes through just after the disc springs in.
    final draw =
        Curves.easeOut.transform(((t - 0.12) / 0.16).clamp(0.0, 1.0));
    if (draw > 0) {
      final s = size.width / 64;
      final a = Offset(21 * s, 33 * s);
      final b = Offset(29 * s, 41 * s);
      final d = Offset(44 * s, 24 * s);
      final len1 = (b - a).distance;
      final len2 = (d - b).distance;
      final drawn = draw * (len1 + len2);
      final path = Path()..moveTo(a.dx, a.dy);
      if (drawn <= len1) {
        final f = drawn / len1;
        path.lineTo(a.dx + (b.dx - a.dx) * f, a.dy + (b.dy - a.dy) * f);
      } else {
        path.lineTo(b.dx, b.dy);
        final f = ((drawn - len1) / len2).clamp(0.0, 1.0);
        path.lineTo(b.dx + (d.dx - b.dx) * f, b.dy + (d.dy - b.dy) * f);
      }
      canvas.drawPath(
        path,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width * 0.065
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_SuccessCheckPainter old) =>
      old.t != t || old.color != color;
}

// ─────────────────────────────────────────────────────────────────────────────
//  DRIVERS — reusable controllers that play the painters below
// ─────────────────────────────────────────────────────────────────────────────

/// Taps play the icon's one-shot animation, then run [onPressed] after [delay]
/// — a short beat so the gesture reads before the screen changes. [builder]
/// receives the 0→1 animation value to paint with. Put your own visual chrome
/// (box, colour) inside [builder]; the haptic goes in [onTapDown].
class TapToPlayIcon extends StatefulWidget {
  final Widget Function(BuildContext context, double t) builder;
  final VoidCallback onPressed;
  final VoidCallback? onTapDown;
  final Duration duration;
  final Duration delay;

  const TapToPlayIcon({
    super.key,
    required this.builder,
    required this.onPressed,
    this.onTapDown,
    this.duration = const Duration(milliseconds: 340),
    this.delay = const Duration(milliseconds: 250),
  });

  @override
  State<TapToPlayIcon> createState() => _TapToPlayIconState();
}

class _TapToPlayIconState extends State<TapToPlayIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: widget.duration);

  void _tap() {
    widget.onTapDown?.call();
    _c.forward(from: 0);
    Future.delayed(widget.delay, () {
      if (mounted) widget.onPressed();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _tap,
        child: AnimatedBuilder(
          animation: _c,
          builder: (ctx, _) => widget.builder(ctx, _c.value),
        ),
      );
}

/// Continuously loops [builder] with a 0→1 value — for status indicators that
/// animate while some work is in flight (e.g. printing).
class LoopingIcon extends StatefulWidget {
  final Widget Function(BuildContext context, double t) builder;
  final Duration duration;

  const LoopingIcon({
    super.key,
    required this.builder,
    this.duration = const Duration(milliseconds: 1400),
  });

  @override
  State<LoopingIcon> createState() => _LoopingIconState();
}

class _LoopingIconState extends State<LoopingIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: widget.duration)..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _c,
        builder: (ctx, _) => widget.builder(ctx, _c.value),
      );
}

/// Scales the canvas so an icon authored in a 64-unit space (its content
/// bounding box [box]) fills [size] with a little padding, centred. Lets every
/// painter draw in the same 64-coordinate system the SVG previews used.
void _fit(Canvas canvas, Size size, Rect box, {double pad = 0.06}) {
  final s = math.min(
    size.width * (1 - 2 * pad) / box.width,
    size.height * (1 - 2 * pad) / box.height,
  );
  canvas.translate(
    size.width / 2 - (box.left + box.width / 2) * s,
    size.height / 2 - (box.top + box.height / 2) * s,
  );
  canvas.scale(s);
}

// ─────────────────────────────────────────────────────────────────────────────
//  PAINTERS — drawn in 64-unit space, matching the finalised previews
// ─────────────────────────────────────────────────────────────────────────────

/// Trash can: lid lifts and the body shakes once as [t] runs 0→1.
class TrashPainter extends CustomPainter {
  final double t;
  final Color color;
  final Color? fill;
  TrashPainter({required this.t, required this.color, this.fill});

  @override
  void paint(Canvas canvas, Size size) {
    _fit(canvas, size, const Rect.fromLTWH(16, 9, 31, 44));

    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final solid = Paint()..color = color;
    final rib = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final env = math.sin(math.pi * t.clamp(0.0, 1.0));
    final shakeX = math.sin(t * math.pi * 8) * 1.3 * env;

    canvas.save();
    canvas.translate(shakeX, 0);

    final body = Path()
      ..moveTo(21.5, 29)
      ..lineTo(42.5, 29)
      ..lineTo(40.5, 51)
      ..lineTo(23.5, 51)
      ..close();
    if (fill != null) canvas.drawPath(body, Paint()..color = fill!);
    canvas.drawPath(body, stroke);
    canvas.drawLine(const Offset(28.5, 34), const Offset(28.5, 49), rib);
    canvas.drawLine(const Offset(35.5, 34), const Offset(35.5, 49), rib);

    final lidAngle =
        -24 * math.sin(math.pi * (t / 0.85).clamp(0.0, 1.0)) * math.pi / 180;
    canvas.save();
    canvas.translate(19, 21);
    canvas.rotate(lidAngle);
    canvas.translate(-19, -21);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          const Rect.fromLTWH(18, 19, 28, 4), const Radius.circular(2)),
      solid,
    );
    final handle = Path()
      ..moveTo(27, 19)
      ..lineTo(27, 15.5)
      ..cubicTo(27, 11.5, 37, 11.5, 37, 15.5)
      ..lineTo(37, 19);
    canvas.drawPath(handle, stroke);
    canvas.restore();

    canvas.restore();
  }

  @override
  bool shouldRepaint(TrashPainter old) =>
      old.t != t || old.color != color || old.fill != fill;
}

/// Bookmark: settles with a damped swing as [t] runs 0→1.
class BookmarkPainter extends CustomPainter {
  final double t;
  final Color color;
  final Color? fill;
  BookmarkPainter({required this.t, required this.color, this.fill});

  @override
  void paint(Canvas canvas, Size size) {
    _fit(canvas, size, const Rect.fromLTWH(16, 14, 32, 36));

    final angle =
        (10 * math.exp(-2.2 * t) * math.sin(t * 2 * math.pi * 1.6)) *
            math.pi /
            180;
    canvas.save();
    canvas.translate(32, 15);
    canvas.rotate(angle);
    canvas.translate(-32, -15);

    final path = Path()
      ..moveTo(22, 15)
      ..lineTo(42, 15)
      ..lineTo(42, 49)
      ..lineTo(32, 42)
      ..lineTo(22, 49)
      ..close();
    if (fill != null) canvas.drawPath(path, Paint()..color = fill!);
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(BookmarkPainter old) =>
      old.t != t || old.color != color || old.fill != fill;
}

/// Printer: a receipt feeds out of the slot and retracts, looping with [t].
class PrinterPainter extends CustomPainter {
  final double t;
  final Color color;
  final Color? paperFill;
  PrinterPainter({required this.t, required this.color, this.paperFill});

  @override
  void paint(Canvas canvas, Size size) {
    _fit(canvas, size, const Rect.fromLTWH(17, 22, 30, 29));

    double ps;
    if (t < 0.12) {
      ps = 0;
    } else if (t < 0.42) {
      ps = (t - 0.12) / 0.30;
    } else if (t < 0.82) {
      ps = 1;
    } else {
      ps = 1 - (t - 0.82) / 0.18;
    }
    ps = ps.clamp(0.0, 1.0);

    final paperC = paperFill ?? color.withOpacity(0.15);

    if (ps > 0.01) {
      canvas.save();
      canvas.translate(32, 37);
      canvas.scale(1, ps);
      canvas.translate(-32, -37);
      final paper = Path()
        ..moveTo(24, 37)
        ..lineTo(40, 37)
        ..lineTo(40, 50)
        ..lineTo(37, 48)
        ..lineTo(34, 50)
        ..lineTo(31, 48)
        ..lineTo(28, 50)
        ..lineTo(24.5, 48)
        ..close();
      canvas.drawPath(paper, Paint()..color = paperC);
      canvas.drawPath(
        paper,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..strokeJoin = StrokeJoin.round,
      );
      final line = Paint()
        ..color = color
        ..strokeWidth = 1.6
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(const Offset(28, 41), const Offset(36, 41), line);
      canvas.drawLine(const Offset(28, 44), const Offset(34, 44), line);
      canvas.restore();
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(
          const Rect.fromLTWH(18, 23, 28, 14), const Radius.circular(3)),
      Paint()..color = color,
    );
    canvas.drawCircle(const Offset(41, 27), 1.6, Paint()..color = Colors.white);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          const Rect.fromLTWH(22, 33, 20, 2.4), const Radius.circular(1.2)),
      Paint()..color = paperC,
    );
  }

  @override
  bool shouldRepaint(PrinterPainter old) =>
      old.t != t || old.color != color || old.paperFill != paperFill;
}
