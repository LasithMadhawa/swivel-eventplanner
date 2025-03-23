import 'package:eventplanner/app/router.dart';
import 'package:eventplanner/app/theme.dart';
import 'package:eventplanner/features/auth/data/repositories/auth_repository.dart';
import 'package:eventplanner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eventplanner/features/main_app/home/data/repositories/images_repository.dart';
import 'package:eventplanner/features/main_app/home/data/repositories/organizers_repository.dart';
import 'package:eventplanner/features/user/data/repositories/user_repository.dart';
import 'package:eventplanner/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
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
