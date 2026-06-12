import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/config/api_config.dart';

void main() {
  group('api_config', () {
    // The host is environment-dependent (localhost during dev, the prod
    // domain in releases) — assert the shape, not a specific environment.
    test('kApiBaseUrl is a usable http(s) base URL', () {
      final uri = Uri.parse(kApiBaseUrl);
      expect(uri.scheme, anyOf('http', 'https'));
      expect(uri.host, isNotEmpty);
      expect(kApiBaseUrl.endsWith('/'), isFalse,
          reason: 'paths are joined with a leading slash');
    });
  });
}
