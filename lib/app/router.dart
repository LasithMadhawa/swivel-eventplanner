import 'package:eventplanner/features/auth/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final GoRouter config = GoRouter(
    routes: [
      GoRoute(path: "/", builder: (context, state) => const LoginScreen()),
    ],
  );
}
