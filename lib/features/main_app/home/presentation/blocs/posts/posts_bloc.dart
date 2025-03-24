import 'package:equatable/equatable.dart';
import '../../../../../../core/models/post_model.dart';
import '../../../data/repositories/posts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository postsRepository;
  PostsBloc(this.postsRepository) : super(PostsInitial()) {
    on<FetchPosts>(_onFetchPosts);
  }

  _onFetchPosts(FetchPosts event, Emitter<PostsState> emit) async {
    emit(PostsLoading());
      try {
        final posts = await postsRepository.getPosts();
        emit(PostsLoaded(posts));
      } catch (e) {
        emit(PostsFailure(message: e.toString()));
      }
  }
}
