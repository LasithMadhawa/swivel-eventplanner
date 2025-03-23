part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();
  
  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}

final class PostsLoading extends PostsState {}

final class PostsFailure extends PostsState {
  final String message;

  const PostsFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class PostsLoaded extends PostsState {
  final List<PostModel> posts;
  const PostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}
