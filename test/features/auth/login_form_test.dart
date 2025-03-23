import 'package:eventplanner/core/constants/strings.dart';
import 'package:eventplanner/features/auth/data/repositories/auth_repository.dart';
import 'package:eventplanner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eventplanner/features/auth/presentation/screens/login_screen.dart';
import 'package:eventplanner/features/user/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Add mock dependencies
class MockAuthRepository extends Mock implements AuthRepository {}
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  testWidgets('Login form validation', (WidgetTester tester) async {
    // Create test app with necessary providers
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(
                authRepository: MockAuthRepository(),
                userRepository: MockUserRepository(),
              ),
            ),
          ],
          child: LoginScreen(),
        ),
      ),
    );
    
    final submitButton = find.byKey(const ValueKey('loginButton'));

    // Verify initial widget presence
    expect(find.byKey(const Key('emailField')), findsOneWidget);
    expect(find.byKey(const Key('passwordField')), findsOneWidget);
    expect(find.byKey(const Key('loginButton')), findsOneWidget);

    // Test empty validation
    await tester.tap(submitButton);
    await tester.pump();

    expect(find.text(AppStrings.requiredField), findsNWidgets(2));
  });
}