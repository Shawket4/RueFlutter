import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/db/outbox_dao.dart';
import 'package:sufrix_pos/core/l10n/app_localizations.dart';
import 'package:sufrix_pos/core/models/user.dart';
import 'package:sufrix_pos/core/repositories/auth_repository.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';
import 'package:sufrix_pos/features/auth/login_screen.dart';

import '../../../helpers/model_fixtures.dart';

class MockAuthRepository extends Mock implements AuthRepository {}
class MockStorageService extends Mock implements StorageService {}
class MockOutboxDao extends Mock implements OutboxDao {}

void main() {
  late MockAuthRepository mockRepo;
  late MockStorageService mockStorage;
  late MockOutboxDao mockOutbox;

  setUp(() {
    mockRepo = MockAuthRepository();
    mockStorage = MockStorageService();
    mockOutbox = MockOutboxDao();

    when(() => mockStorage.loadUser()).thenReturn(null);
    when(() => mockStorage.token).thenReturn(null);
    when(() => mockRepo.restoreSession()).thenAnswer((_) async => null);
    when(() => mockOutbox.dueForSync(any(), userId: any(named: 'userId')))
        .thenAnswer((_) async => <OutboxEntry>[]);
  });

  Widget buildSubject() {
    return ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockRepo),
        storageServiceProvider.overrideWithValue(mockStorage),
        outboxDaoProvider.overrideWithValue(mockOutbox),
      ],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: LoginScreen(),
      ),
    );
  }

  testWidgets('renders login screen correctly', (tester) async {
    await tester.pumpWidget(buildSubject());

    expect(find.text('Welcome'), findsWidgets);
    expect(find.text('Sign in to start your shift and manage orders.'), findsWidgets);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('shows error when name is empty and pin is entered', (tester) async {
    await tester.pumpWidget(buildSubject());

    // Enter pin without name
    for (int i = 0; i < 6; i++) {
      await tester.tap(find.text('1'));
      await tester.pump(const Duration(milliseconds: 50));
    }

    expect(find.text('Please enter your name'), findsOneWidget);
  });

  testWidgets('calls login when name and pin are entered', (tester) async {
    when(() => mockRepo.login(name: 'Teller', pin: '111111')).thenAnswer(
        (_) async => (token: 'token', user: makeUser(id: '1', orgId: 'org1', branchId: 'b1', name: 'Teller', role: UserRole.teller)));
    when(() => mockStorage.saveToken(any())).thenAnswer((_) async {});
    when(() => mockStorage.saveUser(any())).thenAnswer((_) async {});

    await tester.pumpWidget(buildSubject());

    // Enter name
    await tester.enterText(find.byType(TextField), 'Teller');
    await tester.pump();

    // Enter pin
    for (int i = 0; i < 6; i++) {
      await tester.tap(find.text('1'));
      await tester.pump(const Duration(milliseconds: 50));
    }

    verify(() => mockRepo.login(name: 'Teller', pin: '111111')).called(1);
  });
}
