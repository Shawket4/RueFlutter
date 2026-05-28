import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sufrix_pos/core/models/user.dart';
import 'package:sufrix_pos/core/providers/auth_notifier.dart';
import 'package:sufrix_pos/core/router/router.dart';

class FakeAuthNotifier extends AuthNotifier {
  final AuthState injectedState;
  FakeAuthNotifier(this.injectedState);

  @override
  AuthState build() => injectedState;
}

void main() {
  Widget buildApp(ProviderContainer container) {
    return UncontrolledProviderScope(
      container: container,
      child: Consumer(
        builder: (context, ref, child) {
          final router = ref.watch(routerProvider);
          return MaterialApp.router(
            routerConfig: router,
          );
        },
      ),
    );
  }

  group('Router Redirects', () {
    testWidgets('redirects to /login when unauthenticated', (tester) async {
      final container = ProviderContainer(
        overrides: [
          authProvider.overrideWith(() => FakeAuthNotifier(
            const AuthState(isLoading: false, user: null),
          )),
        ],
      );

      await tester.pumpWidget(buildApp(container));
      await tester.pumpAndSettle();

      final router = container.read(routerProvider);
      expect(router.routerDelegate.currentConfiguration.uri.path, '/login');
    });

    testWidgets('redirects to /home when authenticated and visiting /login', (tester) async {
      final container = ProviderContainer(
        overrides: [
          authProvider.overrideWith(() => FakeAuthNotifier(
            AuthState(isLoading: false, user: User(id: 'u1', name: 'User 1', role: 'admin', isActive: true)),
          )),
        ],
      );

      await tester.pumpWidget(buildApp(container));
      await tester.pumpAndSettle();

      final router = container.read(routerProvider);
      // Since initialLocation is /login, but user is authenticated, it should redirect to /home
      expect(router.routerDelegate.currentConfiguration.uri.path, '/home');
    });

    testWidgets('does not redirect while loading', (tester) async {
      final container = ProviderContainer(
        overrides: [
          authProvider.overrideWith(() => FakeAuthNotifier(
            const AuthState(isLoading: true, user: null),
          )),
        ],
      );

      await tester.pumpWidget(buildApp(container));
      await tester.pumpAndSettle();

      final router = container.read(routerProvider);
      // Since it's loading, it doesn't redirect from the matched location (which is initialLocation '/login')
      expect(router.routerDelegate.currentConfiguration.uri.path, '/login');
    });
  });
}
