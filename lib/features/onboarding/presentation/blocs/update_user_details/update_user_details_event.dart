part of 'update_user_details_bloc.dart';

sealed class UpdateUserDetailsEvent extends Equatable {
  const UpdateUserDetailsEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserDetailsRequested extends UpdateUserDetailsEvent {
  final UserModel updatedUser;

  const UpdateUserDetailsRequested({
    required this.updatedUser
  });
}