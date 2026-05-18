import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SufrixSymbolPainter extends CustomPainter {
  final Color crossColor;
  final Color centerColor;

  SufrixSymbolPainter({
    required this.crossColor,
    required this.centerColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double minDim = math.min(w, h);

    final paintCross = Paint()..color = crossColor;
    final paintCenter = Paint()..color = centerColor;

    canvas.save();
    canvas.translate(w / 2, h / 2);
    canvas.rotate(-math.pi / 4); // -45 degrees

    // X-mark cross arms fill the canvas perfectly!
    // Calculated directly from original Logo.svg geometry ratios:
    // Arms: 31.51 x 5.25 (exactly 6:1 aspect ratio)
    // Corner Radius: 0.66
    // Center Circle Radius: 2.63
    final double rectH = minDim;
    final double rectW = minDim * (5.25 / 31.51); // 1/6 of height
    final double rectR = minDim * (0.66 / 31.51);

    final RRect rrect1 = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: rectW, height: rectH),
      Radius.circular(rectR),
    );
    canvas.drawRRect(rrect1, paintCross);

    final RRect rrect2 = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: rectH, height: rectW),
      Radius.circular(rectR),
    );
    canvas.drawRRect(rrect2, paintCross);

    // Draw center circle (exactly proportional to original Logo.svg)
    final double circleR = minDim * (2.63 / 31.51);
    canvas.drawCircle(Offset.zero, circleR, paintCenter);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant SufrixSymbolPainter oldDelegate) {
    return oldDelegate.crossColor != crossColor || oldDelegate.centerColor != centerColor;
  }
}

class SufrixLogo extends StatelessWidget {
  final double size;
  final bool isRounded;
  final Color? backgroundColor;
  final Color? crossColor;
  final Color? centerColor;

  const SufrixLogo({
    super.key,
    this.size = 80,
    this.isRounded = true,
    this.backgroundColor,
    this.crossColor,
    this.centerColor,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? const Color(0xFF0A2540);
    final cross = crossColor ?? const Color(0xFFFAF7F2);
    final center = centerColor ?? const Color(0xFFC25B3F);

    // X-mark occupies 52% of the icon container size (golden ratio, bold and recognizable)
    final double symbolSize = size * 0.52;

    Widget logo = Container(
      width: size,
      height: size,
      color: bg,
      child: Center(
        child: CustomPaint(
          size: Size(symbolSize, symbolSize),
          painter: SufrixSymbolPainter(
            crossColor: cross,
            centerColor: center,
          ),
        ),
      ),
    );

    if (isRounded) {
      logo = ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.22),
        child: logo,
      );
    }

    return logo;
  }
}

class SufrixLongLogo extends StatelessWidget {
  final double height;
  final Color? textColor;
  final Color? crossColor;
  final Color? centerColor;

  const SufrixLongLogo({
    super.key,
    this.height = 44,
    this.textColor,
    this.crossColor,
    this.centerColor,
  });

  @override
  Widget build(BuildContext context) {
    final tc = textColor ?? const Color(0xFF0A2540);
    final cc = crossColor ?? const Color(0xFF0A2540);
    final cnc = centerColor ?? const Color(0xFFC25B3F);

    // The symbol height is exactly 75% of the row height to match the Logo.svg balance perfectly
    final double symbolSize = height * 0.75;

    return SizedBox(
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomPaint(
            size: Size(symbolSize, symbolSize),
            painter: SufrixSymbolPainter(
              crossColor: cc,
              centerColor: cnc,
            ),
          ),
          SizedBox(width: height * 0.22),
          // Native premium text rendering using Google Fonts Cairo to avoid SVG text-rendering fallback issues
          Text(
            'Sufrix',
            style: GoogleFonts.cairo(
              fontSize: height * 0.68,
              fontWeight: FontWeight.w700,
              color: tc,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
