part of 'images_bloc.dart';

sealed class ImagesEvent extends Equatable {
  const ImagesEvent();

  @override
  List<Object> get props => [];
}

class FetchImages extends ImagesEvent {}