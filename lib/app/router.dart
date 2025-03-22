import 'package:eventplanner/core/constants/routes.dart';
import 'package:eventplanner/features/auth/presentation/screens/login_screen.dart';
import 'package:eventplanner/features/auth/presentation/screens/signup_screen.dart';
import 'package:eventplanner/features/onboarding/presentation/screens/profile_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final GoRouter config = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.profilePicture,
        pageBuilder:
            (context, state) =>
                SlideTransitionPage(child: const ProfilePictureScreen()),
      ),
    ],
  );
}

class SlideTransitionPage<T> extends CustomTransitionPage<T> {
  SlideTransitionPage({super.key, required super.child})
    : super(
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Add a curve to the animation
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
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
