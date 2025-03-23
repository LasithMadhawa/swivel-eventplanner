import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class AuthFailure extends Failure {
  const AuthFailure({required String message}) : super(message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({required String message}) : super(message);
}

class UserNotFoundFailure extends Failure {
  const UserNotFoundFailure()
      : super('User not found in database');
}