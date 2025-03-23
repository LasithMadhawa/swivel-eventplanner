import 'package:equatable/equatable.dart';
import '../../../../../../core/models/user_model.dart';
import '../../../../../user/data/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;
  final UserModel user;
  ProfileBloc({required this.userRepository, required this.user}) : super(ProfileInitial(user: user)) {
    on<ProfileUpdateRequested>(_onProfileUpdateRequested);
    on<ResetProfileBloc>(_onResetBloc);
  }

  _onProfileUpdateRequested(ProfileUpdateRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdating(user: state.user));
    try {
      String? imageUrl;
      if (event.image != null) {
        imageUrl = await userRepository.uploadProfileImage(user.uid, event.image!);
      }
      final UserModel updatedUser = event.updatedUser!.copyWith(profilePictureUrl: imageUrl);
      await userRepository.saveUser(updatedUser);
      emit(ProfileUpdateSuccess(user: updatedUser));
    } catch (e) {
      emit(ProfileUpdateFailure(user: user, message: e.toString()));
    }
  }

  _onResetBloc(ResetProfileBloc event, Emitter<ProfileState> emit) {
    emit(ProfileInitial(user: user));
  }
}
