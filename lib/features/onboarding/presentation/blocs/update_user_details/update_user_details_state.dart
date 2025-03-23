part of 'update_user_details_bloc.dart';

sealed class UpdateUserDetailsState extends Equatable {
  const UpdateUserDetailsState();
  
  @override
  List<Object> get props => [];
}

final class UpdateUserDetailsInitial extends UpdateUserDetailsState {}

final class UpdateUserDetailsLoading extends UpdateUserDetailsState {}

final class UpdateUserDetailsFailure extends UpdateUserDetailsState {
  final String message;

  const UpdateUserDetailsFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class UpdateUserDetailsSuccess extends UpdateUserDetailsState {
  final UserModel updatedUser;
  const UpdateUserDetailsSuccess(this.updatedUser);

  @override
  List<Object> get props => [updatedUser];
}
