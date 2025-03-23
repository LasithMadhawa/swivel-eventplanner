part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileUpdateRequested extends ProfileEvent {
  final XFile? image;
  final UserModel? updatedUser;
  const ProfileUpdateRequested({this.image, this.updatedUser});
}

class ResetProfileBloc extends ProfileEvent {}