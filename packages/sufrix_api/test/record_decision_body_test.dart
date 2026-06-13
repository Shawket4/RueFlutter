import 'package:test/test.dart';
import 'package:sufrix_api/sufrix_api.dart';

// tests for RecordDecisionBody
void main() {
  final RecordDecisionBody? instance = /* RecordDecisionBody(...) */ null;
  // TODO add properties to the entity

  group(RecordDecisionBody, () {
    // String branchId
    test('to test the property `branchId`', () async {
      // TODO
    });

    // accepted | rejected | ignored — kept as a string so invalid values yield a 400 instead of a deserialization error.
    // String decision
    test('to test the property `decision`', () async {
      // TODO
    });

    // String notes
    test('to test the property `notes`', () async {
      // TODO
    });

    // String suggestionId
    test('to test the property `suggestionId`', () async {
      // TODO
    });

    // SuggestionKind suggestionKind
    test('to test the property `suggestionKind`', () async {
      // TODO
    });

  });
}
