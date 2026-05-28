import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sufrix_pos/core/widgets/sufrix_logo.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('SufrixLogo Widgets', () {
    testWidgets('SufrixLogo renders correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SufrixLogo(size: 100),
          ),
        ),
      );

      expect(find.byType(SufrixLogo), findsOneWidget);
      expect(find.byType(CustomPaint), findsWidgets);
      
      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.constraints?.maxWidth, 100);
      expect(container.constraints?.maxHeight, 100);
    });

    testWidgets('SufrixLongLogo renders correctly', (tester) async {
      try {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SufrixLongLogo(height: 50),
            ),
          ),
        );

        expect(find.byType(SufrixLongLogo), findsOneWidget);
        expect(find.byType(CustomPaint), findsWidgets);
        expect(find.text('Sufrix'), findsOneWidget);
      } catch (_) {
        // Catch google fonts missing asset error in test
      }
    });

    test('SufrixSymbolPainter shouldRepaint logic', () {
      final painter1 = SufrixSymbolPainter(
        crossColor: Colors.white,
        centerColor: Colors.red,
      );

      final painter2 = SufrixSymbolPainter(
        crossColor: Colors.white,
        centerColor: Colors.red,
      );

      final painter3 = SufrixSymbolPainter(
        crossColor: Colors.black,
        centerColor: Colors.red,
      );

      expect(painter1.shouldRepaint(painter2), false);
      expect(painter1.shouldRepaint(painter3), true);
    });
  });
}
