import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sufrix_pos/core/models/user.dart';
import 'package:sufrix_pos/core/providers/auth_notifier.dart';
import 'package:sufrix_pos/core/repositories/auth_repository.dart';
import 'package:sufrix_pos/core/storage/storage_service.dart';
import 'package:sufrix_pos/features/auth/login_screen.dart';

class MockAuthRepository extends Mock implements AuthRepository {}
class MockStorageService extends Mock implements StorageService {}

void main() {
  late MockAuthRepository mockRepo;
  late MockStorageService mockStorage;

  setUp(() {
    mockRepo = MockAuthRepository();
    mockStorage = MockStorageService();
    
    when(() => mockStorage.loadUser()).thenReturn(null);
    when(() => mockStorage.token).thenReturn(null);
    when(() => mockRepo.restoreSession()).thenAnswer((_) async => null);
  });

  Widget buildSubject() {
    return ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockRepo),
        storageServiceProvider.overrideWithValue(mockStorage),
      ],
      child: const MaterialApp(
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
        (_) async => (token: 'token', user: const User(id: '1', orgId: 'org1', branchId: 'b1', name: 'Teller', role: 'teller', isActive: true)));
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
