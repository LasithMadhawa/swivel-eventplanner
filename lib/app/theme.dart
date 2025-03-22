import 'package:flutter/material.dart';

class AppTheme {
  // Light theme configuration
  static final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFDA5E42),
      primary: const Color(0xFFDA5E42),
    ),
    textTheme: ThemeData.light().textTheme.apply(fontFamily: 'NotoSans'),
    inputDecorationTheme: const InputDecorationTheme(
      border: UnderlineInputBorder(),
      filled: true,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        textStyle: const TextStyle().copyWith(fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle().copyWith(fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      )
    )
  );
}
