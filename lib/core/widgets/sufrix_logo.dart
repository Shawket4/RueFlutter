import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';

// Glyph geometry copied verbatim from assets/Icon.svg (source viewBox 0 0 126 126).
// The four blades curve around a central gap that holds the separate center dot,
// so the cross and the dot must be rendered as two independently-coloured paths.
const String _crossPathData =
    'M62.06,70.38l-11.29,11.3c-.83.82-1.96,1.33-3.22,1.33-2.51,0-4.55-2.04-4.55-4.56,0-1.25.51-2.39,1.33-3.21l11.3-11.3c.42,3.36,3.08,6.02,6.43,6.44ZM50.76,44.32l11.29,11.3c-3.35.43-6.01,3.08-6.43,6.44l-11.3-11.3c-.82-.82-1.33-1.96-1.33-3.21,0-2.52,2.04-4.56,4.55-4.56,1.26,0,2.39.51,3.22,1.33ZM70.38,63.94l11.29,11.3c.82.82,1.34,1.96,1.34,3.21,0,2.52-2.04,4.56-4.55,4.56-1.26,0-2.4-.51-3.22-1.33l-11.29-11.3c3.36-.43,6.02-3.08,6.44-6.44ZM63.94,55.62l11.29-11.3c.82-.82,1.97-1.33,3.22-1.33,2.52,0,4.55,2.04,4.55,4.56,0,1.25-.51,2.39-1.34,3.21l-11.29,11.3c-.42-3.36-3.08-6.02-6.44-6.44Z';
const String _centerPathData = 'M67.4,63c0,5.87-8.8,5.87-8.8,0s8.8-5.87,8.8,0Z';

String _hex(Color c) {
  String channel(double v) =>
      ((v * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0');
  return '#${channel(c.r)}${channel(c.g)}${channel(c.b)}';
}

/// The bare Sufrix "X" symbol (cross + centre dot) rendered straight from the
/// brand SVG path data, so it always matches the app icon exactly.
class SufrixSymbol extends StatelessWidget {
  final double size;
  final Color crossColor;
  final Color centerColor;

  const SufrixSymbol({
    super.key,
    required this.size,
    required this.crossColor,
    required this.centerColor,
  });

  @override
  Widget build(BuildContext context) {
    // The glyph is centred on (63,63) in the source artwork; this viewBox frames
    // it tightly (with a hair of margin for the rounded blade caps).
    final svg =
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="42 42 42 42">'
        '<path fill="${_hex(crossColor)}" d="$_crossPathData"/>'
        '<path fill="${_hex(centerColor)}" d="$_centerPathData"/>'
        '</svg>';
    return SvgPicture.string(svg, width: size, height: size);
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
    final bg = backgroundColor ?? AppBrand.navy;
    final cross = crossColor ?? AppBrand.cream;
    final center = centerColor ?? AppBrand.terracotta;

    // X-mark occupies ~52% of the badge for a bold, recognizable mark.
    final double symbolSize = size * 0.52;

    Widget logo = Container(
      width: size,
      height: size,
      color: bg,
      child: Center(
        child: SufrixSymbol(
          size: symbolSize,
          crossColor: cross,
          centerColor: center,
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
    final tc = textColor ?? AppBrand.navy;
    final cc = crossColor ?? AppBrand.navy;
    final cnc = centerColor ?? AppBrand.terracotta;

    // The symbol height is 75% of the row height to match the Logo.svg balance.
    final double symbolSize = height * 0.75;

    return SizedBox(
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SufrixSymbol(
            size: symbolSize,
            crossColor: cc,
            centerColor: cnc,
          ),
          SizedBox(width: height * 0.22),
          // Native Cairo text rendering avoids SVG text-fallback issues.
          Text(
            'Sufrix',
            style: ui(
              size: height * 0.68,
              weight: FontWeight.w700,
              color: tc,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
