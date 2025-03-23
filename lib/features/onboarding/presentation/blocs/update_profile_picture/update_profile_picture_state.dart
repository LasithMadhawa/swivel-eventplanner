part of 'update_profile_picture_bloc.dart';

sealed class UpdateProfilePictureState extends Equatable {
  final XFile? image;
  const UpdateProfilePictureState({this.image});
  
  @override
  List<Object?> get props => [image];
}

final class UpdateProfilePictureInitial extends UpdateProfilePictureState {}

final class ProfilePictureUploading extends UpdateProfilePictureState {
  const ProfilePictureUploading({required super.image});
}

final class UpdateProfilePictureFailure extends UpdateProfilePictureState {
  final String message;

  const UpdateProfilePictureFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class ProfilePictureUploaded extends UpdateProfilePictureState {
  final String imageUrl;
  const ProfilePictureUploaded(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}

final class ProfilePictureSelected extends UpdateProfilePictureState {
  const ProfilePictureSelected({required super.image});
}

