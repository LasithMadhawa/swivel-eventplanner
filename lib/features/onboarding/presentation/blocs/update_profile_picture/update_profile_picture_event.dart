part of 'update_profile_picture_bloc.dart';

sealed class UpdateProfilePictureEvent extends Equatable {
  const UpdateProfilePictureEvent();

  @override
  List<Object> get props => [];
}

class SelectImage extends UpdateProfilePictureEvent {
  final XFile image;
  const SelectImage(this.image);
}

class UploadImage extends UpdateProfilePictureEvent {
  final XFile image;
  final UserModel user;
  const UploadImage({required this.user, required this.image});
}
