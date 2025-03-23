part of 'images_bloc.dart';

sealed class ImagesState extends Equatable {
  const ImagesState();
  
  @override
  List<Object> get props => [];
}

final class ImagesInitial extends ImagesState {}

final class ImagesLoading extends ImagesState {}

final class ImagesFailure extends ImagesState {
  final String message;

  const ImagesFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class ImagesLoaded extends ImagesState {
  final List<ImageModel> images;
  const ImagesLoaded(this.images);

  @override
  List<Object> get props => [images];
}

