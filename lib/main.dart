import 'package:eventplanner/app/router.dart';
import 'package:eventplanner/app/theme.dart';
import 'package:eventplanner/features/auth/data/repositories/auth_repository.dart';
import 'package:eventplanner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eventplanner/features/main_app/home/data/repositories/images_repository.dart';
import 'package:eventplanner/features/main_app/home/data/repositories/organizers_repository.dart';
import 'package:eventplanner/features/main_app/home/data/repositories/posts_repository.dart';
import 'package:eventplanner/features/main_app/home/presentation/blocs/posts/posts_bloc.dart';
import 'package:eventplanner/features/user/data/repositories/user_repository.dart';
import 'package:eventplanner/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final fcmToken = await FirebaseMessaging.instance.getToken(); // Get FCM token
  requestNotificationPermissions(); // Request permission for notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  debugPrint("FCM Token: $fcmToken");
  runApp(MyApp());
}

Future<void> requestNotificationPermissions() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.denied) {
    debugPrint("Notification permission denied.");
  } else {
    debugPrint("Notification permission granted.");
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider(create: (context) => ImagesRepository()),
        RepositoryProvider(create: (context) => OrganizersRepository()),
        RepositoryProvider(create: (context) => PostsRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => AuthBloc(
                  authRepository: context.read<AuthRepository>(),
                  userRepository: context.read<UserRepository>(),
                ),
          ),
          BlocProvider(
            create:
                (context) =>
                    PostsBloc(context.read<PostsRepository>()),
          ),
        ],
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            _router.config.refresh();
          },
          child: MaterialApp.router(
            title: 'Event Planner',
            theme: AppTheme.lightTheme,
            routerConfig: _router.config,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
