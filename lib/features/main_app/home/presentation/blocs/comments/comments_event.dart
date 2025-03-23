part of 'comments_bloc.dart';

sealed class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => [];
}

class FetchComments extends CommentsEvent {
  final int postId;
  const FetchComments({required this.postId});
}