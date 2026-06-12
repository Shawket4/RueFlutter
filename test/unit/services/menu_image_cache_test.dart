import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/services/menu_image_cache.dart';

class MockMenuImageCacheManager extends Mock implements MenuImageCacheManager {}
class MockFileInfo extends Mock implements FileInfo {}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('MenuImageCache', () {
    late MockMenuImageCacheManager mockManager;
    late MenuImageCache cache;

    setUp(() {
      mockManager = MockMenuImageCacheManager();
      cache = MenuImageCache(mockManager);
    });

    test('warmUp downloads all urls', () async {
      when(() => mockManager.getSingleFile(any())).thenAnswer((_) async => MockFileInfo().file);

      await cache.warmUp(['url1', 'url2']);

      verify(() => mockManager.getSingleFile('url1')).called(1);
      verify(() => mockManager.getSingleFile('url2')).called(1);
    });

    test('warmUp swallows errors', () async {
      when(() => mockManager.getSingleFile('url1')).thenThrow(Exception('Failed'));
      when(() => mockManager.getSingleFile('url2')).thenAnswer((_) async => MockFileInfo().file);

      await cache.warmUp(['url1', 'url2']);

      verify(() => mockManager.getSingleFile('url1')).called(1);
      verify(() => mockManager.getSingleFile('url2')).called(1);
    });

    test('invalidate empties cache', () async {
      when(() => mockManager.emptyCache()).thenAnswer((_) async {});

      await cache.invalidate();

      verify(() => mockManager.emptyCache()).called(1);
    });

    test('evict removes specific file', () async {
      when(() => mockManager.removeFile('url1')).thenAnswer((_) async {});

      await cache.evict('url1');

      verify(() => mockManager.removeFile('url1')).called(1);
    });
  });

  group('MenuImage Widget', () {
    testWidgets('renders placeholder when loading', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MenuImage(
              url: 'http://example.com/image.png',
              width: 100,
              height: 100,
              placeholder: Text('Loading...'),
            ),
          ),
        ),
      );

      // The CachedNetworkImageProvider usually causes the placeholder to show first
      // Since it's a test environment without real network, it might stay loading or error
      // Expecting a placeholder first is typical.
      expect(find.text('Loading...'), findsOneWidget);
    });
  });
}
