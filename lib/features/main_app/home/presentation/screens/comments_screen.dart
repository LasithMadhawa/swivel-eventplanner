import '../widgets/comment_widget.dart';

import '../../../../../core/models/post_model.dart';
import '../../data/repositories/posts_repository.dart';
import '../blocs/comments/comments_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsScreen extends StatelessWidget {
  final PostModel post;
  const CommentsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comments")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title ?? "",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0,),
                Text(post.body ?? ""),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: BlocProvider(
              create:
                  (context) =>
                      CommentsBloc(context.read<PostsRepository>())
                        ..add(FetchComments(postId: post.id!)),
              child: BlocBuilder<CommentsBloc, CommentsState>(
                builder: (context, state) {
                  if (state is CommentsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CommentsLoaded) {
                    return ListView.builder(
                      itemCount: state.comments.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      itemBuilder: (context, index) {
                        return CommentWidget(comment: state.comments[index],);
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
