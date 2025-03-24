import 'package:equatable/equatable.dart';
import '../../../../../../core/models/organizer_model.dart';
import '../../../data/repositories/organizers_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'organizers_event.dart';
part 'organizers_state.dart';

class OrganizersBloc extends Bloc<OrganizersEvent, OrganizersState> {
  final OrganizersRepository organizersRepository;
  OrganizersBloc(this.organizersRepository) : super(OrganizersInitial()) {
    on<FetchOrganizers>(_onFetchOrganizers);
  }

  _onFetchOrganizers(FetchOrganizers event, Emitter<OrganizersState> emit) async {
    emit(OrganizersLoading());
      try {
        final organizers = await organizersRepository.getOrganizers();
        emit(OrganizersLoaded(organizers));
      } catch (e) {
        emit(OrganizersFailure(message: e.toString()));
      }
  }
}
