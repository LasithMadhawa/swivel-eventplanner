import 'package:bloc_test/bloc_test.dart';
import 'package:eventplanner/core/models/user_model.dart';
import 'package:eventplanner/features/auth/data/repositories/auth_repository.dart';
import 'package:eventplanner/features/user/data/repositories/user_repository.dart';
import 'package:eventplanner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}
class MockUserRepository extends Mock implements UserRepository {}
class MockUser extends Mock implements User {}

void main() {
  late AuthBloc authBloc;
  late MockAuthRepository mockAuthRepository;
  late MockUserRepository mockUserRepository;
  late MockUser mockFirebaseUser;
  
  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockUserRepository = MockUserRepository();
    mockFirebaseUser = MockUser();
    authBloc = AuthBloc(authRepository: mockAuthRepository, userRepository: mockUserRepository);
  });

  setUpAll(() {
    registerFallbackValue(const UserModel(uid: '123', email: 'test@example.com'));
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    final testUser = const UserModel(uid: '123', email: 'test@example.com');
    
    test('initial state is AuthInitial', () {
      expect(authBloc.state, AuthInitial());
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Authenticated] when AuthCheckRequested succeeds',
      build: () {
        when(() => mockAuthRepository.currentUser).thenAnswer((_) async => mockFirebaseUser);
        when(() => mockFirebaseUser.uid).thenReturn('123');
        when(() => mockFirebaseUser.email).thenReturn('test@example.com');
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthCheckRequested()),
      expect: () => [AuthLoading(), Authenticated(user: testUser)],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Authenticated] when SignUpRequested succeeds',
      build: () {
        when(() => mockAuthRepository.signUpWithEmailAndPassword(email: any(named: 'email'), password: any(named: 'password')))
            .thenAnswer((_) async => mockFirebaseUser);
        when(() => mockUserRepository.saveUser(any())).thenAnswer((_) async {});
        when(() => mockFirebaseUser.uid).thenReturn('123');
        when(() => mockFirebaseUser.email).thenReturn('test@example.com');
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignUpRequested(email: 'test@example.com', password: 'password')),
      expect: () => [AuthLoading(), Authenticated(user: testUser)],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, Unauthenticated] when SignOutRequested is successful',
      build: () {
        when(() => mockAuthRepository.signOut()).thenAnswer((_) async {});
        return authBloc;
      },
      act: (bloc) => bloc.add(SignOutRequested()),
      expect: () => [AuthLoading(), Unauthenticated()],
    );
  });
}
