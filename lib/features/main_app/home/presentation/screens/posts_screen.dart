import '../widgets/post_widget.dart';

import '../blocs/posts/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      backgroundColor: Colors.grey.shade300,
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsInitial) {
            context.read<PostsBloc>().add(FetchPosts());
          }
          if (state is PostsLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemBuilder: (context, index) {
                return PostWidget(post: state.posts[index]);
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
