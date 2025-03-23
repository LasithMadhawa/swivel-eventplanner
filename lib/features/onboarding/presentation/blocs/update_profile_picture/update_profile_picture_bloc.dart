import 'package:equatable/equatable.dart';
import 'package:eventplanner/core/models/user_model.dart';
import 'package:eventplanner/features/user/data/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'update_profile_picture_event.dart';
part 'update_profile_picture_state.dart';

class UpdateProfilePictureBloc extends Bloc<UpdateProfilePictureEvent, UpdateProfilePictureState> {
  final UserRepository userRepository;
  UpdateProfilePictureBloc(this.userRepository) : super(UpdateProfilePictureInitial()) {
    on<SelectImage>(_onSelectImage);
    on<UploadImage>(_onUploadImage);
  }

  _onSelectImage(SelectImage event, Emitter<UpdateProfilePictureState> emit) {
    emit(ProfilePictureSelected(image: event.image));
  }

  _onUploadImage(UploadImage event, Emitter<UpdateProfilePictureState> emit) async {
    emit(ProfilePictureUploading(image:event.image));
    try {
      final imageUrl = await userRepository.uploadProfileImage(
              event.user.uid,
              event.image,
            );
      final updatedUser = event.user.copyWith(
          profilePictureUrl: imageUrl,
        );
      await userRepository.saveUser(updatedUser);
      emit(ProfilePictureUploaded(imageUrl));
    } catch (e) {
      emit(UpdateProfilePictureFailure(message: e.toString()));
    }
    
  }
}
