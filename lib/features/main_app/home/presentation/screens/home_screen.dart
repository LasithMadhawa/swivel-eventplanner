import '../../../../../core/constants/routes.dart';
import '../blocs/posts/posts_bloc.dart';
import '../widgets/horizontal_image_list.dart';
import '../widgets/image_carousel.dart';
import '../widgets/organizers_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ImageCarousel(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Swivel Talents",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "56 O'Mally Road, ST LEONARDS, 2065, NSW",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Organizers",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const OrganizersList(),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Photos",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Text("All Photos"),
                            SizedBox(width: 8.0),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const HorizontalImageList(),
                  BlocBuilder<PostsBloc, PostsState>(
                    builder: (context, state) {
                      if (state is PostsInitial) {
                        context.read<PostsBloc>().add(FetchPosts());
                      }
                      if (state is PostsLoaded) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 16.0),
                          child: InkWell(
                            onTap: () {
                              GoRouter.of(context).push(AppRoutes.posts);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              decoration: BoxDecoration(
                                border: Border.symmetric(horizontal: BorderSide(color: Theme.of(context).dividerTheme.color ?? Colors.grey))
                              ),
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Text(
                                    state.posts.length.toString(),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  const Text("Posts"),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
