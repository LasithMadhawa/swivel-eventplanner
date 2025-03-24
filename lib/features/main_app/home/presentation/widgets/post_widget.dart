import '../../../../../core/constants/routes.dart';
import '../../../../../core/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;
  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(color: Theme.of(context).canvasColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title ?? "",
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(post.body ?? ""),
          const SizedBox(height: 8.0),
          const Divider(),
          TextButton(
            onPressed: () {
              GoRouter.of(context).push(AppRoutes.comments, extra: post);
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.comment_outlined),
                SizedBox(width: 8.0),
                Text("Comments"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
