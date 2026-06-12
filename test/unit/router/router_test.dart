import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/l10n/app_localizations.dart';
import 'package:sufrix_pos/core/models/user.dart';
import 'package:sufrix_pos/core/providers/auth_notifier.dart';
import 'package:sufrix_pos/core/router/router.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';

import '../../helpers/model_fixtures.dart';

class FakeAuthNotifier extends AuthNotifier {
  final AuthState injectedState;
  FakeAuthNotifier(this.injectedState);

  @override
  AuthState build() => injectedState;
}

class MockStorageService extends Mock implements StorageService {}

void main() {
  Widget buildApp(ProviderContainer container) {
    return UncontrolledProviderScope(
      container: container,
      child: Consumer(
        builder: (context, ref, child) {
          final router = ref.watch(routerProvider);
          return MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
          );
        },
      ),
    );
  }

  ProviderContainer makeContainer({
    required AuthState auth,
    bool configured = true,
  }) {
    final storage = MockStorageService();
    when(() => storage.isDeviceConfigured).thenReturn(configured);
    when(() => storage.deviceBranchName)
        .thenReturn(configured ? 'Main Branch' : null);
    return ProviderContainer(
      overrides: [
        authProvider.overrideWith(() => FakeAuthNotifier(auth)),
        storageServiceProvider.overrideWithValue(storage),
      ],
    );
  }

  group('Router Redirects', () {
    testWidgets('redirects to /login when unauthenticated', (tester) async {
      final container = makeContainer(
        auth: const AuthState(isLoading: false, user: null),
      );

      await tester.pumpWidget(buildApp(container));
      await tester.pumpAndSettle();

      final router = container.read(routerProvider);
      expect(router.routerDelegate.currentConfiguration.uri.path, '/login');
    });

    testWidgets('redirects to /device-setup when device is not configured',
        (tester) async {
      final container = makeContainer(
        auth: const AuthState(isLoading: false, user: null),
        configured: false,
      );

      await tester.pumpWidget(buildApp(container));
      await tester.pumpAndSettle();

      final router = container.read(routerProvider);
      expect(router.routerDelegate.currentConfiguration.uri.path,
          '/device-setup');
    });

    testWidgets(
        'authed session on an UNCONFIGURED device keeps working (no '
        '/device-setup ⇄ /home redirect loop)', (tester) async {
      final container = makeContainer(
        auth: AuthState(
            isLoading: false,
            user: makeUser(id: 'u1', name: 'User 1', role: UserRole.teller)),
        configured: false,
      );

      await tester.pumpWidget(buildApp(container));
      await tester.pumpAndSettle();

      final router = container.read(routerProvider);
      // From initial /login an authed user lands home and STAYS there.
      expect(router.routerDelegate.currentConfiguration.uri.path, '/home');
    });

    testWidgets('redirects to /home when authenticated and visiting /login', (tester) async {
      final container = makeContainer(
        auth: AuthState(
            isLoading: false,
            user: makeUser(id: 'u1', name: 'User 1', role: UserRole.orgAdmin)),
      );

      await tester.pumpWidget(buildApp(container));
      await tester.pumpAndSettle();

      final router = container.read(routerProvider);
      // Since initialLocation is /login, but user is authenticated, it should redirect to /home
      expect(router.routerDelegate.currentConfiguration.uri.path, '/home');
    });

    testWidgets('does not redirect while loading', (tester) async {
      final container = makeContainer(
        auth: const AuthState(isLoading: true, user: null),
      );

      await tester.pumpWidget(buildApp(container));
      await tester.pumpAndSettle();

      final router = container.read(routerProvider);
      // Since it's loading, it doesn't redirect from the matched location (which is initialLocation '/login')
      expect(router.routerDelegate.currentConfiguration.uri.path, '/login');
    });
  });
}
