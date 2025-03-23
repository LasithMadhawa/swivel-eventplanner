part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  final UserModel user;
  const ProfileState({required this.user});

  @override
  List<Object> get props => [user];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial({required super.user});
}

final class ProfileUpdating extends ProfileState {
  const ProfileUpdating({required super.user});
}

final class ProfileUpdateSuccess extends ProfileState {
  const ProfileUpdateSuccess({required super.user});
}

final class ProfileUpdateFailure extends ProfileState {
  final String message;
  const ProfileUpdateFailure({required super.user, required this.message});

  @override
  List<Object> get props => [message];
}