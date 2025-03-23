import 'package:equatable/equatable.dart';
import '../../../../../../core/models/image_model.dart';
import '../../../data/repositories/images_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
