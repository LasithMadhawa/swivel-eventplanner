import 'package:equatable/equatable.dart';
import 'package:eventplanner/core/models/user_model.dart';
import 'package:eventplanner/features/user/data/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_user_details_event.dart';
part 'update_user_details_state.dart';

class UpdateUserDetailsBloc extends Bloc<UpdateUserDetailsEvent, UpdateUserDetailsState> {
  final UserRepository userRepository;
  UpdateUserDetailsBloc(this.userRepository) : super(UpdateUserDetailsInitial()) {
    on<UpdateUserDetailsRequested>(_onUpdateUserDetailsRequested);
  }

  _onUpdateUserDetailsRequested(UpdateUserDetailsRequested event, Emitter<UpdateUserDetailsState> emit) async {
    emit(UpdateUserDetailsLoading());
    try {
      await userRepository.saveUser(event.updatedUser);
      emit(UpdateUserDetailsSuccess(event.updatedUser));
    } catch (e) {
      emit(const UpdateUserDetailsFailure(message: 'Profile update failed. Please try again.'));
    }
  }
}
