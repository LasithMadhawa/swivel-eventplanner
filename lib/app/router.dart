import 'package:eventplanner/core/constants/routes.dart';
import 'package:eventplanner/core/models/post_model.dart';
import 'package:eventplanner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eventplanner/features/auth/presentation/screens/login_screen.dart';
import 'package:eventplanner/features/auth/presentation/screens/signup_screen.dart';
import 'package:eventplanner/features/main_app/home/presentation/screens/comments_screen.dart';
import 'package:eventplanner/features/main_app/home/presentation/screens/home_screen.dart';
import 'package:eventplanner/features/main_app/home/presentation/screens/posts_screen.dart';
import 'package:eventplanner/features/main_app/presentation/screens/main_app_screen.dart';
import 'package:eventplanner/features/main_app/profile/presentation/screens/profile_screen.dart';
import 'package:eventplanner/features/onboarding/presentation/screens/profile_picture_screen.dart';
import 'package:eventplanner/features/onboarding/presentation/screens/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final GoRouter config = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.profilePicture,
        pageBuilder:
            (context, state) =>
                SlideTransitionPage(child: const ProfilePictureScreen()),
      ),
      GoRoute(
        path: AppRoutes.userDetails,
        pageBuilder:
            (context, state) => SlideTransitionPage(child: UserDetailsScreen()),
      ),
      ShellRoute(
        builder: (context, state, child) => MainAppScreen(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.profile,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.posts,
        builder: (context, state) => const PostsScreen(),
      ),
      GoRoute(
        path: AppRoutes.comments,
        builder: (context, state) {
          final post = state.extra as PostModel;
          return CommentsScreen(post: post);
        },
      ),
    ],
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isLoggedIn = authState is Authenticated;
      final isProfileComplete =
          isLoggedIn && authState.user.isProfileComplete();
      final isOnboardingRoute =
          state.matchedLocation.startsWith(AppRoutes.profilePicture) ||
          state.matchedLocation.startsWith(AppRoutes.userDetails);
      final isLoginRoute = state.matchedLocation == AppRoutes.login;

      if (!isLoggedIn && state.matchedLocation != AppRoutes.signup)
        return AppRoutes.login;
      if (isLoggedIn && !isProfileComplete && !isOnboardingRoute)
        return AppRoutes.profilePicture;
      if (isLoggedIn &&
          isProfileComplete &&
          (isOnboardingRoute || isLoginRoute))
        return AppRoutes.home;
      return null;
    },
  );
}

class SlideTransitionPage<T> extends CustomTransitionPage<T> {
  SlideTransitionPage({super.key, slidingDirection, required super.child})
    : super(
        transitionDuration: const Duration(milliseconds: 100),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Add a curve to the animation
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubic,
          );
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0), // Slide from right
              end: Offset.zero,
            ).animate(curvedAnimation),
            child: child,
          );
        },
      );
}
