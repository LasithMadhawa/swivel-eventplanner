import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../../user/data/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  AuthBloc({required this.authRepository, required this.userRepository}) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequest);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInRequested>(_onSignInRequested);
    on<ProfileUpdated>(_onProfileUpdated);
    on<SignOutRequested>(_onSignOutRequested);
  }

  _onAuthCheckRequest(AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.currentUser;
      if (user != null) {
        emit(
          Authenticated(
            user: UserModel(uid: user.uid, email: user.email ?? ""),
          ),
        );
      }
    } catch (e) {
      emit(const AuthFailure(message: "Authentication Check Failed"));
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signUpWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      await userRepository.saveUser(UserModel(
        uid: user.uid,
        email: user.email ?? '',
      ));
      emit(
        Authenticated(
          user: UserModel(uid: user.uid, email: user.email ?? ''),
        ),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      emit(AuthFailure(message: e.code));
    } on Failure catch (e) {
      debugPrint(e.toString());
      emit(AuthFailure(message: e.message));
    }
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      final userData = await userRepository.getUser(user.uid);
      emit(Authenticated(
        user: userData,
      ));
    } on Failure catch (e) {
      emit(AuthFailure(message: e.message));
    }
  }

  Future<void> _onProfileUpdated(
    ProfileUpdated event,
    Emitter<AuthState> emit,
  ) async {
    try {
      if (state is Authenticated) {
        emit(Authenticated(
          user: event.updatedUser,
        ));
      }
    } catch (e) {
      emit(const AuthFailure(message: 'Profile update failed. Please try again.'));
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.signOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(const AuthFailure(message: 'Sign out failed. Please try again.'));
    }
  }
}
