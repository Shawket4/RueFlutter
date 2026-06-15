import 'package:flutter_test/flutter_test.dart';
import 'package:sufrix_pos/core/services/delivery_realtime_service.dart';

void main() {
  group('SseFrameParser', () {
    test('frames a simple created event on the blank line', () {
      final p = SseFrameParser();
      expect(p.addLine('event: created'), isNull);
      expect(p.addLine('data: {"id":"1"}'), isNull);
      final frame = p.addLine(''); // blank line terminates the event
      expect(frame, isNotNull);
      expect(frame!.event, 'created');
      expect(frame.data, '{"id":"1"}');
    });

    test('ignores `:` comment keep-alives', () {
      final p = SseFrameParser();
      expect(p.addLine(': ping'), isNull);
      expect(p.addLine(''), isNull); // blank with no buffered data → no frame
    });

    test('accumulates multi-line data fields', () {
      final p = SseFrameParser();
      p.addLine('event: updated');
      p.addLine('data: {"a":1,');
      p.addLine('data: "b":2}');
      final frame = p.addLine('');
      expect(frame!.event, 'updated');
      expect(frame.data, '{"a":1,"b":2}');
    });

    test('defaults event type to "message" when absent', () {
      final p = SseFrameParser();
      p.addLine('data: hello');
      expect(p.addLine('')!.event, 'message');
    });

    test('resets between consecutive events', () {
      final p = SseFrameParser();
      p.addLine('event: created');
      p.addLine('data: one');
      final f1 = p.addLine('');
      p.addLine('event: updated');
      p.addLine('data: two');
      final f2 = p.addLine('');
      expect(f1!.event, 'created');
      expect(f1.data, 'one');
      expect(f2!.event, 'updated');
      expect(f2.data, 'two');
    });

    test('strips exactly one leading space after the colon', () {
      final p = SseFrameParser();
      p.addLine('data:  two-spaces'); // one stripped, one kept
      expect(p.addLine('')!.data, ' two-spaces');
    });
  });
}
