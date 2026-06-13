import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/widgets/sufrix_logo.dart';

void main() {
  group('Sufrix logo widgets', () {
    // The brand mark is now rendered from the SVG path data via `SufrixSymbol`
    // (flutter_svg), not a CustomPainter — these tests assert the current shape.
    testWidgets('SufrixLogo renders at the requested size with the symbol',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SufrixLogo(size: 100)),
        ),
      );

      expect(find.byType(SufrixLogo), findsOneWidget);
      expect(find.byType(SufrixSymbol), findsOneWidget);

      final size = tester.getSize(find.byType(SufrixLogo));
      expect(size.width, 100);
      expect(size.height, 100);
    });

    testWidgets('SufrixLongLogo renders the symbol and the wordmark',
        (tester) async {
      // The wordmark uses the bundled Cairo font — no runtime font fetch.
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SufrixLongLogo(height: 50)),
        ),
      );

      expect(find.byType(SufrixLongLogo), findsOneWidget);
      expect(find.byType(SufrixSymbol), findsOneWidget);
      expect(find.text('Sufrix'), findsOneWidget);
    });

    testWidgets('SufrixSymbol renders the brand glyph', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SufrixSymbol(
              size: 40,
              crossColor: Colors.white,
              centerColor: Colors.red,
            ),
          ),
        ),
      );

      expect(find.byType(SufrixSymbol), findsOneWidget);
    });
  });
}
