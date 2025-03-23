import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eventplanner/core/models/image_model.dart';
import 'package:eventplanner/features/main_app/home/data/repositories/images_repository.dart';

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final ImagesRepository imagesRepository;
  ImagesBloc(this.imagesRepository) : super(ImagesInitial()) {
    on<FetchImages>(_onFetchImages);
  }

  _onFetchImages(FetchImages event, Emitter<ImagesState> emit) async {
    emit(ImagesLoading());
      try {
        final images = await imagesRepository.getImages();
        emit(ImagesLoaded(images));
      } catch (e) {
        emit(ImagesFailure(message: e.toString()));
      }
  }
}
