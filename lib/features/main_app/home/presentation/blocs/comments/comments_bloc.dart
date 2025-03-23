import 'package:equatable/equatable.dart';
import 'package:eventplanner/core/models/comment_model.dart';
import 'package:eventplanner/features/main_app/home/data/repositories/posts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final PostsRepository postsRepository;
  CommentsBloc(this.postsRepository) : super(CommentsInitial()) {
    on<FetchComments>(_onFetchComments);
  }

  _onFetchComments(FetchComments event, Emitter<CommentsState> emit) async {
    emit(CommentsLoading());
      try {
        final comments = await postsRepository.getComments(event.postId);
        emit(CommentsLoaded(comments));
      } catch (e) {
        emit(CommentsFailure(message: e.toString()));
      }
  }
}
