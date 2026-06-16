import 'package:test/test.dart';
import 'package:sufrix_api/sufrix_api.dart';

// tests for StatusInput
void main() {
  final StatusInput? instance = /* StatusInput(...) */ null;
  // TODO add properties to the entity

  group(StatusInput, () {
    // Target line step: \"confirmed\" | \"preparing\" | \"ready\" | \"out_for_delivery\". The teller may jump to ANY of these from any non-terminal state (forward or back); the landed step is stamped and all other step stamps are cleared, and at most one customer WhatsApp fires (the last newly-crossed step that has one).
    // String status
    test('to test the property `status`', () async {
      // TODO
    });

  });
}
