part of 'comments_bloc.dart';

sealed class CommentsState extends Equatable {
  const CommentsState();
  
  @override
  List<Object> get props => [];
}

final class CommentsInitial extends CommentsState {}

final class CommentsLoading extends CommentsState {}

final class CommentsFailure extends CommentsState {
  final String message;

  const CommentsFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class CommentsLoaded extends CommentsState {
  final List<CommentModel> comments;
  const CommentsLoaded(this.comments);

  @override
  List<Object> get props => [comments];
}
