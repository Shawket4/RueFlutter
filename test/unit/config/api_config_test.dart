import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/config/api_config.dart';

void main() {
  group('api_config', () {
    test('kApiBaseUrl is correct', () {
      expect(kApiBaseUrl, 'https://sufrix.duckdns.org/api');
    });
  });
}
