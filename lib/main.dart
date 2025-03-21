import 'package:eventplanner/app/router.dart';
import 'package:eventplanner/app/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _router = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Event Planner',
      theme: AppTheme.lightTheme,
      routerConfig: _router.config,
      debugShowCheckedModeBanner: false,
    );
  }
}
