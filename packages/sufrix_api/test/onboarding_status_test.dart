import 'package:test/test.dart';
import 'package:sufrix_api/sufrix_api.dart';

// tests for OnboardingStatus
void main() {
  final OnboardingStatus? instance = /* OnboardingStatus(...) */ null;
  // TODO add properties to the entity

  group(OnboardingStatus, () {
    // True when every `required` step is done (the Finish button enabler).
    // bool canComplete
    test('to test the property `canComplete`', () async {
      // TODO
    });

    // Persisted terminal flag — the dashboard routes into the wizard when this is false.
    // bool completed
    test('to test the property `completed`', () async {
      // TODO
    });

    // DateTime completedAt
    test('to test the property `completedAt`', () async {
      // TODO
    });

    // String orgId
    test('to test the property `orgId`', () async {
      // TODO
    });

    // Recipe coverage across active menu items (0..1) — drives the cost engine; surfaced separately because it's a percentage, not a bool.
    // double recipeCoverage
    test('to test the property `recipeCoverage`', () async {
      // TODO
    });

    // List<OnboardingStep> steps
    test('to test the property `steps`', () async {
      // TODO
    });

  });
}
