import 'package:eventplanner/core/constants/routes.dart';
import 'package:eventplanner/core/models/user_model.dart';
import 'package:eventplanner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eventplanner/features/main_app/home/data/repositories/images_repository.dart';
import 'package:eventplanner/features/main_app/home/data/repositories/organizers_repository.dart';
import 'package:eventplanner/features/main_app/home/presentation/blocs/images/images_bloc.dart';
import 'package:eventplanner/features/main_app/home/presentation/blocs/organizers/organizers_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainAppScreen extends StatefulWidget {
  final Widget child;
  const MainAppScreen({super.key, required this.child});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  ImagesBloc(context.read<ImagesRepository>())
                    ..add(FetchImages()),
        ),
        BlocProvider(create: (context) => OrganizersBloc(context.read<OrganizersRepository>())..add(FetchOrganizers())),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        drawer: _buildDrawer(context),
        bottomNavigationBar: _buildBottomNavBar(context),
        body: widget.child,
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        floatingActionButton: IconButton(onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        }, icon: const Icon(Icons.menu, color: Colors.white,),)
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final UserModel? currentUser =
        authState is Authenticated
            ? (context.read<AuthBloc>().state as Authenticated).user
            : null;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child:
                currentUser == null
                    ? Container()
                    : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            currentUser.profilePictureUrl!,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${currentUser.firstName} ${currentUser.lastName}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                currentUser.email,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
          ),
          TextButton(
            onPressed: () => context.read<AuthBloc>().add(SignOutRequested()),
            child: const Row(
              children: [
                Icon(Icons.logout_outlined),
                SizedBox(width: 8.0),
                Text("Sign Out"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _calculateCurrentIndex(context),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      onTap: (index) {
        _onItemTapped(index, context);
      },
    );
  }

  int _calculateCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith(AppRoutes.home)) return 0;
    if (location.startsWith(AppRoutes.profile)) return 1;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.go(AppRoutes.profile);
        break;
    }
  }
}
